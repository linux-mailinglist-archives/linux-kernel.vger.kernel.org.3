Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8854780D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 02:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiFLAds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 20:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiFLAdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 20:33:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95063DDEE;
        Sat, 11 Jun 2022 17:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AB57B80B79;
        Sun, 12 Jun 2022 00:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 525EAC3411B;
        Sun, 12 Jun 2022 00:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654994020;
        bh=9actvzeP9E9BtqMCDJa6qfM8tsFYQCI0oi4tQpnwlgs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fSBUUBHEt8RDSMJ6SRDaXMAhRGBl4hY//Whal7aUxdngXNacguVsqOgZM9DlnDRTb
         7hRTNV+IIPgGTbgOx4rJm5eT+kWCl6odcusWiCWbyu5Usgj5Ah7sDrZmd0VynC+ur+
         0GDWinukFaBpAAo7Crgvcn5DSizlM1cTJaPg+uAL8PxxC9CE3n9d7P/nmm3Y25tMtD
         k+pIrniGpVbJqwpxQkvMFHUv8P0vvuSjxuWywbHDgFb1NPcxwtGuMJ0RsQK+/z7FbZ
         3qP0wxwG7zaToS2yVrikWp0q/6L8lvOEVNMSjXkKizsETp0NEgcpCUq3DhFGwBlLUP
         f8oUgCJ1+0aPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C9D3E737E8;
        Sun, 12 Jun 2022 00:33:40 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220611202732.6602-1-brgl@bgdev.pl>
References: <20220611202732.6602-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220611202732.6602-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc2
X-PR-Tracked-Commit-Id: 77006f6edc0e0f58617eb25e53731f78641e820d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0
Message-Id: <165499402024.23172.2460418025872044620.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jun 2022 00:33:40 +0000
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

The pull request you sent on Sat, 11 Jun 2022 22:27:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
