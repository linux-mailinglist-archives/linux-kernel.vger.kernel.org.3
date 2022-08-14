Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE375592061
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 17:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiHNPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiHNPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 11:22:30 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3DC65E4;
        Sun, 14 Aug 2022 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1660490541; bh=5yiku09NgtJhz8C8AAOMeXdl/tTwjzjyBlCJ4pl0Sm4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H254bgyaRTEaidBt878YsbVLpkRm0S/3/dv9AHeMBTw9tG5dsi2GdDTxU0Z4yREy/
         q0HQ1aBO9yNBTEROefNFp3Sjaf5nb0PZwpRhKP4aJsjKvDYGH8tVMkTCpJCuHXshSe
         +4qKFDkbm96i9YvlZsK78V7NsRfhPqYgIsWSWHYg=
Received: from [192.168.9.172] (unknown [101.88.24.16])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id D65926061B;
        Sun, 14 Aug 2022 23:22:20 +0800 (CST)
Message-ID: <f76c7bbc-1253-bdda-4d56-8e9185e6f29a@xen0n.name>
Date:   Sun, 14 Aug 2022 23:22:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:105.0) Gecko/20100101
 Thunderbird/105.0a1
Subject: Re: [RESEND] Please consider name next Linux release "I love Linux"
 (Re: Linux 5.19)
To:     Baoquan He <bhe@redhat.com>,
        Zhang Boyang <zhangboyang.id@gmail.com>
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
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220812023950.GF373960@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 10:39, Baoquan He wrote:
> Hi Boyang,
>
> On 08/11/22 at 10:02pm, Zhang Boyang wrote:
>> Hi,
>>
>> On 2022/8/1 05:43, Linus Torvalds wrote:
>>> (*) I'll likely call it 6.0 since I'm starting to worry about getting
>>> confused by big numbers again.
>> Could you please consider name the next Linux release (5.20 or 6.0) "I love
>> linux" ? The number "5.20" is a wordplay in Chinese, which means "I love
>> you" [1], thus "Linux 5.20" can be read as "I love Linux" in Chinese.
>>
>> Even if next kernel version is 6.0, I think it's probably a good idea for
>> both Chinese-speakers and non-Chinese speakers to express our love to Linux
>> Kernel.
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

Woah. This is some of the larger-scale "cultural export" I've ever seen, 
and probably the first time on LKML. I'd remember the few dry laughs 
when I tried to explain the "Superb Owl" meme to my teammates, 
unfamiliar with (US) English memes in general, so I could even 
sympathize with those of you not knowing Chinese Internet memes...

One thing is for sure, if the next Linux version is to be kept 5.20 and 
codenamed "Linux I love you" or something like that, it would certainly 
make headlines on Chinese tech news sites for a while, more specifically 
both after rc1 and the final release; but anyway, as Baoquan already 
pointed out, our collective love for Linux and the open-source ideals 
behind the whole thing is not going anywhere, no matter what the 
Makefile says. (You may find it useful to make your partner happy using 
the 520/521 meme too, if applicable; but from my own experience, better 
not bring up Linux if your partner is not interested in that topic!)

(And, pun semi-intended for that "bringing up". ;-)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

