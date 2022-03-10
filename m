Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE54D4668
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbiCJMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbiCJMD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:03:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84E7655C;
        Thu, 10 Mar 2022 04:02:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7528C61876;
        Thu, 10 Mar 2022 12:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7796C340EB;
        Thu, 10 Mar 2022 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646913744;
        bh=PNe2iwu5r38ZoHjpa4VmSnAPzCtR15WtnbU46e68JP4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pVn9F71no8Emq5U5+8T553Xt3P5NoQ+ZoAEk5ajtdsS8lBnOXlrfCTDphZOHOEHis
         E8B4ZMPfN+j28whtKUJcQEAP85ohkIkeITiSMrCKp4kmkm/DZwMGEYhosGEmXPQAmN
         kHMJ4+XJc4u3gGTcT6mW3/1B73eFGMIMQascXoJ40WjjQxDxEF7G40Isd8o6rhyiFy
         uUzzIlB8rywL2+I39crltRpQjzRlXz9bfWsM81zhTgKEYG5FBCa3q3PXqTjW28B8qg
         f68dfezv76jNAYJDftWanx+cBVERQQgDVXPRmLmBie1ejypaVos7VH6dy/CNuGjAfI
         DD7Vy7pZyR4vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4B29E8DD5B;
        Thu, 10 Mar 2022 12:02:24 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220310043112.3908132-1-sboyd@kernel.org>
References: <20220310043112.3908132-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220310043112.3908132-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: aa091a6a91df395a0fa00a808a543301ec99e734
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c674947f6112e4d68715e9f363c6698c2b0eead
Message-Id: <164691374480.28854.18227610351154161128.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Mar 2022 12:02:24 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  9 Mar 2022 20:31:12 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c674947f6112e4d68715e9f363c6698c2b0eead

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
