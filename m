Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336BF4E8A1E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiC0UzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiC0UzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E011C90B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F07860C7C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 20:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0967C36AE3;
        Sun, 27 Mar 2022 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648414413;
        bh=vddYN3W7lNHX+l1nwisuW1pMNwWyskE9ZZA0Y6/lo9w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KibREAmW5XEc99cBvRhznaWP4bR1GKk/RxbJFqipaBzkYD7zPpfZX3rc8w78YqP9Z
         0smgmvzvzxskMTzdCAPUa9vsDsnGxkRbtPRKdIrJLRgF7/hKWYvJ91sVXt9ip1XUdL
         RNCKY2p86SxsQy6oLT61+XexBO5G/EsMfCKXte5N13sGx8MXOYEh9eAoh9kAqTDmHO
         ykIFmt5y/wCN3Hx4YF7Nq1WW5lWz1a5N6h98O+D8WOijpIeEhtNHW7Bk/CLZHrzL+s
         Bv5WcA/W5OX8wdBmSLm2eIjJPJCpgCZiHa6TpefkZ2ZcPK72zyxPzrzDVE1u9rVUyM
         YCfoWQgMD36oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E2BFE6D3DD;
        Sun, 27 Mar 2022 20:53:33 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: test suite and a small cleanup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yj1tymvsh0tzkXUV@kernel.org>
References: <Yj1tymvsh0tzkXUV@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yj1tymvsh0tzkXUV@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.18-rc1
X-PR-Tracked-Commit-Id: 58ffc34896db2e5e49e6ae6bf8042f85504d84e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02f9a04d76b76b80b05ddc33ceabe806b84fda3c
Message-Id: <164841441357.12998.8317431222755678901.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Mar 2022 20:53:33 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
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

The pull request you sent on Fri, 25 Mar 2022 10:22:50 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02f9a04d76b76b80b05ddc33ceabe806b84fda3c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
