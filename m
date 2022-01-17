Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFA3490227
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiAQGzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:55:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52546 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiAQGy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:54:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7882C60F2A;
        Mon, 17 Jan 2022 06:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E413EC36AE7;
        Mon, 17 Jan 2022 06:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642402495;
        bh=SCGecgdafApCwzupB08iiGrxCgoSuhJhzGGkAGfTXvs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XR0vWe9E4glcfNvf9gmrUUrhYAENUnRDgK3ZBCDFY+zzenMrl5/SPnXBDwx1ud6ar
         1WBQrbJBL6pfC9eW7BUoaXz2kGUUfY7V/CC4i3P63PO3EI4Vp/RolurldWPSRrX7Tg
         w4MbNEvGbkuQIvhnZXN0N9vOiETlS1TPqibgSHp9fIHk9bg3d6QhpHjc2GNf2WXxAB
         WIlCuMWF8j7EEmXQ+1KcwCOHLAUTDQVGex/vSXfpRROqZ2sABGunhXZW2OQBvFvMXO
         Kgnc+WEhC7pvufb/j2nPzzCkAphc+bLYVPz8c3kblUtk+eKBmpYmqPhqB7Ve9qCgcZ
         qSYO+M0Vd2WuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D221AF60798;
        Mon, 17 Jan 2022 06:54:55 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YeRyfaesC2kxkgZC@ls3530>
References: <YeRyfaesC2kxkgZC@ls3530>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <YeRyfaesC2kxkgZC@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-5.17-1
X-PR-Tracked-Commit-Id: f346f32701ebacf6fe397f6f1d254256f73da321
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c750c7b614322a4ab50be0d57a76addb598d51d
Message-Id: <164240249585.26213.5504565734773316084.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jan 2022 06:54:55 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jan 2022 20:31:09 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c750c7b614322a4ab50be0d57a76addb598d51d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
