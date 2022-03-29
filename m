Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078CA4EB49D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiC2UVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiC2UU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:20:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E16112221F;
        Tue, 29 Mar 2022 13:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B0A41CE1B8B;
        Tue, 29 Mar 2022 20:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A5CEC340ED;
        Tue, 29 Mar 2022 20:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648585151;
        bh=GolL2gr+JH3aqIPtYdp83uQMRcF7Vtac4B/CjJlheGo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lfYGLWS25rC5YcdW78LzI0MuZNKmayum2rnd0NIKjjQMe/R9XVCRSYn3YHxABm3Lv
         kpkTzz9wuHv+Ze/odSiqxL28D0uSEgjQHZ7Uu5c8Ml22i/0nh6etSYgknN9hMTi18o
         gE8M1rXPfPK5N6bPfm3IWbqntY238BuVRkHFqP2NeGS+RMnRu6fq7rp1cYPRDUSlw0
         sKssU2FefeHKZLJizK4m1i5ZagU9lISVoisSMTMPngANE5o+RQnwExmU1NTI/0YQ5F
         ZDjWFhU3Yxjpk4cDbZkkm8j4BbynwG+IW2ukRgCajoKqNoGQTJQ2B3GvT2WU9b8YjS
         Jj3nGLoR3QTug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0AFEDEAC081;
        Tue, 29 Mar 2022 20:19:11 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jcQownj7hRpai9XQ+yLW4KJcdEhKz7ANYus-bubQ0wpw@mail.gmail.com>
References: <CAJZ5v0jcQownj7hRpai9XQ+yLW4KJcdEhKz7ANYus-bubQ0wpw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jcQownj7hRpai9XQ+yLW4KJcdEhKz7ANYus-bubQ0wpw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.18-rc1-2
X-PR-Tracked-Commit-Id: 3b65dd5be3c72b9d2013bfe6e9261e2b06222fa9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d59c3b669faddb91737f4e59c09305878a971d8
Message-Id: <164858515103.2554.1385403616803723299.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Mar 2022 20:19:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Mar 2022 19:15:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.18-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d59c3b669faddb91737f4e59c09305878a971d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
