Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A658BC2A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiHGR55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 13:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiHGR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 13:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF5BED;
        Sun,  7 Aug 2022 10:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E109C60EA4;
        Sun,  7 Aug 2022 17:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 126F9C433D6;
        Sun,  7 Aug 2022 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659895065;
        bh=rfsJP6qGplLrh6u+8ra+xecrNARhjyYecJMGbhQAnvE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aQLpW8yJsIjzt1nkODhgNJWF4h+8K8VCiTeMjShNZGmxvpRzVL9DG0a3QRxl1E87A
         wtpXxgVV24oeRBYzdU2cgwVyWwYR5c/wuZ4lRzqgN0rHPZPjLSTDo5l/CElkpameuL
         z6WIp1km/n5e6cvUmGDyyvPhoz7Ik8BxkFXNx8frIqqEB9yRZEE39Ng8NTqoDfCJec
         bw0VIYLVgkXPi0g8n4qwUuqdoYh0ZTSC9A9WIx0saaFGT+wru9zRk81xNO+bT+6R3X
         fxHesIdM8FO7jsvztoyRZP33XZ5TE+yfu3t2kneeIdetA1PMdgLGKZ2ZrqTqpbae6Q
         OkxdPdh9c4Nbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00FF6C43142;
        Sun,  7 Aug 2022 17:57:45 +0000 (UTC)
Subject: Re: [GIT PULL] non-MM updates for 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220806214150.9a96339c1d343b003a48a3a0@linux-foundation.org>
References: <20220806214150.9a96339c1d343b003a48a3a0@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20220806214150.9a96339c1d343b003a48a3a0@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-08-06-2
X-PR-Tracked-Commit-Id: b99695580bfc1f91364023c673681ddb88e375dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb5699ba31558bdb2cee6ebde3d0a68091e47dce
Message-Id: <165989506499.6057.14827201987918707189.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Aug 2022 17:57:44 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 21:41:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-08-06-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb5699ba31558bdb2cee6ebde3d0a68091e47dce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
