Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9774C5078
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiBYVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiBYVTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:19:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A71F0392;
        Fri, 25 Feb 2022 13:18:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05EBFB83398;
        Fri, 25 Feb 2022 21:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0231C340E7;
        Fri, 25 Feb 2022 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645823905;
        bh=qXWus0h/EwOAjtC/+iTs+pItL27tspqFz1PxRtWbVVY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=REmrqIirr66mAllpaLsZ3EK3XqSkGKyE3IbU4Kkig+PEHkTgohP+3XZ1qUGcZhPLG
         WkA1+UqaHGQ9P9iutNwuiRvv/A29+wNCITaZ1sK4QACtGIwT33zBiQ03r7jWiCBSZ1
         WIQ+tNXdsXeeRtSMZfk+1S2JNInNgn7tSNd1LXKIPxeNyWmTQC/KvmsFevNyjJTj1u
         th1K+pZFPVhKuMrc9gdbnENiTnhlC1awMOyy04g1EUSVF7575198w4hTyywdJ73C8b
         /zdWWc7g68EOJwD0Iae7yi3yAHYCQ2q0+b40FfBDp5oBNOBDZ5DLAqotbAQxu9En9B
         LkGZS9egLTh3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A98EE6D4BB;
        Fri, 25 Feb 2022 21:18:25 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220225204202.53415-1-brgl@bgdev.pl>
References: <20220225204202.53415-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220225204202.53415-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17-rc6
X-PR-Tracked-Commit-Id: ae42f9288846353982e2eab181fb41e7fd8bf60f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 115ccd2278ccaa882000a20cb81a3649ef7dfe8b
Message-Id: <164582390556.13587.15891944624488053567.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 21:18:25 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 21:42:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/115ccd2278ccaa882000a20cb81a3649ef7dfe8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
