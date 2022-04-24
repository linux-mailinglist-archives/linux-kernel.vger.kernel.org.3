Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4450D4E0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbiDXTiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiDXTio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC212764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E0860EF6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E25FC385A9;
        Sun, 24 Apr 2022 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650828939;
        bh=VMlUuIXjTxzxQbrPLZHtmlMemAxVf28uN15xwhwxnSY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pPdJj/xIy+NKDL5ZRfP0iJHKbIlheDBRUlwKkFI5m3NDzzNW4E4K6prCMJdiji5h3
         wu0F1rlAdbR/QTar/rLOcskMq1++gSvdlfbR1knNrGfnVoVwM0SdVwLlEY0wkWyKi6
         h8iuZXssVNJJ0Ujc74gjtspRQhy/eWDFCX1PXsAlSfq2Zd/Sk1UzkdZogZDtR1C1kV
         c3lNuyfz1juM/697vaXOPMD3bPFsxV+7VzI+NYl/i4s2gWCuRH4GjzNTS3T3FIrmhV
         EPWLygRdqJSeAKB+CTY9R9it4FuT6K20AbNXNnpl8KFMY/lZ5HXN7osITfb8++85ST
         2hpCQoIr485Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43C8FE8DBD4;
        Sun, 24 Apr 2022 19:35:39 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YmUgYLZF8ptmhyj/@zn.tnic>
References: <YmUgYLZF8ptmhyj/@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YmUgYLZF8ptmhyj/@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.18_rc4
X-PR-Tracked-Commit-Id: 528c9f1daf20da14d3e7348dc4b1d7c55743ee64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f48ffef19dfd6a3c2a6872d4c680c90e14103fdf
Message-Id: <165082893927.1098.1195147937587673156.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Apr 2022 19:35:39 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Apr 2022 12:03:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.18_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f48ffef19dfd6a3c2a6872d4c680c90e14103fdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
