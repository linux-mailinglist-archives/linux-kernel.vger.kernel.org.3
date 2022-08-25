Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654775A0E18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiHYKm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiHYKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:42:53 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F39661D6B;
        Thu, 25 Aug 2022 03:42:52 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oRAK2-0007E0-V5; Thu, 25 Aug 2022 12:42:51 +0200
Message-ID: <849a07ba-a53c-3f10-e2ec-25421c1e40ee@leemhuis.info>
Date:   Thu, 25 Aug 2022 12:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
Cc:     hi2@n101n.xyz,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [Regression] Bug 216371 - acpi wake up with black screen with msg
 "amd_gpio AMDI0030:00: failed to get iomux index"
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661424172;b4e53687;
X-HE-SMSGID: 1oRAK2-0007E0-V5
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

To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216371 :

>  neoe 2022-08-17 01:50:41 UTC
> 
> just upgrade from 5.18 to 6.0.0-rc1
> 
> `acpitool -s` 
> to set to sleep, it seems a little slow.
> 
> then wake up, black screen,
> 
> everything works fine before.
> 
> AMD 3900X
> 
> [reply] [−] Comment 1 neoe 2022-08-22 02:39:12 UTC
> 
> dmesg
> 
> amd_gpio AMDI0030:00: failed to get iomux index
See the ticket for details.

Please look into the issue if you're among the main recipients of this
mail (and not just CCed). I hope I picked the right people to sent this
to, if not, just let everyone know (and apologies!). Basavaraj, unless
my quick analysis of the situation went haywire it seems that you
recently added code with the error message noticed by the reporter.

Anyway, to ensure this is not forgotten lets get this tracked by the the
Linux kernel regression tracking bot:

#regzbot introduced: v5.19..v6.0-rc2
https://bugzilla.kernel.org/show_bug.cgi?id=216371
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
