Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0D5A0F71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiHYLku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiHYLk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:40:29 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E785245A;
        Thu, 25 Aug 2022 04:40:28 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oRBDm-0006Sb-Ru; Thu, 25 Aug 2022 13:40:26 +0200
Message-ID: <2ebb4b04-efe7-ffe8-bf8c-bfc08685eb57@leemhuis.info>
Date:   Thu, 25 Aug 2022 13:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [regression] Bug 216386 - rtw_8822be: Wifi stops working after
 resume #forregzbot
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <822ed6b6-fd3a-3873-cdf0-543340fd4103@leemhuis.info>
In-Reply-To: <822ed6b6-fd3a-3873-cdf0-543340fd4103@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661427628;9b4fbbc2;
X-HE-SMSGID: 1oRBDm-0006Sb-Ru
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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

On 25.08.22 13:25, Thorsten Leemhuis wrote:
> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216386 :
> 
>>  Utkarsh Verma 2022-08-20 09:16:41 UTC
>>
>> I have an ASUS TUF FX505DT which has the RTL8822BE wifi card. I recently upgraded to kernel 5.19 and this issue started popping up.
>>
>> When I close my laptop lid and let it sleep for a considerable amount of time, the wifi stops working the next time I open it, and I have to reboot my PC to get internet. This is annoying because I suspended my PC to continue with my work after some time quickly, and having to reboot defeats the purpose.
>>
>> I tried removing and reloading the kernel module for this device as well, and it fails with the following dmesg log.
>>
>> ```
>> [ 4914.877037] rtw_8822be 0000:04:00.0: Unable to change power state from D3cold to D0, device inaccessible
>> [ 4914.886333] rtw_8822be 0000:04:00.0: mac power on failed
>> [ 4914.886342] rtw_8822be 0000:04:00.0: failed to power on mac
>> [ 4914.886344] rtw_8822be 0000:04:00.0: failed to setup chip efuse info
>> [ 4914.886348] rtw_8822be 0000:04:00.0: failed to setup chip information
>> [ 4914.892027] rtw_8822be 0000:04:00.0: Firmware version 27.2.0, H2C version 13
>> [ 4914.922150] rtw_8822be: probe of 0000:04:00.0 failed with error -114
>> ```
> 
> #regzbot introduced: https://bugzilla.kernel.org/show_bug.cgi?id=216386
> #regzbot ignore-activity

Argh, apparently I forgot the appropriate syntax of the bot I wrote
myself :-/

#regzbot introduced: v5.18..v5.19 ^
https://bugzilla.kernel.org/show_bug.cgi?id=216386
#regzbot From: Utkarsh Verma <utkarsh.naveen@gmail.com>
#regzbot ignore-activity
