Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494AF4E7D41
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiCYVIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiCYVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:08:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2887A1EC60E;
        Fri, 25 Mar 2022 14:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDB7BB829E7;
        Fri, 25 Mar 2022 21:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 850E2C004DD;
        Fri, 25 Mar 2022 21:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648242417;
        bh=/gzkPSO1hMYGhjETfIaRh7tvmL2QyHGKMO2BKZfT+Nk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H1sjVNvnQPpxzvM3AesxNvMOk3/qB3JBd/Gqzwai6ZHuYJRw4chH6Jhv4b8bf+QBx
         aHMBZJnxV3eVuSjn0QkFtVrkE3divIZ/v3VE6HaqX9ZDF7H6b5zTODheQ/BbNGe6ln
         fYZgp2/aSFYxicajGb2kYBSNBWdtzR4s0VtoAc9yPFCC/uXf1HyUoDvNpEBHP2GNRF
         Y8kxUrAJ437MAK5qU1OFqkB9xK/LF/dahI7WGlL3foxLpvukD742UTRgQMxnz06yej
         e9CyMoaNUa8KPrvMpqvtf93zZypKuxQ2kt/+Zx3z+4hoWMf+QyEwr8nn1qqqmuhS8d
         kbFzER1oyge+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 718EEE6BBCA;
        Fri, 25 Mar 2022 21:06:57 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220323163230.691802-1-brgl@bgdev.pl>
References: <20220323163230.691802-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220323163230.691802-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v5.18
X-PR-Tracked-Commit-Id: 87ba5badc541a79bab2fa3243ee0008c0880c64a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebcb577aee1448fd60904fc4126cbf7ec012bd0b
Message-Id: <164824241746.8431.10429637770703695319.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 21:06:57 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 17:32:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebcb577aee1448fd60904fc4126cbf7ec012bd0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
