Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9246A4A6648
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbiBAUqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:46:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52012 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbiBAUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:46:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D8FD61716;
        Tue,  1 Feb 2022 20:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE058C340EB;
        Tue,  1 Feb 2022 20:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643748367;
        bh=Al5lSyWST5bcAKur+5iUl9Dlxd6YTNfMDkpqMgOM8K0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UMqueIWantw62xFdYR39Jx0Qn4vPl/iFmC2sBtmJTKH2QLhldfW1pdI6JzXjJzV9X
         klI1/F+o++NDstWJs4zJJXC4Orgt7iJZfRkaMYRFAAOTA84TX0G7w0ZZrekaZRObDl
         jJoSRQal6bVwcpDK1rJp4L5qaj7uf17Pty6PLKOZxDxZDhaCjy8HolQxpk/8lIBfTN
         QoEjWbdYNjfHfeXJlexVeReSxsIiRtS77krTKlS2dGK+m7hAszOLA4HaDy+rQK+GUq
         JfL5883wp6X6vVOLCIVCzyfwlw8Op3SSIloT4UX0qjhrvEDoJ40qfWW8JCp7JVpnVT
         r+Uk9CNNL+D7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AF8FE5D08C;
        Tue,  1 Feb 2022 20:46:07 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220201155230.56F08C340EE@smtp.kernel.org>
References: <20220201155230.56F08C340EE@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220201155230.56F08C340EE@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.17-rc2
X-PR-Tracked-Commit-Id: f83a96e5f033fbbd21764705cb9c04234b96218e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f7fb8de5d9bac17b6392a14af40baf555d9129b
Message-Id: <164374836762.6282.10486481202686970822.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Feb 2022 20:46:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 01 Feb 2022 15:52:16 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f7fb8de5d9bac17b6392a14af40baf555d9129b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
