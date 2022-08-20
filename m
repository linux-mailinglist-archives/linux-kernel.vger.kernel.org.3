Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0448D59AF4D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiHTRzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiHTRzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:55:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659765465D;
        Sat, 20 Aug 2022 10:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 022C360CF2;
        Sat, 20 Aug 2022 17:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64574C433C1;
        Sat, 20 Aug 2022 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661018141;
        bh=IBiv2td3HC8eQhiFMVS2KQADwSntfhQ9F7/R96fJp4o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EofjKmuC6kHqr2kWw84c/2q2Cq+AJXoEp/iSmYMNAFsXrS46k/WjIx+KutmzmL+U7
         nYpgbbk+fWZk6vtxQNg/f4FQTkWjtG6TwuGfCWWTgVew9Ax7FTmE09/jhqw5gADI3X
         /ySXdV7I8kyISUvvnWmf/PAKK8n89NfJDl7t7SQWz4As88wqzybIDbnNYfailGL1Ze
         wpV9S8xk8isHgpPMkZIqznT+FFe8+JheUlr3AwBKa6XLeQ4STsLpV0ZgQZlmCfSt4i
         GRby/DkzhPoUpRDct+zM4fi8lgibNHA/pLmjA2XxDcPzhDka3wVyn4uqpiIYw4O8cm
         M1P3O87WXsXMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 533F7C4166F;
        Sat, 20 Aug 2022 17:55:41 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220819143905.8090-1-ulf.hansson@linaro.org>
References: <20220819143905.8090-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220819143905.8090-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc1
X-PR-Tracked-Commit-Id: a0753ef66c34c1739580219dca664eda648164b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d099c3329fe276a5b3939c9f7c8b2ea1f12af0d
Message-Id: <166101814133.10395.6238979678508480598.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Aug 2022 17:55:41 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 16:39:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d099c3329fe276a5b3939c9f7c8b2ea1f12af0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
