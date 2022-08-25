Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E265A0EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbiHYLZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241516AbiHYLZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:25:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A1F59F;
        Thu, 25 Aug 2022 04:25:10 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oRAyx-0007pK-9U; Thu, 25 Aug 2022 13:25:07 +0200
Message-ID: <822ed6b6-fd3a-3873-cdf0-543340fd4103@leemhuis.info>
Date:   Thu, 25 Aug 2022 13:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
Cc:     Utkarsh Verma <utkarsh.naveen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>
Subject: [regression] Bug 216386 - rtw_8822be: Wifi stops working after resume
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661426712;52236dad;
X-HE-SMSGID: 1oRAyx-0007pK-9U
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported. That's why I decided to forward it by
mail to those that afaics should handle this.

To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216386 :

>  Utkarsh Verma 2022-08-20 09:16:41 UTC
> 
> I have an ASUS TUF FX505DT which has the RTL8822BE wifi card. I recently upgraded to kernel 5.19 and this issue started popping up.
> 
> When I close my laptop lid and let it sleep for a considerable amount of time, the wifi stops working the next time I open it, and I have to reboot my PC to get internet. This is annoying because I suspended my PC to continue with my work after some time quickly, and having to reboot defeats the purpose.
> 
> I tried removing and reloading the kernel module for this device as well, and it fails with the following dmesg log.
> 
> ```
> [ 4914.877037] rtw_8822be 0000:04:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [ 4914.886333] rtw_8822be 0000:04:00.0: mac power on failed
> [ 4914.886342] rtw_8822be 0000:04:00.0: failed to power on mac
> [ 4914.886344] rtw_8822be 0000:04:00.0: failed to setup chip efuse info
> [ 4914.886348] rtw_8822be 0000:04:00.0: failed to setup chip information
> [ 4914.892027] rtw_8822be 0000:04:00.0: Firmware version 27.2.0, H2C version 13
> [ 4914.922150] rtw_8822be: probe of 0000:04:00.0 failed with error -114
> ```

See the ticket for details and further comments.

Please look into the issue if you're among the main recipients of this
mail (and not just CCed). I hope I picked the right people to sent this
to, if not just let everyone know.

Anyway, to ensure this is not forgotten lets get this tracked by the the
Linux kernel regression tracking bot:

#regzbot introduced: https://bugzilla.kernel.org/show_bug.cgi?id=216386
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report in bugzilla, as the kernel's documentation calls
for; above page explains why this is important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
