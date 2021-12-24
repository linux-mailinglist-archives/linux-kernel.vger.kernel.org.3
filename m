Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6809A47F066
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353318AbhLXRcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLXRcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:32:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAAFC061401;
        Fri, 24 Dec 2021 09:32:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89914B82337;
        Fri, 24 Dec 2021 17:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 250BFC36AE5;
        Fri, 24 Dec 2021 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640367134;
        bh=cin1GhoUT3laVMSQIXbb7E7uqZ2aJSb8aUaMmGLmLV0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dtMnx4d13r9DLRLkzPEIpGfzRn5zYX34jAIotV2W1Cz3QcX4wefsFLL8L4BFyNSTU
         3cshxbTgpkCUk7SlAiFd84SBML/XjEBXqdy1SiYC0ufreqhA8RK9evkZdwgQuJ0PQk
         muVFYBcsc0/pBngnyZdwFE9QaH08jFXSRqQ66AauFZlILHLk5Q6+x9YGg/Qczgg1Cr
         EnHwGAswFY3SR21lFFpLDx6asqSB/LMykqgoTUrKSQa1MZfjxVtBKsNA5oSW0BX628
         otH1dbqAwPrrPnOJB+AVOVS45+c036XyonprpiaCM++P9sl2axdGb0mXX4dvybOzqM
         8AfYEUrRwM7Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08D10EAC068;
        Fri, 24 Dec 2021 17:32:14 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.16-4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <312bc446-6f8c-c447-b3cd-bf2d46581f8b@redhat.com>
References: <312bc446-6f8c-c447-b3cd-bf2d46581f8b@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <312bc446-6f8c-c447-b3cd-bf2d46581f8b@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-4
X-PR-Tracked-Commit-Id: 26a8b09437804fabfb1db080d676b96c0de68e7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8831184c56d60669fb4925c1ec721dcda2e2c6a
Message-Id: <164036713398.24477.3596137639500008587.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Dec 2021 17:32:13 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Dec 2021 12:27:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8831184c56d60669fb4925c1ec721dcda2e2c6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
