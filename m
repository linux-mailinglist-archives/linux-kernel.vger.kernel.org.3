Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA84885D8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiAHUTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:19:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55836 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiAHUTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:19:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50F8260AC9;
        Sat,  8 Jan 2022 20:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9ADFC36AE5;
        Sat,  8 Jan 2022 20:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641673192;
        bh=SOErDPvXoxDkJ9mGbGeKs1MfFZ1T0CAP45m4iR6cGVs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kzzdw0pzda+/aXyUud6FFeJ0tIAho0yHVMmrPT/65SObvdRIZDxAMIMGZIJmb9Fs5
         qTCVdvs3QQuBNBl1UL0FipLASSWL/10Y3ahd9aezQF32IMnvq67BppIPtcqzFCpomB
         BBmuvnDMC0bHFjE+F86tdpFoD7NI7++hBddTc/vDTgziCsMkiattf9w/+mSBaIEzal
         Og5gY1SMwwc7rzpvnWxURrsR95J8XaaIfY9FBbgvZN4cwkzCw2CXyrmUiIoPqpxFNd
         DOr8+anHntp4lzrk8oJzUGC/NoQ0Ma7uHbm8tasUKDQHitjjH6hH0d2A64z8jCLIKB
         AVYlJQchtRUWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6B69F79407;
        Sat,  8 Jan 2022 20:19:52 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply fixes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220108112229.v3d7enmuibypa5tm@earth.universe>
References: <20220108112229.v3d7enmuibypa5tm@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220108112229.v3d7enmuibypa5tm@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.16-rc
X-PR-Tracked-Commit-Id: 644106cdb89844be2496b21175b7c0c2e0fab381
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d445d649c7929ddafff319ad90e3e190722c685a
Message-Id: <164167319267.14130.13289312994054568512.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jan 2022 20:19:52 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Jan 2022 12:22:29 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.16-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d445d649c7929ddafff319ad90e3e190722c685a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
