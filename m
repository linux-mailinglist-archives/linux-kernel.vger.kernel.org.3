Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1214EE97F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiDAIIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiDAIIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:08:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2701C267590;
        Fri,  1 Apr 2022 01:06:23 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1naCIX-0001XJ-Is; Fri, 01 Apr 2022 10:06:21 +0200
Message-ID: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
Date:   Fri, 1 Apr 2022 10:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Marco <rodomar705@protonmail.com>
Subject: Bug 215744 - input from the accelerometer disappeared, regression on
 amd_sfh on kernel 5.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648800383;b40de995;
X-HE-SMSGID: 1naCIX-0001XJ-Is
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported about a week ago, that's why I decided
to forward it to the lists and all people that seemed to be relevant
here. It looks to me like this is something for Basavaraj, as it seems
to be caused by	b300667b33b2 ("HID: amd_sfh: Disable the interrupt for
all command"). But I'm not totally sure, I only looked briefly into the
details. Or was this discussed somewhere else already? Or even fixed?

To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215744 :

>  Marco 2022-03-25 15:22:19 UTC
> 
> After updating to 5.17, the input from the accelerometer disappeared, completely. No devices available from IIO tree. First bad commit causing it is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c?id=b300667b33b2b5a2c8e5f8f22826befb3d7f4f2b. Reverting this and the the other two on top fixed this. Tried to not revert only the above mentioned commit, but it's still not working.
> 
> Marco.

Anyway, to get this tracked:

#regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb3d7f4
#regzbot from: Marco <rodomar705@protonmail.com>
#regzbot title: input: hid: input from the accelerometer disappeared due
to changes to amd_sfh
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215744

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
