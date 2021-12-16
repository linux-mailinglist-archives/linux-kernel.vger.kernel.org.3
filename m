Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBF477BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbhLPSuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbhLPSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:50:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6351FC061759
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:50:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BF34B82604
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 18:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E49A7C36AE0;
        Thu, 16 Dec 2021 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639680604;
        bh=rpY6om5WwhH8gzDzABUtzpPN8AIkEq9+PNrxVS773+A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j34bJJeh40Ca27xC3rYGkrHOy9uMAvoSrWl/pXDusChUbTQgVlgr2OV16oP1wuC+4
         8N4yeDVU91S4seuOjoIApHD2MQbsWNVbt749tEmhjb3N+LasCJqLAdjOZlfYEss5n5
         VP0vOIJdLSGlRXVeBUoHIGv4Qc/IYongW3x/pdQMRCqyS9qpv97BVDO0chH/z/I+AB
         hlaTq71OFSVBaKVy30oPk9hmiN0Pw1gythmSMxEbA4+Pz2z+TOQQPLqS0t3pDnhQ5b
         iTR2oNZIzErsFy581a7UuKWxyG8uXiRRZXG0HBqBKwaorTMy8vLqPyT68vhQg7NZgy
         yrsLtrXmtR9GA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C1EB760A3C;
        Thu, 16 Dec 2021 18:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YbuInd5ccML4yOMP@arm.com>
References: <YbuInd5ccML4yOMP@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <YbuInd5ccML4yOMP@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 9c5d89bc10551f1aecd768b00fca3339a7b8c8ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa36bbe6d43f3bbce1f10a187e153587c7584d83
Message-Id: <163968060473.26543.7534965827876287544.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Dec 2021 18:50:04 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Dec 2021 18:42:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa36bbe6d43f3bbce1f10a187e153587c7584d83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
