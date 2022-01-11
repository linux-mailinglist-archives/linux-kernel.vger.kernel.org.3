Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618B248B8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiAKUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:53:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38866 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbiAKUxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9981C61741;
        Tue, 11 Jan 2022 20:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E50DC36AEF;
        Tue, 11 Jan 2022 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934389;
        bh=yec4E9e9D2fQCOAPNC1hcXVwIyBn97InYlE+1VL6qck=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VGtB0TSSmce+369lWXSa+9CWfQxLRoKeEWJAry9Ta7e/J8CoiVVKW7UfX8osvwtnt
         JIY6q3XVyGIQe5dQENyHRT+XhK9+jCgFCokRb6kehgqFlKO4cpcNWE4brQiQzvIXxL
         MUJeo+ztUMICvd/tyx/+ViCaPKwdld9mM0zTyrK+p32Yllu9oKuG2XFD402pB+H6tt
         zp7dypxrmeIrHKiGCh6Px9XlW7Rw0vvcDsHv8LEnyajyNqav9CikAhWo8uyO69gxEZ
         eJMWDy4Jyo2X53S2yNVIi4TwhoCrCpvji5ynOTclzgvi9IDd1UTeIOvv46xdfXJl7H
         wsg87vLPXrK2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5ADA1F6078A;
        Tue, 11 Jan 2022 20:53:09 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110132949.89A5CC36AE5@smtp.kernel.org>
References: <20220110132949.89A5CC36AE5@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110132949.89A5CC36AE5@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.17
X-PR-Tracked-Commit-Id: 19629ae482f1800b50a5bdf2504ac57171d2bb82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 282aa44c21708835517ffaa31c63ab651248cf5e
Message-Id: <164193438936.11435.10637555412211658494.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 13:29:35 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/282aa44c21708835517ffaa31c63ab651248cf5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
