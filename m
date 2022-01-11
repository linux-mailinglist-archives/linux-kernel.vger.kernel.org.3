Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E402548B8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiAKUxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:53:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37866 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbiAKUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:52:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4265B616AF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E4FDC36AE3;
        Tue, 11 Jan 2022 20:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934375;
        bh=cqmzXGmY26fCpJfBCR+5KtLFaAz7mhvvVOAShvyie6k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pOqKeuc020waXr7mjS+l+HcyLEVMNmTFzjOktA9kEZLR+E5nD8+w6Tm8pYJ11PoMO
         6xobLCfjmScMNF62PvfhvCpaCMsQPjzCloGidID5KbDuyFQkziMEy3y6iDolAzWqsU
         Vzn/12MWevbhYYCg6SZeg8+WN+8cawrOS09k70GQaMXBzxmMdJD0XONfKDGP1IBw1n
         Zgyd70kZcgf9TuFiPcyYp++slVYgj3SKKoeoyv/sxHiI9od2XHX3ziux6Oo48wFQIv
         Mkk3rE5UbSe8csNCuDOc1fxWuxzSXhzPkJ8aaRklA4JI+Pz9AL4ceTwLFgHABpLs5J
         QjrvVuYTEQO5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CC58F6078C;
        Tue, 11 Jan 2022 20:52:55 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110114003.7f297088@xps13>
References: <20220110114003.7f297088@xps13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20220110114003.7f297088@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.17
X-PR-Tracked-Commit-Id: 9ce47e43a0f088653aa25ca465836a84114e0940
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c01d85c2190bf694ccd041e7d19c36eacf005840
Message-Id: <164193437556.11435.13753019786939678299.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:52:55 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 11:40:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c01d85c2190bf694ccd041e7d19c36eacf005840

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
