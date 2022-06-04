Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B557C53D4FF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350363AbiFDDGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 23:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbiFDDGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 23:06:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F1139177;
        Fri,  3 Jun 2022 20:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58F73B82528;
        Sat,  4 Jun 2022 03:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1227FC385A9;
        Sat,  4 Jun 2022 03:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654311958;
        bh=GPSzhJ8+mqhs9pC9K0QItdDKkxNrZopc3mIrO1hlSG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JNZ8vk7EyGNv+DKtjZvUPMyqX8hRE7PF2royVinsEQLs6+51rvSgW+ar7jnjgN+dU
         7YuvRhaa883a2b0aGpZ9zo0sMyBKlYgiJZ+WWBAzmOaX0DfzRNX+HNl257HtFVwIrC
         F2gEbZ7At3DQhif1HNQSet/mZbjWQ5g/OtNvhjXT8KEjgHRaO5xAROcl6b/1v0HKli
         /HnLIZ2p+KxC/EwlZ7txIROq6MEzdxCA6xkz8OMMx+3zXYVJ5+jDyNCxGxMjRzLoIa
         J3/xgkoL4G5bS7UC+bphrJoLv3ZV6r+SFsPek8lgwjj+lZGGWeai5of5anZ74yL1O9
         A3wu8H8wGEGkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1958F5F173;
        Sat,  4 Jun 2022 03:05:57 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220603142812.66869-1-brgl@bgdev.pl>
References: <20220603142812.66869-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220603142812.66869-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc1
X-PR-Tracked-Commit-Id: 7bb8a0cf49d5fede1104afdcb43bd2f8a1df3253
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 032dcf09e2bf7c822be25b4abef7a6c913870d98
Message-Id: <165431195798.21905.14254725455976227120.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jun 2022 03:05:57 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  3 Jun 2022 16:28:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/032dcf09e2bf7c822be25b4abef7a6c913870d98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
