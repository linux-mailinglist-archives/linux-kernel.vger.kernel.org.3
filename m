Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B5B4EA434
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiC2Ag7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiC2Ag5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4F1163E28
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE70C611A9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55925C340EC;
        Tue, 29 Mar 2022 00:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648514115;
        bh=RP/rsrwTEzK5EI5hSyfx5wsVMb4+dW8n5/BFuKGFcvk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jk7dZaeV9DMWN9euWvQof9pl6628yp6C0+wqDkPfQqDKcHI2/auqtuaDCHfZSJscP
         cU3iyNse5wvNjyx45EjK0dO4OV+xHdstd9qv3krCx5MDyogSPbpSiggDAHQZbsMsUT
         APmRQN/KuCHFe41Uef4fn71uTC6foNwhC9NhzQcADpu9hhQVntQphMXl0DI8UTdNXh
         Ysujihz56AaVuoJqjcJYP3pavoF8uiXl3AHhlUFBeRbXYpRZIGUyCJ6QEMwUInama5
         SZRIBe/3Pvl38TVac1u5uJu2zcG6CKVZtV8VVhn1/wQWeVd80AW1VolFrbgGpM3FFh
         lCgl4VQ5ToG/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 430F8EAC081;
        Tue, 29 Mar 2022 00:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] ucounts: Fix shm ucounts for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ilrxprck.fsf@email.froward.int.ebiederm.org>
References: <20220322080918.59861-1-linmiaohe@huawei.com> <87ilrxprck.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ilrxprck.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-for-v5.18
X-PR-Tracked-Commit-Id: e97824ff663ce3509fe040431c713182c2f058b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a815d0135f1be20c1a04d07f7573a26272ef846
Message-Id: <164851411526.5550.12163658715769141934.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Mar 2022 00:35:15 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, hughd@google.com, legion@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Miaohe Lin <linmiaohe@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 18:52:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-for-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a815d0135f1be20c1a04d07f7573a26272ef846

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
