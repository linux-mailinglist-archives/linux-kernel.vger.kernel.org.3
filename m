Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215515158FD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381747AbiD2XdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381795AbiD2Xc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:32:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44595CD64A;
        Fri, 29 Apr 2022 16:29:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01396B828F1;
        Fri, 29 Apr 2022 23:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B76C4C385A7;
        Fri, 29 Apr 2022 23:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651274977;
        bh=kZrs/xiAEckX+b0ic9RlGktgTrirB1chaLCHBLfQVEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PF6C0k2AyIDq/f7Vlj67fHL0ychlUlAZzUl24SoNmdpMhrsuwIudm6ngma0FPt04s
         VFW5aObZKNnlPYEzWlHR82lF5OeLVCQQf4n8lXR3WY9WjLwnUI7C9wtrtD2Ps2Py/N
         LQ/MeOG76qt0qaeKWGYeI6dhw3mxBrLT16nj+N4R7t/JzLUm0DkH6dWHCibHVm6i1m
         TtctMYQR4nzkeYXV52UeBG3s2QLKyx5YGx3uKM5iheZIFHTilUqB8awPvQOGeWeu/r
         CmYPTbeqx77/MoTiaVSeohhVYFEK0l143TxFTVnvh2T93Qu2BhO1Efc7Slbe+h5Jp0
         eY8po4Jpg2hFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A15CBF0383D;
        Fri, 29 Apr 2022 23:29:37 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220429162632.29934-1-idryomov@gmail.com>
References: <20220429162632.29934-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220429162632.29934-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc5
X-PR-Tracked-Commit-Id: 7acae6183cf37c48b8da48bbbdb78820fb3913f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd383b8e32f6aab08c9485b1fe86e2e932b1df69
Message-Id: <165127497765.20495.16396468291637508679.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Apr 2022 23:29:37 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Apr 2022 18:26:32 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd383b8e32f6aab08c9485b1fe86e2e932b1df69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
