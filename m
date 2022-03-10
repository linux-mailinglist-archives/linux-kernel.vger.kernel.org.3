Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189C54D4666
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbiCJMDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241871AbiCJMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:03:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B8E1470EC;
        Thu, 10 Mar 2022 04:02:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88DD4B825BB;
        Thu, 10 Mar 2022 12:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D272C36AE2;
        Thu, 10 Mar 2022 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646913737;
        bh=nDdN/+i8IF30p0Ww1m8xmvlInXFe2y5YNebNbqYFPx4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D4uDRI0alavsRGRvcc9ewvhBAigBQKPIoIYFquBi570fYnD0p4mShl8n70hsfSnAr
         1ULySZYXWUyfYvNffmkKG61WAhhxxKaJE4KPb0zri1CsaHvzAIG8mpGuNda1BohZx4
         VRtkhnfaezUsu7uMZiTOZNLBJk3Fb1OGn6DTGsYtSAvG3L3vS7fZWPkQ2IYhBYqQKa
         aOJUN+xzvHSySj4kYVNtPpQONnqji/uuGnkYRGMVWFiV5KSalJIor/CnBoA1TbPynz
         O775MBOmkYTsdQXmGNv2krBGoeHw08KYhZRy9rlyV5qDBafDajjMg2kj07iTiyNsqG
         eZh5uwmtuQyuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 290A6E6D3DE;
        Thu, 10 Mar 2022 12:02:17 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220310092427.102296-1-brgl@bgdev.pl>
References: <20220310092427.102296-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220310092427.102296-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17
X-PR-Tracked-Commit-Id: 55d01c98a88b346e217eaa931b32e7baea905c9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cef06913a0af21e161a6179a17d3f5fa7132ba46
Message-Id: <164691373715.28854.17505442046357559646.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Mar 2022 12:02:17 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Mar 2022 10:24:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cef06913a0af21e161a6179a17d3f5fa7132ba46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
