Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4754659A788
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352319AbiHSVOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351700AbiHSVOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933B4D3E53
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30C8161737
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 21:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98444C433C1;
        Fri, 19 Aug 2022 21:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660943681;
        bh=GCa0IDVBdMQYrcNjZJ2AAdGVMd7ovgaNFED0tmvuzXc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fK+Nw4MnjAjQzlbhmNEvvwWbi0hfkY3DUcc0+14B9mjOn/7lEyeDSl90Gl6Yhc08a
         QU/7KVVSaXm0TKmfyK/cxcoDi3JP5bJTGrMLzGMRaWKxGhw7CwG0MO+G8BOTrgnlnt
         uxT56JaiK6rfq/sfvg9h0Iy2bK5dWxJ1vS6F7hcXUv4HDVva98SCmEaiH841eg42cf
         kKPl+Et0F8mKUOa+KysUK5RGyDTcZGguNJ5qgUdMgecxmGCm8zI8t5rHGkjp8h8nsD
         9kHxAxN+NRb6BfrTwYlMycEHy2pVDzTqTSUDIPNS8207a/QA6u/XMGZxglmJhJoTys
         4oAa4cgXlHLYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85C7EE2A050;
        Fri, 19 Aug 2022 21:14:41 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-74337228-62c4-40ed-b7af-0d988ff94993@palmer-mbp2014>
References: <mhng-74337228-62c4-40ed-b7af-0d988ff94993@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-74337228-62c4-40ed-b7af-0d988ff94993@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc2
X-PR-Tracked-Commit-Id: 96264230a6817bcd4a7ae0fc30c60bfb46499f68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fd00059cc13c7f170451e9318a9a5e772b88e17
Message-Id: <166094368154.15089.7972422322159327730.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 21:14:41 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 09:28:44 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fd00059cc13c7f170451e9318a9a5e772b88e17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
