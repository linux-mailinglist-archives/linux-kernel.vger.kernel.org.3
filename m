Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17D502E80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbiDOSBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240532AbiDOSBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:01:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4743DB493
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:58:53 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nfQDZ-0004Kh-JT; Fri, 15 Apr 2022 19:58:49 +0200
Message-ID: <afd1eeb8-0291-d891-c6f4-022f243a9a72@leemhuis.info>
Date:   Fri, 15 Apr 2022 19:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
 #forregzbot
Content-Language: en-US
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     regressions@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <1648659326.eabkokyuym.none.ref@localhost>
 <1648659326.eabkokyuym.none@localhost>
 <9e3c47e0-6807-081d-feb7-ed7c5fe1d1f1@leemhuis.info>
In-Reply-To: <9e3c47e0-6807-081d-feb7-ed7c5fe1d1f1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1650045533;61358a03;
X-HE-SMSGID: 1nfQDZ-0004Kh-JT
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

#regzbot fixed-by: 4fe87e818ea492ade079cc0

On 31.03.22 08:51, Thorsten Leemhuis wrote:
> [TLDR: I'm adding the regression report below to regzbot, the Linux
> kernel regression tracking bot; all text you find below is compiled from
> a few templates paragraphs you might have encountered already already
> from similar mails.]
> 
> Hi, this is your Linux kernel regression tracker. Sending this just to
> the lists, as it's already handled.
> 
> On 30.03.22 19:51, Alex Xu (Hello71) wrote:
>>
>> After a recent kernel update, booting one of my machines causes it to 
>> hang on a black screen. Pressing Lock keys on the USB keyboard does not 
>> turn on the indicators, and the machine does not appear on the Ethernet 
>> network. I don't have a serial port on this machine. I didn't try 
>> netconsole, but I suspect it won't work.
>>
>> Setting mem_encrypt=0 seems to resolve the issue. Reverting f5ff79fddf0e 
>> ("dma-mapping: remove CONFIG_DMA_REMAP") also appears to resolve the 
>> issue.
>>
>> The machine in question has an AMD Ryzen 5 1600 and ASRock B450 Pro4.
> 
> To be sure below issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, my Linux kernel regression tracking bot:
> 
> #regzbot ^introduced f5ff79fddf0e
> #regzbot title dma: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD
> SME boot fail
> #regzbot ignore-activity
> 
> If it turns out this isn't a regression, free free to remove it from the
> tracking by sending a reply to this thread containing a paragraph like
> "#regzbot invalid: reason why this is invalid" (without the quotes).
> 
> Ciao, Thorsten
