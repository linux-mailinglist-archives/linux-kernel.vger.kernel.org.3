Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C72489F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiAJS2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiAJS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D2FC061751
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:27:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C87A61361
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E530DC36AFE;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839276;
        bh=EHLrPAb6e/xajFn0YPFMSSwnOsrdqIYmCDBghbML90E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f1cPzVwi91S8q/+CzgD9KTvpFoY9rlSdiJmKnHRrTrqSOAOuWdkS+Khmqcv2jO8O7
         MAIh1ajAzWSxxGmnDaM+Tx729x+85wqLCxFGTs1W9T4W3ZyWSdomzXv23zDwaZk2ec
         Hjrm57F2TOFpBgn8x//X3flNCuWabD5WeR05GefDpAeZGoO+ZpVWmPKvWSoJfj4c7I
         +lUabLqeR4rvqKqmNiV+NWYmA9riOQE/v9QwTfPhUvD7drni+0iKeEepGV7Peai17a
         1M3evmx+AhsYxPOqt044qp5WGYq6u1dZCgkIfTJkYd+M9t2XJ2cRSDSlBEuhly/Kps
         degiImVQqQt5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4C32F6078F;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwS3jGM29IWz5vq@zn.tnic>
References: <YdwS3jGM29IWz5vq@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwS3jGM29IWz5vq@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 4d5cff69fbddbbefef2903faa48263cc5d3ca382
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e97a0c02b94f2ecd5cbf29ded90c5db055e8ad0
Message-Id: <164183927686.9673.5711773060360794913.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 12:05:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e97a0c02b94f2ecd5cbf29ded90c5db055e8ad0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
