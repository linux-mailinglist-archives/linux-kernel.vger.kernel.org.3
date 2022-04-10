Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75D04FAF7C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiDJRyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbiDJRyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:54:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B604B419
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 757CEB80E50
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 17:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22632C385A1;
        Sun, 10 Apr 2022 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649613147;
        bh=rj7JL4rBbavn4EW6mgbShPJ7NOA1xAZoZUayNVGFDik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tD4a+IPIB4xNFQml9IYe9SYi39+jLhiU1Q7+mv34M0cKLa1S+cxpNF6ObJgwy2qV6
         2EW0obeLHWxmY93SCnCv5+KQiFqqkiI6GLy33s5EGxErH7aJ4q35MZ60ahTq+T2h/z
         22BBggmH2b0ow96EWrFIw0XGpFQnVfiCKW/1n0wnBn67XDbc3iiK5UM0inRJTlwz0q
         eU9oMXfv+9iGrC3K2DgA4uaNfy/x6dLhKS49XszKKRLy7pK8mMrwvDiy0g1gb46ndX
         mx/QSJxOKLCaO9lfNlaHKwKLs1uEjTHSZcjkZID29+PekYvy5tDLDY2VDIMotzORIJ
         lnrKvQgqpHBZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E7E5E8DD5D;
        Sun, 10 Apr 2022 17:52:27 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y20d5ay0.fsf@mpe.ellerman.id.au>
References: <87y20d5ay0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87y20d5ay0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-2
X-PR-Tracked-Commit-Id: 1ff5c8e8c835e8a81c0868e3050c76563dd56a2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ea3c6425269d33da53c79d539ce9554117cf4d4
Message-Id: <164961314705.10430.4232436589957126926.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 17:52:27 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        wangkefeng.wang@huawei.com, mhocko@suse.com,
        srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, osalvador@suse.de
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Apr 2022 23:23:35 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ea3c6425269d33da53c79d539ce9554117cf4d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
