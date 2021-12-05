Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF34C468D69
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 22:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhLEVJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 16:09:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53734 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhLEVJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 16:09:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC79E6114F;
        Sun,  5 Dec 2021 21:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4847AC00446;
        Sun,  5 Dec 2021 21:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638738364;
        bh=TCSFNQkZ5Q9YOgledH3d1uV6AZwHpH9ybYqeCttF9n4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i/du8iYe7/CsYP4QEj4Dm5OTfbo0bU+PHpNOLJ8vzu0/YoBQxMwBkDzW0hmm8OvdX
         EQlG31Fb2laHPBdC6xBhSmyYDkgvE8yUicRn91jBodu1TkoKxIWkGzXzWfTwriaC+r
         BoJGJ2T0WqYkxROc/kxbobwmQoxZZwQQdg0b8MPs8NpjqIcYv8KxdSr2+Gs1JO9ua0
         yZlfQLmsPArvHJ52kqxklA5E4jAJJT1WuaqEERfldFpLphPQA1K1dapKIWXgH/4dqq
         2qxdvd+dTyaonsw3F2XYlzzEvqc9mSBdglXJiN1HYFqHOClWi0S61VQjo3ID34kLcc
         mK7R7PDp4iW2A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 22F1F609B9;
        Sun,  5 Dec 2021 21:06:04 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture bug and warning fixes for kernel
 v5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ya0fu9qlJFsBdjWF@ls3530>
References: <Ya0fu9qlJFsBdjWF@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ya0fu9qlJFsBdjWF@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-6
X-PR-Tracked-Commit-Id: afdb4a5b1d340e4afffc65daa21cc71890d7d589
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 268ba095371cb28841bd9bd7f61c73290104a064
Message-Id: <163873836408.16033.15831097716424868487.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Dec 2021 21:06:04 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Dec 2021 21:23:23 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/268ba095371cb28841bd9bd7f61c73290104a064

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
