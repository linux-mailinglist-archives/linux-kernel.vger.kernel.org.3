Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE0C48FB41
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 07:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiAPGpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 01:45:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39390 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiAPGpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 01:45:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E84DB80CBF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 06:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A06AC36AF6;
        Sun, 16 Jan 2022 06:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642315537;
        bh=btVcnuMBlFqzpE6xYTeS0h6W1fv/SPS+VC1OPgz3Wsw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F/zj6AeNiLTfVIMLKIK1VYbH4Q5dETz5q/7mVXjvSF1HolP9jOlwFwMHH8DeqVpgL
         HWRuCCS8bIFyi388RqE3iZHmA9iGzXQBMQKIcjIvQznMl/TGLIM/dyValP4ua6BDBb
         lAiU/2wmhp9T1FNazKRGZLULv3dCtphRXPQGDbFPzcakTOI8tvzOFVcZBLCOpc86LQ
         Wkwg4DBjcqAi+ZJmIRAzwujhyo4gT1nnKESbAa7DMW/HmfiJRDR8PbjNT+YBOH9XpZ
         RZKkbQHLcUsktQcNHW+/9cClRs2byWYvcQKpDUnKG7LBa3QaheQM8fzP5s2YfXip9m
         t8+RRFnZqh83Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29127F60796;
        Sun, 16 Jan 2022 06:45:37 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd8hP6CEoK8qvTPrjmC+kSzpEOQggWyvd_JQANjdSOjVtA@mail.gmail.com>
References: <CAKYAXd8hP6CEoK8qvTPrjmC+kSzpEOQggWyvd_JQANjdSOjVtA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd8hP6CEoK8qvTPrjmC+kSzpEOQggWyvd_JQANjdSOjVtA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.17-rc1
X-PR-Tracked-Commit-Id: 3d966521a824082952990492442c7b486fefb48c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88db8458086b1dcf20b56682504bdb34d2bca0e2
Message-Id: <164231553716.30539.9125113119013337219.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jan 2022 06:45:37 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Jan 2022 16:42:27 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88db8458086b1dcf20b56682504bdb34d2bca0e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
