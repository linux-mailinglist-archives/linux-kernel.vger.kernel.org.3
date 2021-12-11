Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE72D470FF3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 02:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbhLKBmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 20:42:35 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55018 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345591AbhLKBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 20:42:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1BB8CE2E80;
        Sat, 11 Dec 2021 01:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07CDAC341C8;
        Sat, 11 Dec 2021 01:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639186731;
        bh=g0F0FGgGYQzvpxtTVJJ3B3/RPgxFC/xg1lxTcHnfXow=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CQRGpnMWUlyWoz/q50bVX1Haz3mEmD7x3DL+uc5f8gsebZCcsyIBN7qxJS1nyTS/X
         s11N5c6v3zFdaw7jCanpcPMr9v3u4QBBJrXwzj2BdZXadskcENOoxbOPAfKvcN+E5U
         S0HpEaY00xZW0QcihqHnS4lqCl0UmKm/9g2PCECfHetsrClaUDzB3qROrxsm0BLz7B
         Rayj34iri5wa7N1ub9070go70oYXdksGgRHHiXfZCWjZTBWS0+JJcP/Jhh/Z4rxXCM
         MOwAIhbT+XoqwUisosuEUy7jVHIj3KgAkgiG+kdXrny15Iy0vA2rhNj8I7nidM9VjT
         NlVhv1svM70hw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ED5A060A36;
        Sat, 11 Dec 2021 01:38:50 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hpgZ76wUgAuuzcjCdxjpBWAEtruTtXN6eqsDdYdpS8Hw@mail.gmail.com>
References: <CAJZ5v0hpgZ76wUgAuuzcjCdxjpBWAEtruTtXN6eqsDdYdpS8Hw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hpgZ76wUgAuuzcjCdxjpBWAEtruTtXN6eqsDdYdpS8Hw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.16-rc5
X-PR-Tracked-Commit-Id: f872f73601b92c86f3da8bdf3e19abd0f1780eb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9902641b50d8606dbc2832888a27a40cdea73c9
Message-Id: <163918673096.12736.2056460516239881678.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Dec 2021 01:38:50 +0000
To:     =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 21:11:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9902641b50d8606dbc2832888a27a40cdea73c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
