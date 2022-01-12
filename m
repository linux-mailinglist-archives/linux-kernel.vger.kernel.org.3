Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDDE48BC81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347841AbiALBf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiALBfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:35:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F81C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:35:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A98D7B81DA7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CEDAC36AED;
        Wed, 12 Jan 2022 01:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641951351;
        bh=V1IZxkS8wVKRacdQqdYsM+1OxOQeihHcZn8C82+LZ1E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u+AMVohAjKSP/OFHFcb7+JvgKhZ/1FmisptVnUqUTxBvLMGmI+shjvaBYdRD5FCJA
         QYsZeewqm4osoZUYvZhReUNhpzAiWRglDB13Cbbr2Uow4HsIJzf23p3Wt/KV1m5bBy
         mkyUoqgJJFyPS3NIJk3A7/O/xafTJ6G60WePMildUqepqGFieZJ1G654L56eh5Us+o
         PqwI5ajWNQumKXp48ahDREnTzciQnylEQxpITIbB5J63o5udwPaOeQ6G9sMC9iH87b
         lMXGZ0lB4QopnH+F9d8AhCnUHGaJhZ7+3Pq2i0j0hKtGXy6HQtjsfM511ocd1b/rOq
         R1JOuWfMvZTSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AC64F60794;
        Wed, 12 Jan 2022 01:35:51 +0000 (UTC)
Subject: Re: [GIT PULL] sched/core for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd289b35jcsSdJfl@zn.tnic>
References: <Yd289b35jcsSdJfl@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd289b35jcsSdJfl@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_core_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 82762d2af31a60081162890983a83499c9c7dd74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ae71436cda740148640046d58190a5bbc3ac86d
Message-Id: <164195135129.30057.15384161177865386578.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 01:35:51 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 18:23:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_core_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ae71436cda740148640046d58190a5bbc3ac86d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
