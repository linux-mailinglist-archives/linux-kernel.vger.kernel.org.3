Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714A2467D90
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbhLCS51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbhLCS5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:57:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C701FC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:54:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A8F8B8291F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 18:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 337C3C53FD0;
        Fri,  3 Dec 2021 18:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638557638;
        bh=9ev3Q+ih0dTA3GxhfEB54aRUuOM5tJBBnKyEdk0n9oM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QGjuSAd8Ex6pIVIirmnI/9q80YSYPQKl87tDbEhcLQsIIU4N5IDTlGZCc0JyOrVaw
         6+zRWNOPsQ1Hh+hNEQzZD3ulCRCyjdovn85l8ba2cj4rFdD17ILE+WSsGAsndR/V0g
         cf1ZMNaNXWzqX5qSbw4pI2myxLpGZqsFFfvusZcCwsP94dALDwfKaWtDI5v+GzSkmT
         3rtxouEhoOzHAR7+Tw7HdMtsmn45eR/W0T9x6Yei6satT+yc3xj2Tpw72P1ML6p1HJ
         GZRosOTRRs/fmZyERD5YJOQEYtbkeRXJfeOzhxrNcxLn1YcRICc5y3IKB/at2JCbDY
         GsBsKN86d4GUQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1F25460A7E;
        Fri,  3 Dec 2021 18:53:58 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211203131937.GA27943@willie-the-truck>
References: <20211203131937.GA27943@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211203131937.GA27943@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 35b6b28e69985eafb20b3b2c7bd6eca452b56b53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2aeaeabbc9a1fbfb22d23539ae315cf52f09a0a
Message-Id: <163855763812.17226.5231047138941820995.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Dec 2021 18:53:58 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Dec 2021 13:19:38 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2aeaeabbc9a1fbfb22d23539ae315cf52f09a0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
