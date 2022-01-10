Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63982489F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbiAJS21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43756 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbiAJS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D091B8175D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C926BC36AEF;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839276;
        bh=7GShKDAeh/q+UvCoyJSar0fkqOETuzk95tNnr7sIJeA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gy+e4mnWOPCwebJD6/++g3p+fz41IF65csZ78s2c/AKVmaFTFFlXZp29TXXnYqa2y
         AS4MUWYxKM2QMKup0Xv6c0HmTGSJig7JSFO4aSBXde1v6RpDpjYkbAbt+QuLleUnjF
         dNzFY58kpcjs8n+yliP61ArgRUW3Bwj11k9XPpmCtu0KcM9QApXbCW5GMUfNaSGFYR
         fPifO1iZu+bC88JO2FkE10hKccf7UgjhdADx+BohFO+Vj4KSjZcn86q2EKMTfa8RhR
         3TNpsZIDL1K9V1M/q2IUFVZ1vt7H41T8n7GvviozDvCD8nHv/98phwjUsHwf7XHcm2
         xBpF3OjIF7fqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7DD6F6078C;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwRQtklg28Rlwnf@zn.tnic>
References: <YdwRQtklg28Rlwnf@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwRQtklg28Rlwnf@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v5.17_rc1
X-PR-Tracked-Commit-Id: b64dfcde1ca9cb82e38e573753f0c0db8fb841c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a692ae360615026b25d64c29fc7c12c0ef63c5f
Message-Id: <164183927674.9673.3758293036915513388.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 11:58:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a692ae360615026b25d64c29fc7c12c0ef63c5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
