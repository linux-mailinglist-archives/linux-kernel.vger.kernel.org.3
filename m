Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F408479672
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhLQVn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:43:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39828 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhLQVn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:43:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA73B623E9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 21:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DF96C36AE9;
        Fri, 17 Dec 2021 21:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639777406;
        bh=L3mVzxB2Y2Wu7nTpTqO18BWJxUuntT+xOw5kxJ+QGSQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pzG5p7U/jLwdO+1HPOZ3k2FrWk5OMxr9i84FyNIMO5nt3TNOSnPLcATn3UAwbjbD8
         CDTVVsMbUxotZ6tOBMfZIRqKrDQz9bdVjsx1R3P0hhJD00+cX7U0r6QkuwFnN0fP9Z
         pwit6dGXV1ki4QbajFz08QT/5pkFJB3wkx21ZHS1yMXfNZ7bMc0/JMlBeOTnO8vQiS
         0H75U+9uwQSNoLWd7F7uSvfRVSdU6D3lIuRBBHu6lH0qSdnv5q1zDETnTRgtAsocyl
         0LAm5CNsNZ1BbkpdlXaBwTOAeg86u6ExyRQe59Epx3NJ0lIhU6lt6sYibblLphp1cX
         4WKrskNk4jU5A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0A65760A39;
        Fri, 17 Dec 2021 21:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-e635e7d2-fa3c-4c47-8a6b-989873263b30@palmer-ri-x1c9>
References: <mhng-e635e7d2-fa3c-4c47-8a6b-989873263b30@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-e635e7d2-fa3c-4c47-8a6b-989873263b30@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-rc6
X-PR-Tracked-Commit-Id: f6f7fbb89bf8dc9132fde55cfe67483138eea880
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bb43aec33ea9dabda27bb8863d0e15acd5c6cb7
Message-Id: <163977740603.30898.13365123503393934821.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Dec 2021 21:43:26 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Dec 2021 10:35:51 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bb43aec33ea9dabda27bb8863d0e15acd5c6cb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
