Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B181548DCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiAMRQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:16:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50364 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiAMRQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:16:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45EF961CEA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACD79C36AED;
        Thu, 13 Jan 2022 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642094200;
        bh=OGR8BatFmLW9rRgYsl7va768TkmCSZ9RLxhv1E0WHag=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IqLDnnv4d98qdnJpquT8Zhyz3ExvHdL4CVCNzgGhMmr7e0Pnf2YwcWjB81Ie4NriS
         ElZI0VZBE3PQD+gEXumopsRfD2YfYJrvWrkYjnx1l3jITQTsXCbW1vJ8Tc3bRGFwlh
         QXrqK+MKU4YTVCv/3EN8paRIg4u0l/nb40zGZDmtkgxAD1FWbkXCuYF1eF0ZSzLk1p
         w/xBnpr7/vL6D6xiFKw7w0x2lPmRDdGQr8wexYfC1ottBj5ue4TAXnUhkhWuh0eJb1
         Knrz/7Ipf4hlF3PKkWW93U+VxGLfcIJ+FC53MEDoLwDxMBfZtLAUAUzsChl4iSJLi8
         8H2q7BuqevIDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96392F6079A;
        Thu, 13 Jan 2022 17:16:40 +0000 (UTC)
Subject: Re: [GIT pull] irq/msi for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164206863209.82661.6310423060263423123.tglx@xen13.tec.linutronix.de>
References: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de> <164206863209.82661.6310423060263423123.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164206863209.82661.6310423060263423123.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2022-01-13
X-PR-Tracked-Commit-Id: 74a5257a0c175810d620b5e631c4e7554955ac25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: feb7a43de5ef625ad74097d8fd3481d5dbc06a59
Message-Id: <164209420061.1143.11680500164036522471.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 17:16:40 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jan 2022 11:13:20 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2022-01-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/feb7a43de5ef625ad74097d8fd3481d5dbc06a59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
