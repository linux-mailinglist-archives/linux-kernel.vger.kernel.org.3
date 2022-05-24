Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009E5531FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiEXAXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiEXAWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E253700E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02A4A615B5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63834C385AA;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653351770;
        bh=gWs534bx6/1RwhKb6QYQLYeWDihrHcYTVgW7ksqzVR8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fKmFEn08Kpb3h3PYr58XtZLng2KOA5M5wVtS6p++I/tia4zW8Za9qUBA9N1MStM4x
         TTYrgUWVR8NR1SaC7BMxmKuE8YVCKMkYIOGwvWNQ5Onz7s3CqCtOjnOre7l2acvRDC
         6HtHoDfBovuZ3YKUaHQmnbceSIHDg885ZCIOo3i4NyvHpGvIjcsW9p+4hvchVM1wjo
         80Z+MBBX9vH6nujK52tpLMyq2PbCb9Hu9OWKf4THCzUEjmJjtIVEBx2UiEVJBSR0Yo
         Y30c4UIf8UPcGUFFkPPmDcH8n1DUlET3V1AYzK4yJ7RtyL8KkqhGuY+oB4TD5EEO0M
         aoZWb2O29V/rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48CC4F03943;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
Subject: Re: [GIT pull] core/core for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165329267741.3801280.534077656528571075.tglx@xen13>
References: <165329267741.3801280.534077656528571075.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165329267741.3801280.534077656528571075.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2022-05-23
X-PR-Tracked-Commit-Id: 75d8cce128c516fe6cf4b8683e8fe1a59e919902
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b57dccc42a790cdf2a8cad110143feb8b35e563
Message-Id: <165335177029.4476.7308781073626532346.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 00:22:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 10:02:03 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b57dccc42a790cdf2a8cad110143feb8b35e563

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
