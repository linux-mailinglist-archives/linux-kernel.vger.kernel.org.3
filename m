Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ACE53213A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiEXCw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiEXCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA9C275C4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98B61B8172B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61007C3411A;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360675;
        bh=z+rTU+ZLCOhFuburaRCYMqKRZYyFdznELV0UN0lXPH4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mx9R4A8RCRcuP6QS7DBGmvqWR7Qy6ewE3stM7LEcBktRGQiiESyUbpAcfNnl8qh2I
         lJzROiMISAkCXUS5SwLvNeCszUwJH6RZepp3m2bzaO7cgsxwpuGjTZ9oKlWu1LddSB
         oIApttzLMvL1uMrpcvd6zPGvribF67JQmJIROMoWyAXzNWDWeBx1eFjFHvzqq7v3bM
         pJ4/7eGSXPKuoF3SJlxzCiGmaFhkai395VSnHOeeDXtTNC8FdEKZxQ5Y+s8LkpDQ5Z
         YnObJKqOsb4wH1dSMX7UxO116s8WNEi4e0/yKkKkIDoNDEk5Le97MwiBdxODoRrWx8
         dRspbeHE4/LFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46E08EAC081;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
Subject: Re: [GIT PULL] x86/tdx for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yot1IAqHoRBlwe0w@zn.tnic>
References: <Yot1IAqHoRBlwe0w@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yot1IAqHoRBlwe0w@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_v5.19_rc1
X-PR-Tracked-Commit-Id: c796f02162e428b595ff70196dca161ee46b163b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a755ebcc2557e22b895b8976257f682c653db1d
Message-Id: <165336067528.14181.17073532228467475093.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:15 +0000
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

The pull request you sent on Mon, 23 May 2022 13:50:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a755ebcc2557e22b895b8976257f682c653db1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
