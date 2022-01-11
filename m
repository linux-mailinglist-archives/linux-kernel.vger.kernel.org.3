Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBDA48B4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiAKSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:03:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58166 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345343AbiAKSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:03:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD9661769
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30A6BC36AF4;
        Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641924217;
        bh=gTlpT8s0DoPQgaU2fM8BxE25s1i5FNoic7YK/lBPufs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qPjNA/XBaJksqtNyhC1idoAFnVcRZNptKTEqLi0cX2P5FTxucfcwNsZT5ZEFLryBI
         zF5JMzO190NvcQaPdkswPnplnFLUTFJBdHUwzYzxDlMrdAEDKs2hkd7UkOl+rAfrJv
         +K9Vvi+loD3deIgH3FU9QLgpiQuU0JCkp/OPskjD7iDUr4Dt7+mH9YiVTKZppjg6aS
         S6KJV3fLuZjG/nsqyOGS3Yf20ANlT35fmD50s6EeboiG0uraEm8Fgj1OM6kOaTM7tY
         CnKxVMTP45lPzQS24hRvCQns0mk2azEcd/LFKNrBsNxy/9nXJITppakgy/k6snV/k2
         63U59A1TVwM9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F253F6078E;
        Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdyASuKnqWo5TUdE@slm.duckdns.org>
References: <YdyASuKnqWo5TUdE@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdyASuKnqWo5TUdE@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.17
X-PR-Tracked-Commit-Id: 2a8ab0fbd110dec25795a98aaa232ede36f6c855
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9e64f85b416a276329134cd83ef8ad78b95a118
Message-Id: <164192421712.4972.5949589200109773698.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 18:03:37 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 08:51:54 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9e64f85b416a276329134cd83ef8ad78b95a118

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
