Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78414A2F8C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351302AbiA2Mv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349859AbiA2Mvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:51:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126EAC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 04:51:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEE10B827BA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B610C340EB;
        Sat, 29 Jan 2022 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643460708;
        bh=CsFfk3nCej0kj6zmus/4+BhC/ddyUmpkm/HIPnsr/Cg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e75VSUpHw1Py3l+4/mag57o4X8wWVBujXZxSsAsoy/JEv/6OtvphfAPwFFvkPLtL6
         NqRxn52XQtXOsRbb4XEa3mJYl1waTe0KwQkYPMSXtW9LGKHtljQScwmBG6uKpPOG/c
         O891F6qf0z9awOuE16gwXP+HbehGRHeKwQE2IefuDVV52S0Qs9ZKpMW0WLe3126/vd
         YXvWYW9tjXvgplwniFbKRCTq7JU6ilqpX9NNjYE7cxLwiXftj0rIOY+WZFCmu0fUi4
         Zge3e/+stTW0uLG4T1fwpdCdQayUm2iBo43l8mo8cokuQ6tOCawJWNk4XGxhh8bPZQ
         mRqD+NxxFGd4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64E52E6BB38;
        Sat, 29 Jan 2022 12:51:48 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YfRAlb4M0Su+iyow@arm.com>
References: <YfRAlb4M0Su+iyow@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YfRAlb4M0Su+iyow@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 297ae1eb23b04c5a46111ab53c8d0f69af43f402
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 216e2aede2b575016bd579e0c23661bbdbbaada7
Message-Id: <164346070840.2828.7233492612070791271.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 12:51:48 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 19:14:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/216e2aede2b575016bd579e0c23661bbdbbaada7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
