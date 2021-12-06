Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B4846A5B7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348567AbhLFTfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348519AbhLFTfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:35:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611C4C061746;
        Mon,  6 Dec 2021 11:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29CAFB81208;
        Mon,  6 Dec 2021 19:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE9AEC341C1;
        Mon,  6 Dec 2021 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638819135;
        bh=v34GXMTN3TDcYNxuZSA4WgmGprXYaXdll6Acumzs0oA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ewcdPNsHYZhQfWAIg1+N7xRD+lIKxn5713gdjjABOnuyzhKru5lm6zGcAwmZ+StbN
         xcVpcoVgCEsQDdtY5OxPzknj6C/drrTjsq9d34y7OcgOfwAQW5Jl5BrA1Ils+pYAFw
         9Qb2BTZtYFY3zNk7t5OldxnjvQfiomIQ2diBBo5iLOsk/Q7jSddG8++1VzNv3gr2cx
         /JQ3+9cN3pvg6TXxBRcC4+j4GlNrdWnUesIbK8lRc8xUbbMQtHGBxR5dCtJKnLJ1Ki
         VOtO8F4PAH6HtSRkbs1wSteNpMiebihAOZsh87C2QuJDQ51y3yR5vaWnlKI/+hb9w6
         AQ2YLGPTtmPqw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CE2D160A39;
        Mon,  6 Dec 2021 19:32:14 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211206160648.CF73CC341C1@smtp.kernel.org>
References: <20211206160648.CF73CC341C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211206160648.CF73CC341C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.16-rc4
X-PR-Tracked-Commit-Id: 07fb78a78de4e67b5d6d5407aeee1250a327a698
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d6cf4720203ed4db30855c01876ab4e5be61fd8
Message-Id: <163881913478.10155.16288753252906098958.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Dec 2021 19:32:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 06 Dec 2021 16:06:34 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d6cf4720203ed4db30855c01876ab4e5be61fd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
