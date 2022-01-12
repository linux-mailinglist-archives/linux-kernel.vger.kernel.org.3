Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0848CBAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbiALTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:13:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59478 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356931AbiALTMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:12:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6317861AA6;
        Wed, 12 Jan 2022 19:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5487C36AEB;
        Wed, 12 Jan 2022 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642014728;
        bh=cnU0gIdY6hPc5Anmye1dTWYDGnl3aYfh+If0vkHMkS8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X49FAF7GyKRcHfbPVeHrg1pWI7P9T5zlprAUSbQvTHIQZhPn7NRHOGq5jkdgdpB8f
         vBSsVc9nAw/lMqHYXB9MKXuaoTNEF8HoIlJYHplBWSJnfYuZtpf6E2nNOjOgUjzIFm
         3nQaNM9uZaksR6dW9JKmV+ornkALRqBVinStEecZtzzyPuq+Lp2WFtZ7JTC6SPsJSg
         WXAf/A9+dQl5oe/1JzLMW6S61gC13ccVbYw2UvsuP6Am5GTXQMTvOuGv+WmGZ0RlYR
         66nJJ+K7hAkP0cCLmTlw6XutLCZpSIZ/Yf2rY2xRYwXmIlb9lRkgvRe3fbxXpOxQEy
         MFCXwvtQCRnbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B39A7F60796;
        Wed, 12 Jan 2022 19:12:08 +0000 (UTC)
Subject: Re: [GIT PULL for v5.17-rc1] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220112064909.1ec47504@coco.lan>
References: <20220112064909.1ec47504@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220112064909.1ec47504@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.17-2
X-PR-Tracked-Commit-Id: 8d4ff8187bb2b0c9025269f0da42ed16c878cb18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ab9c9675fe892e7fe9fa8c0a6125e2b40d2889d
Message-Id: <164201472872.2601.7802897882857989938.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:12:08 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 06:49:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ab9c9675fe892e7fe9fa8c0a6125e2b40d2889d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
