Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3D4A664A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiBAUqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242462AbiBAUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDEC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33B18B82F8D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 20:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E934BC340EB;
        Tue,  1 Feb 2022 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643748369;
        bh=4c/bMZTPec+0OIHy3mnI5ofz/ZyfsZ3u/nYGscUiz6w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V4Fv6M/S7399BD/Ebk7RwL13F8IkY8IQyIsUFNsQ0QEDmFKLMQbQSCHcdziUXyGm9
         8xt/2xH0vC59p4EOjLYbPG0elJHDzcIrDyNt0rQXrX5F0hgURRBMIWv0m1joIBepQ3
         WN00dsCkCaxjyrNmiNh6V50f+i1kyIYQW2U+2YDnMXedi319GItoDG7tKDKP2r3LLy
         mqkLmRRfIB1hyheM2C11caG1s5TjMWHW4E3PGxkZ9J9fXJtCXXCqOoUloIShJVIEuB
         FGaOuNt/bNQQWENgX7ktwFQtyxaCut0gx1Y4DrapLJcSXjnvjK4FRQNQa3d1XGmQtV
         pcb0uSODjvpuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6820E5D08C;
        Tue,  1 Feb 2022 20:46:09 +0000 (UTC)
Subject: Re: [GIT PULL] Audit fixes for v5.17 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTL-4iPmW+eg3Q==tWBJf2Zc3nOzJVa6Ba0_R6k1sohKw@mail.gmail.com>
References: <CAHC9VhTL-4iPmW+eg3Q==tWBJf2Zc3nOzJVa6Ba0_R6k1sohKw@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhTL-4iPmW+eg3Q==tWBJf2Zc3nOzJVa6Ba0_R6k1sohKw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220131
X-PR-Tracked-Commit-Id: f26d04331360d42dbd6b58448bd98e4edbfbe1c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61fda95541cd0287540da45bb6dcbff2aeab1af9
Message-Id: <164374836987.6282.2981774728840344865.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Feb 2022 20:46:09 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Jan 2022 13:45:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220131

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61fda95541cd0287540da45bb6dcbff2aeab1af9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
