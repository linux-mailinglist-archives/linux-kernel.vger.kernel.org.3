Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54CB4CAFFF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiCBUhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbiCBUh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:37:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF2C116B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:36:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6161617B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3242EC004E1;
        Wed,  2 Mar 2022 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646253405;
        bh=zQy0WNRFfoSF8M6CkM9t9ucOlLwRhJNfydVDE5XAZcE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R0WLJBVgw5Rd7WcwQstMwaAMW/TWqPU8z2Jb0kND2JvYMZnFx5umnmnfrZXOt2ntR
         lIo4RCVyp1Cy+h3TvWNd9gXwlApckFd7AJ5Ml/Ib98w14sbN1/xY24n91uv5STASAr
         J8JJGDoGK5ahZPBSpznfkpbpCOxGRg7vAjGDYFNINiDh0zypt5Jeo61lHsXJiU2C51
         LVmfhXjodp/MhY/wW7je40jVF9EMtGlgdtt14pk4jcRcj2foNMAmgEhk9nrdJXVufn
         anXn0MyaT/lu85/G4zXPATejtq3pKyC46RREQDXjKVYNzxviO/C1isy00Z8VDE1KAp
         s5ZGqnRSmJrlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A2B8E7BB08;
        Wed,  2 Mar 2022 20:36:45 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fix for 5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yh+CCr04nTTappWl@hsiangkao-PC>
References: <Yh+CCr04nTTappWl@hsiangkao-PC>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Yh+CCr04nTTappWl@hsiangkao-PC>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc7-fixes
X-PR-Tracked-Commit-Id: 22ba5e99b96f1c0dbdfa4f4e1d9751b4c8348541
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92ebf5f91b4dd5156886d2509202be0fb4230dfd
Message-Id: <164625340509.15521.3020679417776527674.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Mar 2022 20:36:45 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Mar 2022 22:41:14 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92ebf5f91b4dd5156886d2509202be0fb4230dfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
