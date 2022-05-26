Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AAB534754
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiEZAJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348088AbiEZAJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCD663E0;
        Wed, 25 May 2022 17:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DAFE6163B;
        Thu, 26 May 2022 00:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93A74C3411A;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653523753;
        bh=XV4oZrjPfbR5oR+jF5srjLSwxd5iasPpT2BfrMR255k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z1aLgHQIuYsAcepNzQO2D5eiGkkYcVRs+GITA8k8vh/cA2GhB7y7X6izm7NhklBIk
         Gd6hWqAOTb4BvDfneaJI9pD4Id8UNqFhtqvjedJ+CSuGeADJ2rbSfE++ojCmFnVC1L
         Qxt1WxyVOMSHXW+NaY1s1usnazn13UdhUqTCbThluL6cpRlipE8KwX3riOqDn9y1OX
         P5zYmxNPSKS6O6FjJF6X92EcXg9ttWju+/Dmf2I7fAj4wC42112YFYySARiQ2a48sy
         gkJUlvAdiKoSqr73n0NEnIpiCU1EJYg86dyazonSjcTO+hUrMBp7EIseLgfeOH5dLN
         0BEdKby5XsPaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81E23EAC081;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
Subject: Re: [GIT PULL] Misc hardening changes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524222701.GA7784@embeddedor>
References: <20220524222701.GA7784@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524222701.GA7784@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/size_t-saturating-helpers-5.19-rc1
X-PR-Tracked-Commit-Id: 746f1b0ac5bf6ecfb71674af210ae476aa714f46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62e5873ec96bc2cfe809a1bc123af8101989ef5f
Message-Id: <165352375352.5177.12718744830755925647.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 00:09:13 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 17:27:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/size_t-saturating-helpers-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62e5873ec96bc2cfe809a1bc123af8101989ef5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
