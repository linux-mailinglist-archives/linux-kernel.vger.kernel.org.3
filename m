Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0CC5AC28C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiIDEgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiIDEgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF374054E;
        Sat,  3 Sep 2022 21:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CC9D60EB6;
        Sun,  4 Sep 2022 04:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0126EC433D6;
        Sun,  4 Sep 2022 04:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662266169;
        bh=BZYyvNs0rdd/HyJ66oijHyUXWWHZIEfC+VpY3HAH5zU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jH9JGceZxNShJvdI07Xmf3rdvQxvmtoQb6Rr2JW8QVWySpmqHLTCD63ET6U930QB1
         EHsZd2rhnGBzW1+ZcWWEGkWyZDfp+7qm/j6MzXaiPsf+emqTGRY97ctBJuo00B/NcW
         t8jOUYfOXvYXsyJNb45cZFxuNi79wFkY8dQGVs/bH4x333pndfuMV5Fygz0i1M3Ar0
         Tsg6W+c0dsAUO5SyIs+1mbrwVmqSFRPAivrNhcdc7B1U/aehyM84zmJZMqjMK0xdgl
         QsIC9SpJWY93BEXtpZgmVR+VWye2BzcHzmM3uN760ELOPAonCcfKISjn1Y5qQFHHV5
         8wrKuM7lEaQMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0A72C4166F;
        Sun,  4 Sep 2022 04:36:08 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220903210956.6008-1-brgl@bgdev.pl>
References: <20220903210956.6008-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220903210956.6008-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.0-rc4
X-PR-Tracked-Commit-Id: 6890381720b27a41f2d9e68cce241336342ea3b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7726d4c3e60bfe206738894267414a5f10510f1a
Message-Id: <166226616891.7721.477555874654123023.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Sep 2022 04:36:08 +0000
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

The pull request you sent on Sat,  3 Sep 2022 23:09:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7726d4c3e60bfe206738894267414a5f10510f1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
