Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4748B902
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiAKUyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:54:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43424 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbiAKUxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 485C6B81D53
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 003C6C36AE9;
        Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934389;
        bh=BHbx1PeP+nH5Grb7x7ijvK1lgymn5v+O2qOlbl+vRWI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GIIuv15BuetBhvNdfOhO8WqeF05/2giu1TdtGPYoIFTYJv6iEhwe+5N8ZYv7UZAaz
         jxljkCQk7qFVXqwXF07493r640smdyCOXg/G++8o5uiIkGMH0hWcwoVFC7wWbAKXy3
         Ez9wHVD2urDkL51l10F+tGeph/hTmtfG3Wc80b6aZ5XFW6HkpEjfIrj/sjyUqXlcEq
         uOlurzyB7788FhFrObrxWD1eYKrW1Ey84rYNAfFHHL5GOczmMypD/ummQwAcyl6gkD
         OB8rwEUI6OMeJfm1f6uJwkPtX7sZpg46B7lqWFkSF1LAyyl46t9MJaXvo6dQfOG6TL
         QzFJiuUwwWUKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2955F6078C;
        Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110132907.88261C36AE5@smtp.kernel.org>
References: <20220110132907.88261C36AE5@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110132907.88261C36AE5@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.17
X-PR-Tracked-Commit-Id: b56a7cbf40c895cbe8b67ce5649a26b7a7bc48be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d7852c3794085920e50e69bd050881d605bd44d
Message-Id: <164193438892.11435.15594344583136570718.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 13:28:57 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d7852c3794085920e50e69bd050881d605bd44d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
