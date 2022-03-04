Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C144CDDF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiCDUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiCDUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:22:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB08151695
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:22:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01DABB82B8C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 20:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1558C340F7;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646425321;
        bh=H423vNR5/GHC3sZBG5YTvZoSdAAdPzHDpUFsfHOwgok=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jL9fKtgNT8RUuTmyLKe7OtTOkr/n78NaDX2BqRILI89Zx5rEqQeh85Bf9+12pR+Fa
         r5r83WeRQquK7yxKg89WaJwnHr/ZAzAZq7A0kb6BUG0exPSkzZ42QATSPqw9HqvYEY
         4IZg2N8Y8K6Pkj6mPPLJ5L/SmQD3EtUrU35xwwmFX+hBCFtFaDdEEAxSUVFO8tnsxM
         tC1cYoe20nSJi9c9Ud/RcAvHmW40GIlvU8FiyYVfy7ew0Sk5+37nUuSE6LsCEL/VJB
         uDpINQR6+5SSUAp9/IYxKhosdeBFFRzSKEJdwhriXKtqGjBFJDuLQjC+2tGeM0a9oO
         vpixXhdKPoaqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F135E6D4BB;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-35bc28f8-875e-45d8-8c8d-869bb9efce61@palmer-mbp2014>
References: <mhng-35bc28f8-875e-45d8-8c8d-869bb9efce61@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-35bc28f8-875e-45d8-8c8d-869bb9efce61@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc7
X-PR-Tracked-Commit-Id: 74583f1b92cb3bbba1a3741cea237545c56f506c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07ebd38a0da24d2534da57b4841346379db9f354
Message-Id: <164642532157.24805.457490534031372221.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Mar 2022 20:22:01 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 04 Mar 2022 08:54:13 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07ebd38a0da24d2534da57b4841346379db9f354

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
