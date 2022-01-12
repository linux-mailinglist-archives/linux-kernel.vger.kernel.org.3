Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B948BBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346969AbiALAOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347360AbiALANu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34820C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 16:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 81B85CE1BC4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9793C36AF7;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946426;
        bh=qhX2xjZPOnkovTNT3pAqKCmQ0qegNrFZZqQzrqUF+GQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qTvVcFn0E18/yTwUUfXfuFX/tq+d4ydfwbNJB/L+cmBsFBd/UsuCbrWXlNVLfOSHf
         JoWglTjdNPr5hn5gHdi7M7pEERQ/kiNRmu/TVsioji3rhBnt/BKZQpFjRQpDyGdFrn
         VwuG/jl0KuORcnokTUjFQ4FrNHXpGXd3SRooyNX028+X2pB1g7nWIY9+z6BmJK536G
         d16tnf+mwxSg5kvLShI0LVjg0GYF+0Eyx1FylN3PK8C1HEorqEoSo8Ay5i15oXMHsw
         oqFY0qO3QTKBRmfQgwpdbHZD3G4wh6ehT1dn58v8fHyLiWnnTqCZYtR8/dZEPBkTZN
         GTeE/IbieAcTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6C89F60793;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
Subject: Re: [GIT PULL] Various minor gfs2 cleanups and fixes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220111172215.1149791-1-agruenba@redhat.com>
References: <20220111172215.1149791-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220111172215.1149791-1-agruenba@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc3-fixes
X-PR-Tracked-Commit-Id: 74382e277ae97b4bcfac6f8b61df7a500d392500
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8481c323e4ea0a65f0578107a3e668c1c69cf474
Message-Id: <164194642674.21161.15806950616568910059.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:46 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 18:22:15 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8481c323e4ea0a65f0578107a3e668c1c69cf474

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
