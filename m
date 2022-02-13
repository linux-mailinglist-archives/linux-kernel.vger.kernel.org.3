Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE2D4B3CBC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiBMSEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:04:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiBMSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:04:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252175A5AB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFD21B80B4C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 964EEC340EB;
        Sun, 13 Feb 2022 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644775458;
        bh=Eq97wsktQk6Zt2Ag2PBaKDhXn84mpPyiIxr7/gaNuRE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dHg3tqWU2tLTeBLhIKlCfAGRFdMmNUFq3dBUOjXjd2pVcstmkuPZq2TqjzK8UQrD3
         n8s4aE3+4SdRjJXrKSjLeDUiMN39jJHOhRt83uUWvUe8mZRSEPIY9r6UsaIDeDKKHl
         7w6ItPBw1wKheI4TzP2Yku4gxiXxXByYMxxr0TIGX0S6jWrtyjbMPIGoA0QN1yoBQt
         0UJ2MP+3Ln02Mk17aov5pN1G/VmjYzP2sI2UciCAC08dYn650eDdjY2Z63jCv8ctNH
         0Gw43NfcNJBdyK2XVeYWFH5xF8vs8j3mkswNmYS7F9Bmvga+GIDL1Y/hpILfw85ED+
         pZma4harf6sqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84C26E5D07E;
        Sun, 13 Feb 2022 18:04:18 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ygj4lhj6KwGZk5yI@zn.tnic>
References: <Ygj4lhj6KwGZk5yI@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ygj4lhj6KwGZk5yI@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc4
X-PR-Tracked-Commit-Id: 8795359e35bc33bf86b6d0765aa7f37431db3b9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 808f0ab22106d2305b33a2b3e4df559a92679615
Message-Id: <164477545853.17492.11648950675093893018.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Feb 2022 18:04:18 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Feb 2022 13:24:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/808f0ab22106d2305b33a2b3e4df559a92679615

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
