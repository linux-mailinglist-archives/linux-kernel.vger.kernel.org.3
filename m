Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31D48B8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbiAKUyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244667AbiAKUxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8086C03400E;
        Tue, 11 Jan 2022 12:53:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94C961743;
        Tue, 11 Jan 2022 20:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C4C4C36AF2;
        Tue, 11 Jan 2022 20:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934391;
        bh=asAEZOqrqXTvSy1+BE5lgzqds28z0SNUfy/Ll6NOxOw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CpqCHHlevDlZAVbFq2yfLl6vay1Pz22XeeiNjwB+sG8JHW1eSWrkPGvpUaUjhGPSl
         WV8X9DYl/IEwLRTV0wgXfuKqe/9C4737C00Im/agBBJg8lNBulkfEtTlf1sOzF1UbZ
         v/SWG+aUpO4SEzMwg3g7DKG5wS1RUpTRZRs073f7vzhwlBvwQqECjpM3iPc4Rtc0cc
         8YdFzZV1lc/6GQ06gFUiM42vmNrf4dQSB+3dBq99Q0x6+KPwTf31vmFJ4/b2wxHdX3
         Dzs9Sx4oaCBd5ueXB0r6Urww+bv0UmFqWUjawzJw8/8wg3l3dQWUyvIE+0aUh/cw3g
         6E/LyzQjAE2Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B027F6078C;
        Tue, 11 Jan 2022 20:53:11 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220111155255.745428-1-brgl@bgdev.pl>
References: <20220111155255.745428-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220111155255.745428-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v5.17
X-PR-Tracked-Commit-Id: ffe31c9ed35d70069ee76d6b6d41ac86a17d7a07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c288ea679840de4dee2ce6da5d0f139e3774ad86
Message-Id: <164193439110.11435.11682172668060736205.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:11 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 16:52:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c288ea679840de4dee2ce6da5d0f139e3774ad86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
