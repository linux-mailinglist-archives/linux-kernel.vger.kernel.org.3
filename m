Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781AF58550A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiG2Sf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbiG2Sfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:35:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C3B6110F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F08D5B82912
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3905C433D6;
        Fri, 29 Jul 2022 18:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659119747;
        bh=Lw4yeG4gGj+xasMC8EbTEK9kzoMzERAdtfZxGMXGXQI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R0FxMKSqou+h3eRA1iLWR1rncbMRsJ5R2z5CeS40EPWGrwsuOMH9s7akX+yZGDWyq
         Z8MaEgP+ijwdADPkI8VHmybuFAeHJ2LkdT4LZJ3DGIKxJRdudUt65Wk9J5dJ6psoOI
         5rHDtBQRqy+zcDP0GMsQjzd4mUFyyiqdOZ/v1ogtPoezoEK/AH20ZLUNkudysqSsYg
         hmTE5FTrnyDham13mo+2Cgt41fB5msRA9EeSaPvi4shVh+uDBh9yChL1o5FYE/zDTx
         GcLaxj3d0bO/FolRnbgrY81Vs+iny5CNFPSXTv6g9lVItQz1BUVSR5c718j3ZhADKf
         aWIljiRSFoKUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90D2AC43140;
        Fri, 29 Jul 2022 18:35:47 +0000 (UTC)
Subject: Re: [GIT PULL] A Single RISC-V Fix for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-b20f34d5-a1cb-4254-8cc5-d3c7752b3908@palmer-mbp2014>
References: <mhng-b20f34d5-a1cb-4254-8cc5-d3c7752b3908@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-b20f34d5-a1cb-4254-8cc5-d3c7752b3908@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc9
X-PR-Tracked-Commit-Id: 88bd24d73d5bfa1b7b97a9221ff320fc44ef401a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4d8b09d671f0ee92d36c48b65d2f34affcdd531
Message-Id: <165911974758.994.7819261423841711803.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jul 2022 18:35:47 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 10:05:21 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4d8b09d671f0ee92d36c48b65d2f34affcdd531

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
