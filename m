Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F1048B8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiAKUx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244116AbiAKUxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284FC033241
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:53:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 035DEB81D56
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCF08C36AE9;
        Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934390;
        bh=MDqumbSQCLp1zzp3hjElL1bS5ijCs9lPeenCMPeGSVw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iDX5H0GKvgA6R/gfr5rb/r+f/9Hci1ylyHlbie4tOY9aMufK+9uweWJ5jjDesFzEy
         ibPy3asd6N9Ww0tBVuqWMpxZ8wA4xrTsWFMDn5gQtG3uWar7Ibz+oCr4SGLOeiZwRe
         ATqWZ2pgL6kELvAmqGPZE7INn84lQJTwEDwDK0B1WDSlwZYN4qI2TtiuqomEXOSz14
         WbM4SRDQ7CYElMa9mlFrg9QmaVZLELUwdupfdPD6RrWZqkFJRv4CKUAc7RDsSD5zo6
         cyrUw5fI7vAQxWwmszZDHqvFqq5uWesqoKQMF0bewFdpkgzxe2cW6QSQL8Qc1PD+zT
         ruZ42/OwyN76Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAE7BF6078C;
        Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd1+NuCAGxhsFNR6@google.com>
References: <Yd1+NuCAGxhsFNR6@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd1+NuCAGxhsFNR6@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.17
X-PR-Tracked-Commit-Id: ec961cf3241153e0f27d850f1bf0f172e7d27a21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cc8d14c412cfb6c4eaad4453c557ff289506741
Message-Id: <164193439075.11435.3422754685880661096.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:10 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 12:55:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cc8d14c412cfb6c4eaad4453c557ff289506741

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
