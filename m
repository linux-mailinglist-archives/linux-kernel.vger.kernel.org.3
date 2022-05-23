Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010E95319B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiEWTe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiEWTeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04869D124
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92B4861275
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E512EC385A9;
        Mon, 23 May 2022 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653333604;
        bh=QnjAhcmFr7HBm6LhN3tS13sAUY08WXPaKyi/m6pKMKE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ODd06vaUnoO/UGHBry0gnz19Qe2cXtsWyy8cTjrEObGpEWi1dz0v5EqCKAn/DrDyF
         u+vFK4ByAVhxBvHCdpxtTpa19Whvacge8iutMdOzz0Q/rGpZlDxk30ZcRdR5pf+hpc
         tAA/S/QN0kFy9XTwBWtAr8HfzwPwjEaIk4ZOI+OXkty3nSm6UUqy66RttJQCsnz994
         khZdBQLYoLbNWQ60GZ8N+Wyat2Y8c+XXdxCbKIQZnSEb/GmB6RUbgtXbwm8/DDQN8F
         e+gdX02PBDXLfe0nIn7qQgUhX6pc4t6iFvPlj9hvw9kGPBcrfLsbmnmlxgA0EFxwfQ
         cFt1t1EPdO+3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6E7AF03935;
        Mon, 23 May 2022 19:20:03 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
References: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.05.20a
X-PR-Tracked-Commit-Id: 11dbdaeff41d9ec9376476889651fac4838bff99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f814957b018c867a2397bdd3c1816de7502d2c7f
Message-Id: <165333360380.1924.14151894403869332824.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 19:20:03 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, w@1wt.eu
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 11:24:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.05.20a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f814957b018c867a2397bdd3c1816de7502d2c7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
