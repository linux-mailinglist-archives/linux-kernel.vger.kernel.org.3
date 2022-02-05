Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54E4AAB02
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380989AbiBESp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:45:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37696 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380977AbiBESp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:45:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 733BC611C2
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D61B1C340E8;
        Sat,  5 Feb 2022 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644086724;
        bh=fcalSUfcC3f+A4OPK37VCIh9FGFzTW9J646wvOQUfd4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jfrYf5pgoQt/pgjiwYAAWXNH4J5yx7nB2f7MsQqX5d5wXlHvtT2YKxTPrMB0Gqq8t
         Wvs539nPCJfCsoRHVDliTaEtkqfg3B/HbTjmikv7H1N8fyPniUaZwHVjlMTR6x4B1a
         tOscvPcEiFHVPJ+9a7I2QKnS7gzMA1fZTz42DyzOO6UhY3GmFxtkLE+1F2Yr5R5iaP
         MmmnC3rUB16DkUrE6Hw0B8f6POneUnN7tyMmcgwIdhfirx69zgN9x+GIUi0qfNHyTV
         kMMCtno6SsaysWYnOSVPTY1kZTsSQY0zI99AmBltiti/hBCuSAZn36W+wrUu5f9Yb0
         C1PAWTjyamH+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C58A2E5D07E;
        Sat,  5 Feb 2022 18:45:24 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220205110717.16946-1-jgross@suse.com>
References: <20220205110717.16946-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220205110717.16946-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17a-rc3-tag
X-PR-Tracked-Commit-Id: e25a8d959992f61b64a58fc62fb7951dc6f31d1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90c9e950c0def5c354b4a6154a2ddda3e5f214ac
Message-Id: <164408672480.8633.6221021066979381394.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Feb 2022 18:45:24 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  5 Feb 2022 12:07:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17a-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90c9e950c0def5c354b4a6154a2ddda3e5f214ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
