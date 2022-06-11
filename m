Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BADD5474FE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiFKNxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiFKNxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:53:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC33F88F;
        Sat, 11 Jun 2022 06:53:46 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o01Ye-0006jb-NG; Sat, 11 Jun 2022 15:53:44 +0200
Message-ID: <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
Date:   Sat, 11 Jun 2022 15:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: regression, 5.19.0-rc1 not powering off when hibernated
Content-Language: en-US
To:     Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <YqE22nS9k2+AldI6@llamedos.localdomain>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux PM <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <YqE22nS9k2+AldI6@llamedos.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1654955626;91ad4d5f;
X-HE-SMSGID: 1o01Ye-0006jb-NG
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
Also CCing the hibernation maintainers and Linux-pm.

On 09.06.22 01:55, Ken Moffat wrote:
> Up to 5.18.0 hibernation has worked ok on my ryzen 5 3400G : screen
> blanks, disk activity for the write to swap, screen briefly has a
> trashed display, machine powers off.  When powering up from
> hibernation, after the saved files are loaded X starts with a
> briefly trashed display before my desktop reappears.
> 
> But with 5.19.0-rc1 the screen is blank throughtout the hibernation,
> and briefly when restoring (no complaint about that), but when
> hibernating it no longer powers off and I have to hold the on/off
> switch to power off.
> 
> Is this a known problem ?

Thanks for the report. Maybe the hibernation maintainers might know, but
often issues like this are caused by other things like drivers. If they
don#t have a idea, you likely need to do a bisection to get down to the
change that introduced this regressions.

Anyway: To be sure below issue doesn't fall through the cracks
unnoticed, I'm adding it to regzbot, my Linux kernel regression tracking
bot:

#regzbot ^introduced v5.18..v5.19-rc1
#regzbot title hibernate: Not powering off when hibernated
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replied to), as the kernel's
documentation call for; above page explains why this is important for
tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
