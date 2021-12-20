Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE647B2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbhLTS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:29:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47770 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhLTS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:29:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4956128A;
        Mon, 20 Dec 2021 18:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCF62C36AEE;
        Mon, 20 Dec 2021 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640024976;
        bh=tvpokGrRdUhZL1admqKMejuWeRF/+2whV+u3lfNfvIs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U19f6Kvda+D64WH4Q6XYglWoaFk8GB39uxaCMoOw0aKqyNVVZClkgRBASmNDMyEp9
         xW1i7JHdCA0agiYt7uNwEdbnf1YZHipC8gmEKLP7lnxB8GDXZ1esBiBP0K/WABXso3
         NNvby/GCp7wbaItf4H1I/T/nnQWqatPpro5GPIfunC13tGxB2cv8imGTKPrG6O7NcP
         gcevOHQCKD5+2RPGzOq8qpHM6dNEfhYt8A8E2MHM5yputjAmTJhUOzXY/4HGV78E/g
         e5SsS1tyoMXEM1/QnsD3uSPKFUr8eIWbxF+Yq28XbAaJRlhuAEaFZ0lEYKoUsljSpJ
         1z1AjZfSruI3A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B9ADB600E8;
        Mon, 20 Dec 2021 18:29:36 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211220171847.63617C36AE2@smtp.kernel.org>
References: <20211220171847.63617C36AE2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211220171847.63617C36AE2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.16-rc6
X-PR-Tracked-Commit-Id: db6689b643d8653092f5853751ea2cdbc299f8d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86085fe79e3c1a66e32f2acae0ae64f4cceb8d28
Message-Id: <164002497675.23216.2661413816843378463.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Dec 2021 18:29:36 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Dec 2021 17:18:33 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86085fe79e3c1a66e32f2acae0ae64f4cceb8d28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
