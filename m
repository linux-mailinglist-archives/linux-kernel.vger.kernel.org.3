Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5948B8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244615AbiAKUyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:54:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43442 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbiAKUxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB52EB81D55
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C554C36AE3;
        Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934390;
        bh=tkfT4Kqr6T1Gi+tTDRHEd9KTcQJodTzuiEFCHpWtheM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cyUuH30mBitoOHlz11lbDktvPwzgeMZweNl3Ss8GcUPczy3XjnKzQrjHxCEAPt6lz
         qlo+ttjcTZBoMB3rVJBKZ5STfZ/QR7qoCREsc64cG3vPYc8pngzPl08oAMtMKFfQFo
         dNTgRhpXUBZXXrbOqJsEyqqx59RikbBA723rEoYTpRqkB3RiZGnRG3/xsMAirbP0dc
         Dz6Sp4aBX5f1o2y7/TzF9CiytVluIYHrtDbMwap/z3GTr0x2hI26MX67ObXX5peJqI
         0dr0PWrtuh1E7oinGs9izIvf+hYCRANdg9kFGeSEF7A8kXsW7JWcwcbzbu/ueeoe9L
         ZuEpNc5iTMHHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BB0DF6078A;
        Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd13sbAfR1aBKOkh@google.com>
References: <Yd13sbAfR1aBKOkh@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd13sbAfR1aBKOkh@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.17
X-PR-Tracked-Commit-Id: e565615c5486935e3b6080dc06a94c6fbd0b4264
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa722ecb93c22f084c9a9913469a940a8f0e1d5b
Message-Id: <164193439056.11435.7535203808199372536.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:10 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 12:27:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa722ecb93c22f084c9a9913469a940a8f0e1d5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
