Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF62748BBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347490AbiALAOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347335AbiALANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596C3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 16:13:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF83F6160B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62949C36AF4;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946426;
        bh=sEEdKDeTTVxD8cq/ftv62nl44tIULOj/wc8guDBv3ts=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J3+r6bIqbtDHVqZShZ/DPyElAgWckpnnvCVmISqRObjlZE/sYuzUpA2tc3TtolDhZ
         9BsVDxwtBDj3lWhPHXwyv5RcbYjDgWTQTeq+XU/Hoss6PuEVoPmIZ+8Q5Jx7fdbIUH
         5HkgJrJ4S0XLubxk8QGfz9/4gtNg980vBS06lTTh9d8hsuIuSOwgDXZAKJl9+DA7OD
         /MnMVPj6MgD2jzGWNHo2hE/SU3xpDzeLDNlcp+2eD7JFgpNRI447yFqaPDJKBIvcB+
         nLfpWpwSzg4X67dfelQXZRfDkeqM3ALpqbXg2C+bqsaBPTc9jWtyeER0G+beCzUMdL
         ljCZFXdlBs0tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52506F60795;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS changes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1617448966.248428.1641888175120.JavaMail.zimbra@nod.at>
References: <1617448966.248428.1641888175120.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1617448966.248428.1641888175120.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.17-rc1
X-PR-Tracked-Commit-Id: aa39cc675799bc92da153af9a13d6f969c348e82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5672cdfba4fefd6178b6c4078cb1bb7bf6ce0573
Message-Id: <164194642633.21161.15740390466183249136.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:46 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 09:02:55 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5672cdfba4fefd6178b6c4078cb1bb7bf6ce0573

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
