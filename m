Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983A853D1CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349158AbiFCSuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347939AbiFCSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9A286E1;
        Fri,  3 Jun 2022 11:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3612C619E0;
        Fri,  3 Jun 2022 18:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96E91C36AE2;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282222;
        bh=e8DoDgkEDEte+46JWrJqOJqNQb8RpiOdFYyNIRcBG9M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SyK7Wq/vMNkMy3xO0WnPi2rjqBH3jE0bF0OKRZxtVuuWiA4AWVWHGWgw7hU6t7Mjz
         SIehCut4OV0RNbfIJNwdnESFDW597jezMetLSn8QySLyvjf53C6CQ5Vk46qiTpsHBp
         KlxroSJClv5lfh2sboAauVq9zDgm0SpBg2FubWaaY/LfLudSil6WcyA3DSOjkiyMTR
         4d1Lh83mvNsQLk30ZbCz5JMApPV+o4Mhmz4jUny5X2NL1wGbMmR4lXklEXHwRJ6a9v
         3eHYvUJxVwB/J+4rCaGocJzS2bIdIxz1uCzGlNIJeQwZUNYkP++sgcLM5KaAe6SJf9
         ZfEijC12ifoMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81CAAF0394E;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] SPDX update for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ypngv8MIQ/Syj1Js@kroah.com>
References: <Ypngv8MIQ/Syj1Js@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ypngv8MIQ/Syj1Js@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.19-rc1
X-PR-Tracked-Commit-Id: 53c83d6d8e399fad3d3d25df0ea0d54eb0f94f88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04d93b2b8bc7a68ec45a6a156f34a611ede5aa60
Message-Id: <165428222252.10974.9124112207282912341.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 12:21:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04d93b2b8bc7a68ec45a6a156f34a611ede5aa60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
