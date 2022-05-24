Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2A0532133
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiEXCwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiEXCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450DDE80
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07C32B8172F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92779C3411F;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360675;
        bh=Ti6JbxZ/eyfKzeJRUza3qK66bIR3GA61i6PJXiInsSs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D8RI6t2bc1qUk78eiTEf989TnhNj63fwX/7BJuWsaRWMzetNtrJC4RaVtPRGTCpU8
         uFio5Ml2YY9bYkE2sNE2+4svazucvE3ReS1tJDSA0aNro6MwfPW/8tMXFmJpfO5sul
         kowChXut1LQnlepJ3gsfWdy9+x2adjABUafS7LsTiZVCAcmeMi8b6IchVgWYuTOEW7
         GZiZfbYHlvfWj5DWVaNaPNPZdRvzbtCpZ2HFPGoZjCRPN3wau+FAM8BpCkMnCJiRhc
         Ir3kJfpqCSabWmvlsJsPosWXzjQJHKJ6ikcAU5sgq7xUDA0zub94rtZiIrOC4Ulhep
         2gWgv3Ge5iEeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 815A8EAC081;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yot+RKdiZMtQSGqT@zn.tnic>
References: <Yot+RKdiZMtQSGqT@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yot+RKdiZMtQSGqT@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.19_rc1
X-PR-Tracked-Commit-Id: aeb84412037b89e06f45e382f044da6f200e12f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1de564b8c1a6f9f8bf3a106daa0be9f2cba7d045
Message-Id: <165336067552.14181.3180745809028093691.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 23 May 2022 14:29:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1de564b8c1a6f9f8bf3a106daa0be9f2cba7d045

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
