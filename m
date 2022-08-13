Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A72591C1D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiHMRRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiHMRR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:17:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72072D128;
        Sat, 13 Aug 2022 10:17:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f28so3512600pfk.1;
        Sat, 13 Aug 2022 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fZq0tsLjckIATEZod0UqOH8Li37YtZh0O0Zvslb7V84=;
        b=FPAeGh9swZHrroFFQ2P+Xl+nAkTgkKRtBKEyo/tBHjfoNCRDIce3Mj+/VrU0qUshLg
         clHtCq9oBWL63Ox8CgkvqJ2i3FImwrAEVTYK8lfU+LbOtecScC64934/JrKJxTLszZLd
         jMZFfU/kMci+GmgE6ZzmNvp0J/ktSEFcbZbsIYhTcst0B9fFn+KtcH644donJkIix2Y+
         CiOMD5hvFS2qNjgepibTJigDBQDC7bw8ICphHtZu5pEekHPeyVCe0/wYwZyIRAy7exKi
         37UPUcvtdHzrwaRUDr4f6hBPLZ5Uiz9LhVVD/S8RS2ZKBVakF6+48DWXXryVbyZTu/UA
         6bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fZq0tsLjckIATEZod0UqOH8Li37YtZh0O0Zvslb7V84=;
        b=cnpO0cteswrFFeTJu8h/Db2XzdoSki3thxXxuhbpWxRaL+f3E6cZeMy/ody7s6z7vc
         OFkKc2VFe5DdhNBez4deu85joy9WK4x4h5Vb/12z3B8lxaTMdH+OhGef4wdKx8DDLsEm
         BMyMViznPtkSAptpvMCr5NXkw7X++hK2wRUvVZIPixPhapeNtwbvyI3+rV0NGa3cxYcv
         kbHXzIyuSgiWC22ABZBAVW3NEvx0xMqgFJh2b5Mw9v+MBmgSppCfdcHaEkb1ngI4jYSm
         rrkl1W++IHfGtB04WdyYunDN1jFJMPO/DHMwHLXe7usbjJkxy1uouWSPCf9DX7tWRczm
         6TBw==
X-Gm-Message-State: ACgBeo0UDBvFBDEFP2rlOQyXsmDHv9441Dyh+jsbG6kIvQpag9fBzUwO
        L66yt9+fkTSSAOMrwcHB+a4=
X-Google-Smtp-Source: AA6agR7kibi9AMDXU0QOLAmOG2oLUJ1EUo8PtJv6d3kGZBI4wh0YMepa99YF8mWvREiSBrtYGyOJGQ==
X-Received: by 2002:a65:5644:0:b0:41c:5b91:9ba with SMTP id m4-20020a655644000000b0041c5b9109bamr7448789pgs.553.1660411046563;
        Sat, 13 Aug 2022 10:17:26 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id d15-20020aa797af000000b0052e0fd762c5sm3971515pfq.14.2022.08.13.10.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 10:17:26 -0700 (PDT)
Message-ID: <f2e9d299-c051-8c6a-2824-a1501a428f3f@gmail.com>
Date:   Sun, 14 Aug 2022 01:17:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RESEND] Please consider name next Linux release "I love Linux"
 (Re: Linux 5.19)
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, song@kernel.org, wei.liu@kernel.org,
        jszhang@kernel.org, chenhuacai@kernel.org, guoren@kernel.org,
        xiang@kernel.org, chao@kernel.org, ming.lei@redhat.com,
        longman@redhat.com, wqu@suse.com, yhs@fb.com, haoluo@google.com,
        decui@microsoft.com, siyanteng@loongson.cn, dyoung@redhat.com
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <61d77412-af1a-5b00-9754-f156b1c63a74@gmail.com>
 <20220812023950.GF373960@MiWiFi-R3L-srv>
From:   Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <20220812023950.GF373960@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/12 10:39, Baoquan He wrote:
> Hi Boyang,
> 
> On 08/11/22 at 10:02pm, Zhang Boyang wrote:
>> Hi,
>>
>> On 2022/8/1 05:43, Linus Torvalds wrote:
>>> (*) I'll likely call it 6.0 since I'm starting to worry about getting
>>> confused by big numbers again.
>>
>> Could you please consider name the next Linux release (5.20 or 6.0) "I love
>> linux" ? The number "5.20" is a wordplay in Chinese, which means "I love
>> you" [1], thus "Linux 5.20" can be read as "I love Linux" in Chinese.
>>
>> Even if next kernel version is 6.0, I think it's probably a good idea for
>> both Chinese-speakers and non-Chinese speakers to express our love to Linux
>> Kernel.
> 
> Interesting idea, LOL.
> 
> Yes, 520 means 'I love you' in chinese since it has the similar pronunciation
> with '我爱你'. I even don't remember since when May 20th becomes another
> holiday similar to Valentine's day in China. While I have complicated feeling
> about 520. It means on each May 20th, I also need prepare gift for my wife. I
> am not a romantic person, preparing gift to lover is always a torture to me.
> So almost each May 20th day, Valentine's day, double seventh festival which is
> a traditional Valentine's day, I will become nervous, and it ends up
> with a satisfactory gift, or a bunch of flower and a digital red envelope with
> 520￥ and then complainment and blame in next two weeks.
> 
> So, for naming next release as '5.20', I will vote for it w/o hesitance. No need
> to prepare gift, and can express our love to Linux kernel, it sounds
> awesome.
> 
> Meanwhile, I would remind people to take it easy. Whether the suggestion
> is accepted or not, it doesn't impact the fact that linux may have
> become part of our life, not just our work, considering many kernel developers
> are workoing form home. But if you have boasted to your girlfriend
> or wife, and want to take this as a gift to her, you should try harder to
> convince Linus.
> 

Yes, I think so. Linus may be too busy to respond, so let's take it easy 
and let him focus on his work. :)

> Thanks
> Baoquan
> 
>>
>> The name of Linux kernel release has a long history of play-on-words [2].
>> For example, 5.15 is named "Trick or Treat" and 5.17 is named "Superb Owl".
>>
>> [1] https://en.wikipedia.org/wiki/Chinese_Internet_slang
>>
>> [2] https://en.wikipedia.org/wiki/Linux_kernel_version_history
>>
>> Thanks and regards,
>> Zhang Boyang
>>
> 
