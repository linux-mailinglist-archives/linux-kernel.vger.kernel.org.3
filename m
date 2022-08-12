Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D144590D50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbiHLIXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHLIXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:23:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 261D09BB76;
        Fri, 12 Aug 2022 01:23:13 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.110.237])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxQM_dDfZiDhcPAA--.40391S3;
        Fri, 12 Aug 2022 16:22:54 +0800 (CST)
Message-ID: <27095658-32a8-8012-c533-0b000a3fead3@loongson.cn>
Date:   Fri, 12 Aug 2022 16:22:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RESEND] Please consider name next Linux release "I love Linux"
 (Re: Linux 5.19)
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>, song@kernel.org,
        wei.liu@kernel.org, jszhang@kernel.org,
        Guo Ren <guoren@kernel.org>, xiang@kernel.org, chao@kernel.org,
        ming.lei@redhat.com, Waiman Long <longman@redhat.com>,
        wqu@suse.com, yhs@fb.com, haoluo@google.com, decui@microsoft.com,
        Dave Young <dyoung@redhat.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <61d77412-af1a-5b00-9754-f156b1c63a74@gmail.com>
 <20220812023950.GF373960@MiWiFi-R3L-srv>
 <CAAhV-H7tCsyyNgDJWE5qDCXadF+V6k3GtZtf_yLVj6BZiPND2Q@mail.gmail.com>
 <YvXzr11YP6uwzT0n@B-P7TQMD6M-0146.local>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <YvXzr11YP6uwzT0n@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxQM_dDfZiDhcPAA--.40391S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWxJF13Kw13GFyxuw1rJFb_yoW5ur1DpF
        W7Z3WUKF48Jw1vy3Wvyw1jqF4Fk3yfGr45Xrn8WryDAr1q9r1ft3sFg3yY9as8urn5KFy0
        va1UWr93ZF15Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgEfODUUUU
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/12 14:31, Gao Xiang 写道:
> On Fri, Aug 12, 2022 at 11:28:12AM +0800, Huacai Chen wrote:
>> Hi, all,
>>
>> On Fri, Aug 12, 2022 at 10:40 AM Baoquan He <bhe@redhat.com> wrote:
>>> Hi Boyang,
>>>
>>> On 08/11/22 at 10:02pm, Zhang Boyang wrote:
>>>> Hi,
>>>>
>>>> On 2022/8/1 05:43, Linus Torvalds wrote:
>>>>> (*) I'll likely call it 6.0 since I'm starting to worry about getting
>>>>> confused by big numbers again.
>>>> Could you please consider name the next Linux release (5.20 or 6.0) "I love
>>>> linux" ? The number "5.20" is a wordplay in Chinese, which means "I love
>>>> you" [1], thus "Linux 5.20" can be read as "I love Linux" in Chinese.
>>>>
>>>> Even if next kernel version is 6.0, I think it's probably a good idea for
>>>> both Chinese-speakers and non-Chinese speakers to express our love to Linux
>>>> Kernel.
>>> Interesting idea, LOL.
>>>
>>> Yes, 520 means 'I love you' in chinese since it has the similar pronunciation
>>> with '我爱你'. I even don't remember since when May 20th becomes another
>>> holiday similar to Valentine's day in China. While I have complicated feeling
>>> about 520. It means on each May 20th, I also need prepare gift for my wife. I
>>> am not a romantic person, preparing gift to lover is always a torture to me.
>>> So almost each May 20th day, Valentine's day, double seventh festival which is
>>> a traditional Valentine's day, I will become nervous, and it ends up
>>> with a satisfactory gift, or a bunch of flower and a digital red envelope with
>>> 520￥ and then complainment and blame in next two weeks.
>>>
>>> So, for naming next release as '5.20', I will vote for it w/o hesitance. No need
>>> to prepare gift, and can express our love to Linux kernel, it sounds
>>> awesome.
>>>
>>> Meanwhile, I would remind people to take it easy. Whether the suggestion
>>> is accepted or not, it doesn't impact the fact that linux may have
>>> become part of our life, not just our work, considering many kernel developers
>>> are workoing form home. But if you have boasted to your girlfriend
>>> or wife, and want to take this as a gift to her, you should try harder to
>>> convince Linus.
>>>
>>> Thanks
>>> Baoquan
>> Frankly, I agree with Boyang and Baoquan. :)
> +1, I'm fine with either approach.  If there is a 5.20 version, that is
> fine.
>
> The traditional Valentine's day of China is `Qixi Festival` which is the seventh
> day of the seventh lunisolar month on the Chinese lunisolar calendar [1].
>
> There are also other somewhat special days in China such as `Programmer day`
> (Oct, 24 each year), yet I'm not sure if anyone out of China heard of it.
>
> Personally I think 521 (yi vs ni) sounds more similar to "我爱你" in Mandarin
> Chinese and who knows how many special days for couples -- since I'm single. ;)
>
> [1] https://en.wikipedia.org/wiki/Qixi_Festival

How romantic! I agree to all the abrove.


Thanks,

Yanteng

>
> Thanks,
> Gao Xiang
>
>> Huacai
>>>> The name of Linux kernel release has a long history of play-on-words [2].
>>>> For example, 5.15 is named "Trick or Treat" and 5.17 is named "Superb Owl".
>>>>
>>>> [1] https://en.wikipedia.org/wiki/Chinese_Internet_slang
>>>>
>>>> [2] https://en.wikipedia.org/wiki/Linux_kernel_version_history
>>>>
>>>> Thanks and regards,
>>>> Zhang Boyang
>>>>

