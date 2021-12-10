Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33347470E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbhLJWu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:50:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43616 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344774AbhLJWuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:50:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB42DB82A15;
        Fri, 10 Dec 2021 22:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7046AC341CB;
        Fri, 10 Dec 2021 22:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639176407;
        bh=PmchJ/JxMHv2x/LMg559G1GV1/yJSIznik9Uu2h80O8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J9hqv/Atp7577TftFUB0j25ay/DXuB5rhouT2svHcNTgCVF8/jLu2LZd2O0brRI1f
         kEaNxQA31kFAREKaKORph2HmIdutblz964gr5LJbS23vlvO17UoBpHm3HYcD6dsIvu
         NFhuFnUaMkLs2QG/ZuBGGXGvDFpcs8UA2IXVe6GtGRcALteIjQZLxbzUdnCqeoHKh0
         cIesakElVdr/oNF1OobnioOVIPS7PAR4VSQIjqtuD87cCqkM9lCVvnEumiztybCFWk
         DIOojP6fvTOWnNs7/wECk51eeEeM2iuRXJSLW4FPnqQjTEDdCrvU/qLNwOy5uVY1nz
         ME1SOTByM+EmQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5071E609EB;
        Fri, 10 Dec 2021 22:46:47 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j+7Kz6n_WfjJuVaxt+MNVo77KikSPKQDB-4iT8ozGfww@mail.gmail.com>
References: <CAJZ5v0j+7Kz6n_WfjJuVaxt+MNVo77KikSPKQDB-4iT8ozGfww@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j+7Kz6n_WfjJuVaxt+MNVo77KikSPKQDB-4iT8ozGfww@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc5
X-PR-Tracked-Commit-Id: 444dd878e85fb33fcfb2682cfdab4c236f33ea3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d46bca632ca4ce27621cacbc0d838d042041220e
Message-Id: <163917640732.4787.13605718698872065798.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 22:46:47 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 20:51:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d46bca632ca4ce27621cacbc0d838d042041220e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
