//
//  ViewController.swift
//  StoryCollection
//
//  Created by Wangsc on 2023/5/9.
//

import UIKit
import AVFoundation
import AVFAudio

class ViewController: UIViewController
{
    let synthesizer = AVSpeechSynthesizer()
    var pageIndex = 0
    var storyContentEN = ["\("   ")Do you remember the classic story ＜The Tortoise and the Hare＞ that you often heard when you were a child？\n It comes from Aesop's fables and describes an unfair race between a hare and a tortoise. \n We can tell children the fairy tales we often heard when we were young in English，not only to bring them the inspirations we once received，but also to enhance their familiarity with English. \n Don't worry that the vocabulary in the story will be too difficult and that the child won't learn anything. \n The following stories will have a comparison of Chinese and English，and there will be an introduction of key vocabulary at the end to allow children to learn English while listening to the story.",
                          "  \("   ")A tortoise and a hare live in the forest. One day, a hare meets a tortoise.\n He asks the tortoise, ”Hi, tortoise. What are you doing?” \n “I am running.” The tortoise says.\n “Haha! Running? You are too slow! Let’s have a race. I will show you what running is.” The hare laughs at the tortoise.\n “Ok. I believe I will win.” The tortoise says.\n So they decide to have a race to see who run faster.",
                          "\("   ")In the afternoon, the race begins.\n “Three! Two! One! Go~~~!”\n At first, the hare runs very fast. He sees that the tortoise is far away behind him.\n The hare thinks, “I am so tired. I want to sleep for a while. The tortoise can’t catch me!” So he sleeps under a tree.\n The tortoise crawls and crawls. He sees the hare but he doesn’t stop. He still crawls and crawls.\n When the hare wakes up, he finds the tortoise wins the race."]
    var storyContentTW = ["\("    ")還記得小時候常常聽的經典故事「龜兔賽跑」嗎?\n他是出自於伊索寓言，描述了兔子和烏龜之間的一場不公平的比賽。\n我們可以將小時候常聽得童話故事用英文講給孩子聽，除了可以帶給孩子我們曾經也得到過的啟示外，還可以增進他們對於英文的熟悉度。\n也不用擔心故事的單字會太難，孩子什麼都學不到，下面的故事都會有中英文的對照，讓孩子在聽故事中學英文。","森林裡住著一隻烏龜還有兔子。\n有天兔子碰到了烏龜，然後問他說:「嗨!烏龜~你在做什~麼?」\n「我在跑步呀!」烏龜這麼回答。\n「哈哈哈哈哈哈哈!你在跑步?也太慢了吧。\n要不要來比一場賽跑，我來和你說什麼叫做 跑步。」兔子這樣嘲笑烏龜\n「Ok. 我相信我一定會贏你的」烏龜說道。 \n於是兔子和烏龜決定要比一場賽跑。","\(" ")在下午，比賽開始啦!\n「三!二!一!跑!」\n一開始，兔子跑的非常快，他看見烏龜還是遠遠地在他們後面。\n兔子想說:「我好累喔，還是睡一下下好了，反正烏龜也追不上我!」所以他就在樹下睡 著了。\n烏龜爬呀爬，爬呀爬!他看到了兔子，但他沒有停下來，他來是爬呀爬，爬呀爬。 \n兔子醒來以後，他發現烏龜已經贏了比賽了。" ]
    var images = [UIImage(named: "storyFirst"), UIImage(named: "storyA"), UIImage(named: "storyB")]
    
    //MARK: - IBOutlet
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var LanguageSelection: UISegmentedControl!
    @IBOutlet weak var storyText: UITextView!
    @IBOutlet weak var storyPage: UIPageControl!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //在這裡呼叫updateUI(index:pageIndex)的目的是要在畫面載入後，先顯示第一頁的內容，這樣使用者才會看到一個完整的故事內容。如果不呼叫updateUI，則畫面會是空白的。
        updateUI(index: pageIndex)
    }

   
// MARK: -  更新UI，傳入一個索引值
    private func updateUI(index: Int)
    {
    // 顯示文字
        switch LanguageSelection.selectedSegmentIndex {
        case 0:
            storyText.text = storyContentTW[index]
        case 1:
            storyText.text = storyContentEN[index]
        default:
            break
        }
        
    storyText.textAlignment = .left
    storyText.isEditable = false

    // 顯示圖片
    storyImage.image = images[index]
    storyImage.contentMode = .scaleAspectFill //scaleAspectFill：將圖像縮放以填滿視圖框架，並保持圖像的原始比例。這可能會導致圖像部分被裁剪。

    // 設定分段控制器選擇的位置
    //讓Segment跟著換頁一起動（如果是用這個分頁的話）
    //LanguageSelection.selectedSegmentIndex = index
    // 設定頁面控制器當前頁面的位置
    storyPage.currentPage = index
    }

    //MARK: - 設定Button
    @IBAction func previousButton(_ sender: Any)
    {
        // 計算上一頁的頁數，利用取餘數的方式達到循環的效果
        pageIndex = (pageIndex - 1 + images.count) % images.count //先將 pageIndex 減去 1，表示向前翻一頁；然後加上 images.count，即圖片總數，再取餘數 %，達到循環翻頁的效果。這樣的做法可以確保在第一頁時按上一頁能跳到最後一頁，而在最後一頁時按下一頁能跳到第一頁。
        // 更新UI，顯示當前頁面的圖片
        updateUI(index: pageIndex)
    }
    
    
    @IBAction func nextButton(_ sender: Any)
    {
        // 將pageIndex更新為下一頁，如果已經到最後一頁則回到第一頁
        pageIndex = (pageIndex + 1 ) % images.count
        // 更新UI，顯示當前頁面的圖片
        updateUI(index: pageIndex)
    }
    
    
    @IBAction func storyPage(_ sender: UIPageControl)
    {
        // 取得使用者目前頁面
        // 將pageIndex設為sender元件的currentPage屬性值
        // sender為UIPageControl類型的元件，代表頁面控制器
        // currentPage為UIPageControl類型元件的屬性，代表當前頁面的索引值
        pageIndex = sender.currentPage
        //更新介面，頁面索引為pageIndex
        updateUI(index: pageIndex)
    }
    
    //MARK: - 語言選擇改變時，執行
    @IBAction func languageSelectionDidChange(_ sender: UISegmentedControl)
    {
        let index = storyPage.currentPage   // 取得當前頁面索引
           updateUI(index: index)           // 更新使用者介面
    }
    
    //MARK: - 說故事按鈕
    @IBAction func tellStoryButton(_ sender: UIButton)
    {
        let index = storyPage.currentPage   // 取得當前頁面索引
           updateUI(index: index)
        let content: String
        //如果語言選擇的分段索引為0，則使用中文的故事內容；否則使用英文的故事內容。
        if LanguageSelection.selectedSegmentIndex == 0 {
            content = storyContentTW[index]
        }else{
            content = storyContentEN[index]
        }

        let utterance = AVSpeechUtterance(string: content)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")  // 設定語音合成的語言為台灣
        utterance.rate = 0.5    // 設定語音速度
        utterance.preUtteranceDelay = 0.2   // 設定語音輸出之前的延遲時間
        utterance.postUtteranceDelay = 0.2
        synthesizer.speak(utterance)    // 使用語音合成器發出語音
    }
    
    @IBAction func switchToggled(_ sender: UISwitch)
    {
        if switchButton.isOn {

        }else{
            synthesizer.stopSpeaking(at: .immediate)  //語音合成器停止說話
            switchButton.isOn = true                  //開關按鈕設為開啟狀態
        }

    }
    
    
    
    
}

