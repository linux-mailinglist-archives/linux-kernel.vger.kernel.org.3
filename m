Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BBF49705C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 07:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiAWGSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 01:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiAWGS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 01:18:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFF2C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 22:18:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0E6360EC8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 06:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34164C340E3;
        Sun, 23 Jan 2022 06:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642918707;
        bh=lxqLX3wNQhXzGCNqTInPhaw9ohxNG4JOfr0ve6ikGQs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ivGAf5jnRr463VO5cSRtjS0hzvRUP9mpRSUG1rSIXGjRG9ile22P7Vn/oC4erUCPD
         bvug+ViTjhp0yPOymRXnonsjPvxnDByuQyPqpU0Ybh/MZ9RcwBPjLNOtVMZAa4TnNY
         4eqTWtnjvq40xXPsd9seU3gErVH/TK2z/j5O+X9WyWKa6uBtT+ndip1AEz7PwiUwfM
         WdTO7deRUPJ+I7STsSRftCkCcSlXch27NI8yUvadQOd9D3NAZyJvavF8VwZ5VC1uKC
         vm8iYm2NK9aM9GrsXum63q+fVrFI5mokSg2nGIfTzMu2jBDPexqQMoOooYC8Jxv9Ti
         +DYGb+eaAwZfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 234E7F6079A;
        Sun, 23 Jan 2022 06:18:27 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Fix of s390 breakage
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220123002519.6f693e08@rorschach.local.home>
References: <20220123002519.6f693e08@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220123002519.6f693e08@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-3
X-PR-Tracked-Commit-Id: 6b9b6413700e104934734b72a3be622a76923b98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67bfce0e01927859618b76ff5a36a7f23b412cef
Message-Id: <164291870713.10836.299557364124917411.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jan 2022 06:18:27 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yinan Liu <yinan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Jan 2022 00:25:19 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67bfce0e01927859618b76ff5a36a7f23b412cef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
