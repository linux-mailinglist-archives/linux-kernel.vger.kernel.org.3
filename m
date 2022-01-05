Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A714859F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbiAEUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:20:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35292 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbiAEUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:20:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FFA9618CB;
        Wed,  5 Jan 2022 20:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9DD7C36AE0;
        Wed,  5 Jan 2022 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641414037;
        bh=+p6/6aARwgNrgvWtJNFIfRIwQj44DfT5tRVRvqfPB0I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GRjzFN1H5ePRI6eNdDwMkn9C1G5hHPBQsXef3CR7UGBVTrFsUCNlOkd/PZUuY66ZV
         r1D4m6+qXT1aAwa1FNGi+o+eVgXCiTFY1beJHVBOKsL0nnLJ86f1mL5Fw44mTsCeyY
         jGHnaFmkUHWBUzzaxktmXh2DIE/RZMI5RC1kWCZ+oI5lNLSiA2InNFeq8vpbsGlO8U
         l+7J9vJqNNOwfKjT/MIiG8pzAftPlZC+HY3QisJ0i7IZ4rAu8kmCg4YEd+/OrtkOz4
         9rjNtgOh5ufC0oAv53prGVQLCYr8LPFvFPEVRjDj1xYW5beFbghrKuTMqp0CtQzy5z
         Em4kL+9NKVUxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4906F79408;
        Wed,  5 Jan 2022 20:20:36 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220105140451.200178-1-brgl@bgdev.pl>
References: <20220105140451.200178-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220105140451.200178-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.16
X-PR-Tracked-Commit-Id: 32e246b02f53b2fdaa81ea9f2ca6ff068c017fcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49ef78e59b0749814d79eed156dcfc175fbd2f74
Message-Id: <164141403686.15010.3548239880143343777.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jan 2022 20:20:36 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Jan 2022 15:04:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49ef78e59b0749814d79eed156dcfc175fbd2f74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
