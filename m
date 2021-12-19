Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455A147A211
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhLSUe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:34:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44554 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhLSUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:34:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DFF560ECF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 20:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C926FC36AE7;
        Sun, 19 Dec 2021 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639946063;
        bh=x2folR660B/9ul6aa2ZFzNxTYts0I7yy9MM5FTDiNsw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TR/Si2ilvN0DqV+t0cx7PKaZp6169ZxYclTTOxNJ9jDF/7WPz2rhjINe1a51NGs/l
         wMt2/yKTXpxCivU15pFsc/+8L9hu6gGsxPthijMClQLzfJ6Rlagc9MgoQfT0EFhEnd
         MTUun5iSP/xJCAQthc/gtUwBaIC54GbsUQQlU2pkd9G5PWLJMhhwMUhIn0vmKogAQd
         uqTY6RClRFMWA3YRz643ijkzHUiPOnbzn2OtxE4sowM1PvLS/iiX48VRUnoqwD8TYi
         FC1qqNUhM/17nlCptH4vRnbOoIZTlaU10mDCcusA3TuqwSgBL7/I0eY7YLVVt+euGI
         2Ct2vOkx/s6aA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A6CEF60A27;
        Sun, 19 Dec 2021 20:34:23 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lf0hl06g.fsf@mpe.ellerman.id.au>
References: <87lf0hl06g.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87lf0hl06g.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-4
X-PR-Tracked-Commit-Id: 8734b41b3efe0fc6082c1937b0e88556c396dc96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 713ab911f2cd5ef00b5072aacd84bd93a444ae12
Message-Id: <163994606362.11038.11036779168389391211.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Dec 2021 20:34:23 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        nixiaoming@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Dec 2021 14:53:59 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/713ab911f2cd5ef00b5072aacd84bd93a444ae12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
