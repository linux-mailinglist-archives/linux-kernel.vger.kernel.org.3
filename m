Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE8489F35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbiAJS2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241547AbiAJS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7AEC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:27:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9936133A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C0C7C36AEF;
        Mon, 10 Jan 2022 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839275;
        bh=HegfbzVMwuvkVT2UcH75l4rV92eg7AHKb/UsxZ38pAw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ly/y4DPmvRFvAkhucZ3drhHRHWtZw/jsGZ7xtLeJZsbDEhgJVtinI3X/dYt/qeo4f
         N8g+SaXhXkP0XyYphSqykcnHDG9MOVOFnkEj3igTKUlibUQ2cY1MuwpmfkETIMvxIT
         yhnmHLSvRSb7U85AFg3VmZ6Qxjsq1O6MW3mCvYr9VVfSUVeEPnqUtbDAXfJ9xNDQZZ
         nXCCKec4+ScMI1cfF9fNr6EdwXO0Wa/9t2Rty+rokHsMAPHW/hyGX3t6f0I2sw745S
         engGcZg5P5Ozbz7UvX0Ritos2QQ3A67myXS0tk9D4ACj6kmngJsdx03vLzsJPkwoum
         DhiuiNsWOEOSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59A45F6078B;
        Mon, 10 Jan 2022 18:27:55 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220106185501.1480075-1-catalin.marinas@arm.com>
References: <20220106185501.1480075-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220106185501.1480075-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 945409a6ef442cfe5f2f14e5626d4306d53100f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b9e211360044c12d7738973c944d6f300134881
Message-Id: <164183927535.9673.16814182667735611453.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:55 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  6 Jan 2022 18:55:01 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b9e211360044c12d7738973c944d6f300134881

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
