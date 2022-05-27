Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF93E536904
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354939AbiE0Wpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355116AbiE0Wpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC956F48D;
        Fri, 27 May 2022 15:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB45861909;
        Fri, 27 May 2022 22:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FD36C385A9;
        Fri, 27 May 2022 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653691537;
        bh=ulJmVI5SOTbObkw3Pa6mdRi06omNbH+W+/OsH3PToj8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BjqF4hs86as2RZdH2RvC0/v9kXBhOG+7hlYW7LZ7Z8p0yJAkp7VntA+C3a6yQQm2V
         F9TTaTWtvjRTIrmnH4OHyor6U1f4xMN3aE6q2JEuBwxtcW5ZZJ48qiZtfMaXeOFKHh
         dM2YPpCHou89rPY+mlK+f/N/RRjYv8M+dfjpo6EE+ppqe7usP4cTvXgF62MAqxzkvR
         yZqwErZ+sFVzLv1uWghDHmuaYolTL82rMiAC2lTMYRu4ea6JWZNI2+tKJnyDVimjKA
         ANGRYqcpxazI4uyYdXtngS5OXbzu+FveAZncaJ2D2pMb4WGuxyfB4Pp79h+FxnmMOU
         AchhFI0UDlG8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C9DFEAC081;
        Fri, 27 May 2022 22:45:37 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220526235729.2673148-1-sboyd@kernel.org>
References: <20220526235729.2673148-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220526235729.2673148-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 71cc785d295527587faa8e3d825ef7c0e1cb2d12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b0e34a0307e046c0662d7dcaba2a2c9993c4339
Message-Id: <165369153704.860.2551210349336303964.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 22:45:37 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 16:57:29 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b0e34a0307e046c0662d7dcaba2a2c9993c4339

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
