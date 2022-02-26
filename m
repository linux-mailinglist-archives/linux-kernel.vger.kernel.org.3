Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DCC4C57FF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 21:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiBZUbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 15:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiBZUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 15:31:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD64241502
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 12:30:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88CC60FE6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51FDCC340E8;
        Sat, 26 Feb 2022 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645907428;
        bh=ff3bi4g41RKRKYz5tIpQPfp57Ad0O9hUyF5WfiL6vfA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tiZDhmR3RlXCgTl3nUWnxQZQL6slt1wkpi9Ir3Oa5Y3NalfXV8Am7vO/AkxfBGu0T
         e2jcB5KDxlVpVORoeQfWmZlpqBUC7oLITG1Frf7h2UgpWCwQNZuJ8tLglgR9SSiZdZ
         Q1OGZm76dgiakNT5kYg/qIxBRatghjwGh98oUG2GjJXb1eWQop8fo8pr54tuy+LL9x
         PmuSMn3JS2rBYuR7ZkN1/mTGVGHlQZnjuDPoayxTkDFDFUt+hw1GlNZMHVa4fcvT5B
         EYTYHOrvXGG6/nYS9TNjcSGTIC6lq9wVvYowGLQ2HDW1Y9hEbDAxsFUu+3Iv6imCMw
         d8UEAUBKpL6tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40C39E6D3DE;
        Sat, 26 Feb 2022 20:30:28 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: memblock: use kfree() to release kmalloced
 memblock regions
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhnYeoIbwkEy1ryt@kernel.org>
References: <YhnYeoIbwkEy1ryt@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <YhnYeoIbwkEy1ryt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2022-02-26
X-PR-Tracked-Commit-Id: c94afc46cae7ad41b2ad6a99368147879f4b0e56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e41898d2ba51ef2e8e81fb905c1eaa958aec830a
Message-Id: <164590742825.22632.11817441511132841934.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Feb 2022 20:30:28 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Feb 2022 09:36:26 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2022-02-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e41898d2ba51ef2e8e81fb905c1eaa958aec830a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
