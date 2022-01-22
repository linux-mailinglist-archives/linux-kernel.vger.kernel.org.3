Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39A4496ADF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiAVIGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:06:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43186 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiAVIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:06:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 439666118A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 08:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB30CC004E1;
        Sat, 22 Jan 2022 08:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642838795;
        bh=c60Zu0xy0PlzQ+AwuKfu4dOWan3Or5E9fQCAiVtygnY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a6VIUAZgBwe2Ki+xLUoQ0E+AM2QCxcGqAbUBGIHGvJsvU1v/oGWHi/Rg6BcvW1X1B
         4dZpBcAuYTatBzW3Gr/VF8ONgg0ePWE9Rd1pxb8iI1485ng0eMmf38OnkCWQtceP4l
         Rpsut+FJ8dJa+fE7BcCnP13Nvea345gAGs3v9G5zXPQFbOR0I459ZzQAnnQCCTv7ok
         c4L3mXSLcs5rrBd4iSeYpEVONVs0NYGNP1/3GIPjhiZxi6hrqorrUEKrdL17jxsrJ0
         X1fhse/tYr9kshGuX1BU3Bh4Rx4u9LFuPFKd3Lf9CMQMH6N6DaIjvnz20clQOWMkdA
         1lqr39dk8aGIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9759BF60796;
        Sat, 22 Jan 2022 08:06:35 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.17 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-c8a6625a-625b-420a-9399-f69d027a43ea@palmer-ri-x1c9>
References: <mhng-c8a6625a-625b-420a-9399-f69d027a43ea@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-c8a6625a-625b-420a-9399-f69d027a43ea@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-mw1
X-PR-Tracked-Commit-Id: c59cd507fb640c2acc6b07cb60d7f765839e18c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7867e402787a23001cfb81ff298b7d023fee676a
Message-Id: <164283879560.17909.6530907772023366710.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 08:06:35 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 09:11:14 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7867e402787a23001cfb81ff298b7d023fee676a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
