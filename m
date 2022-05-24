Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD19531FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiEXAW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiEXAWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:22:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431242A38
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACBD5B816DD
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 743AAC34117;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653351770;
        bh=jaRbfKfh2Jl52JPFiqdu2FFhXW9nQOIExM9IPZc+PYk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z7V+A0IQWD8PUo1k9Aqh/vIqTChanobiTXQCv8Wqh2Lzn8BaP9e2p38/WD0bT2fZD
         lC+C7YjYm2ZdFpg9XMo5SmeMHLaz9OsNfihkCuysE+2GS84g/ysbeQr0xNwc4SNBV1
         nWqXj197OyH7koJE9MBOlr4c09EtvgNOreghqzeO5c9ZpCmJeqFIM6QEJSLawhAkTX
         4DUKW34EB9hhwWEydQKlvposJDv+KWFZhDn37l447GlW9J6om+Rz3pnj/aflkwdecT
         ESICyJo3l2QXIT2i2ylyH6+g3O5dzkH4iuxYmo8IdAc5BPkMGooU1sqD2IDTj1f3Rc
         LWJqZQNU4lJwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 548E2EAC081;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
Subject: Re: [GIT pull] core/debugobjects for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165329267901.3801280.12353140398221832966.tglx@xen13>
References: <165329267741.3801280.534077656528571075.tglx@xen13> <165329267901.3801280.12353140398221832966.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165329267901.3801280.12353140398221832966.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2022-05-23
X-PR-Tracked-Commit-Id: 9e4a51ad8eee1d263666fd31ced39bd8e3770822
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 985564eb3e3c2024af222525e8e052b3336a6775
Message-Id: <165335177034.4476.11320582449596156188.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 00:22:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 10:02:05 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/985564eb3e3c2024af222525e8e052b3336a6775

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
