Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980DF470B38
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbhLJUC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbhLJUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:02:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF4C061746;
        Fri, 10 Dec 2021 11:58:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D7B9CE2D35;
        Fri, 10 Dec 2021 19:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A252C341C5;
        Fri, 10 Dec 2021 19:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639166325;
        bh=70sWYcreaG+6agipBidXoRKWuJTjPSAR4lQz2JJekuI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p1soJfKtCnKnb3D+Yt8KFmvsjlPttyLo8k/lQa0hNZiMsQHX7TgN/799PLg8Vy0qe
         Yq3oWp9t/DWm4f13/rE7tjz3tfNPFO8zMb10fwYqbhNKG6YY+DNOV7TcbsLgZDbF6y
         pG1kSAfunGhaeuoj8zGyM/wtdQiwHbDdLB/zd0isaL95IgPdBiBYtIP49xnXQeqRdN
         EPO41fhsJJNwJ4KGX61yTegkzp/Oka3XCuHX0rWy1gSJ9LM2dsHh6TSJ2QxC33bO/6
         in0A3Yf1HkfGfyaRQROnzHS/1lubHKyivb/16NpwXaLT5Va8tuu2Va4V2ZFmB+HjWK
         C9I1LiOLcDUKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 46176609EB;
        Fri, 10 Dec 2021 19:58:45 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211210095431.63667-1-ulf.hansson@linaro.org>
References: <20211210095431.63667-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211210095431.63667-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc3
X-PR-Tracked-Commit-Id: d594b35d3b31bc04b6ef36589f38135d3acb8df5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ca4b65169b3e6f5cfd114f63b613c2b67569d6e
Message-Id: <163916632528.27955.14170833328820098979.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 19:58:45 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 10:54:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ca4b65169b3e6f5cfd114f63b613c2b67569d6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
