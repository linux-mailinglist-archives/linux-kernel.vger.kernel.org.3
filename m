Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06B4937DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353389AbiASJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:59:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34428 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353384AbiASJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:58:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D54D061531
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45C56C340E5;
        Wed, 19 Jan 2022 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642586336;
        bh=YK+NHYklnZnc5AIU2rcQ/ugY3qqF2EwcMoX/0pl/+sA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nTCq/b988q3QVwf7qIrSTzbMlKR3pIqyZTqN+lweoSyiCmOT4hxwgm/V4YZH6t5uE
         rfr1k1LUq3DN0JAyf1QDYbDyFul/Cs1EJedRNZKaNZKpzyUaFIR6sLRux6TUzUWtrw
         4TI3c6HHXVxfFPeNEoTTQY4io2aidfKvGGTMxJXaycTEABsYu5ewaYGGZtEa36/UD6
         cVOMTC1+w+hbYF6byDDJ2OFnTDjBzIUVmcVsnhidtXVkx4/qonHVUy6y7hnqVRLNlp
         O7dQxtp3PRPpYrNL+Rs+fEOe/ZgkNgo35+8wcIViSSNBuFNR/qbprU1YDbOO2sumXY
         vbBlqSU3dRq4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33529F60797;
        Wed, 19 Jan 2022 09:58:56 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YedlHVEa4sdbvB2F@google.com>
References: <YedlHVEa4sdbvB2F@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YedlHVEa4sdbvB2F@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.17-rc1
X-PR-Tracked-Commit-Id: 5fed0be8583f08c1548b4dcd9e5ee0d1133d0730
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d1df41c5a33359a00e919d54eaebfb789711fdc
Message-Id: <164258633620.28417.9292686617329063876.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jan 2022 09:58:56 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jan 2022 17:10:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d1df41c5a33359a00e919d54eaebfb789711fdc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
