Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B34C57C8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 20:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiBZTJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 14:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiBZTJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:09:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FB1636E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:08:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C36F760F5D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34BEFC340E8;
        Sat, 26 Feb 2022 19:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645902505;
        bh=4izAxj7a+iBRtv9WYa9ixB3vP7meMrt2ONVYK8/J2SM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ePMBXWSt5ikTOSzg8mEMulxsy6c20rkmH4u/2vnSgFgWUzawWfpBcyb4aVFvKcJ7B
         eBt/e/spSd7HItjmZE5y0QO5dQNMqbPdh/QOr0hyTCan2dH7/j9wqwMs6NwyvQGCTR
         qLROdqlPkkluBN6Q8kkCAFGF4gLmF0im7UW03Xq42jIoAP+8jsLRAGZYupprPICzBC
         mRXZOVhb9LjQYTxgrbSEKE+/wY0D/PjfQVQTvm5y9ZlDCpGIwmYj068bDB3EnPUt/w
         j/wYZVUzRl1MdGSqxIO2tBSICy/acnn1zS6wN+rdSC8FK7613k4g/FqV7BojToL0TU
         crKrlnwhnJWlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F90DE6D3DE;
        Sat, 26 Feb 2022 19:08:25 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-673458fa-1596-4318-ae4b-b0275abc5d23@palmer-mbp2014>
References: <mhng-673458fa-1596-4318-ae4b-b0275abc5d23@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-673458fa-1596-4318-ae4b-b0275abc5d23@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc6
X-PR-Tracked-Commit-Id: 22e2100b1b07d6f5acc71cc1acb53f680c677d77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c8c230edab57eae6d2e8df7239ef121a45a1443
Message-Id: <164590250512.22829.11386233979430643210.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Feb 2022 19:08:25 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 11:07:43 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c8c230edab57eae6d2e8df7239ef121a45a1443

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
