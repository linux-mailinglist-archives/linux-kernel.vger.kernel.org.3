Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3606146C85C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbhLGXq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:46:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38968 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhLGXq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:46:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A02ECE1ECB;
        Tue,  7 Dec 2021 23:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6870CC341C5;
        Tue,  7 Dec 2021 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638920604;
        bh=A1VWxkS6OKsobfyvHFd1lykapog0x06rQRpDfPGDBHA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gFQPljcbxIe1CEooBYvbAvgrFXql8iwyZN2i5IPUlftRvjaTIaWLwqO/bQzktnvIh
         992xicAAmkwTvCsTsNElp3Bel1rj01txIzEL2WJXj/NWhJUadJwv7ncOZz/9SB6WSI
         8Afd46g38f6WBHNFI+g5smI/qVynK3WeXF6QVjukSFXLoRueJ/NUjeWqpkseA1YHCY
         56lQ3HYQDPrzY4Q34fvprZ5K2yWy2HTUa+Q23MurJZY6MwEqFVHV5hieNB1d8NNA/q
         cYIL/IACXsnbZJ22aaozVJA0l6+95K4BgVw8o7OA7S4y4W02n0T9Fx1CaMbVlP2g/1
         3WE/6y0hFnLfg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4AA9360973;
        Tue,  7 Dec 2021 23:43:24 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.16-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d158b42c-5a3a-8441-594c-32ca180e519d@redhat.com>
References: <d158b42c-5a3a-8441-594c-32ca180e519d@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <d158b42c-5a3a-8441-594c-32ca180e519d@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-3
X-PR-Tracked-Commit-Id: 7d0c009043f6a970f62dbf5aecda9f8c3ccafcff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 957232439c2a647e450c21cd49ecadabba05e2a0
Message-Id: <163892060429.27655.6094808560594056441.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Dec 2021 23:43:24 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Dec 2021 17:40:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/957232439c2a647e450c21cd49ecadabba05e2a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
