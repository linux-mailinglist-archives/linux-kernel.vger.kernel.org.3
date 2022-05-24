Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE734532137
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiEXCwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiEXCvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76E6315
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C479BB81733
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CB96C341CD;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360676;
        bh=2EpOQm+yQcuSvASWG+3yrjdAiOPVudOYvyTUfM9fJeU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hCk6RXD01xAlTWS5Onj2GCkvq/SkyEqjRUV8ZesOcXGnC/EgPq9GlCZQcYmoZhW25
         tJo6Z8fOySVdau5e02kihRohFaDVbZSl97y7mgByg7JIf1EooFCosg8Zbf+FYVQ3Wp
         mkeB7LXs6siJa6nxRW2Zlwp9IOnyXOOgVfYPqMHblnzurci2LM0kEMukIcmJzfnxiK
         s7ukee8Ldo3BvSLaDRWc1plW8E3bDNx7UeRMsbhhw8Z4ldl9grYyShHBRWdR+c6RgS
         IbKgiYsW7IT3NaFh4FVX2sPcGyMFTp5lIyO9NedkLFRuvbqEIeJs1Tin7Sxf4gVA+N
         rHyWqhn4n0sTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BBFCF03938;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
Subject: Re: [GIT PULL] x86/kdump for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YovZfl7LxBlS9aTr@zn.tnic>
References: <YovZfl7LxBlS9aTr@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YovZfl7LxBlS9aTr@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_kdump_for_v5.19_rc1
X-PR-Tracked-Commit-Id: b57a7c9dd732ca29c4400a9a710c56c55877086d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3228a86a33ba7e2f4205c1a06fdd05cc5c4eeb5
Message-Id: <165336067624.14181.11538294067144862611.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:16 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 20:59:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_kdump_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3228a86a33ba7e2f4205c1a06fdd05cc5c4eeb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
