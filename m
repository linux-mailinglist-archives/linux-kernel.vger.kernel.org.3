Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED84B2E30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353200AbiBKUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:05:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353166AbiBKUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:05:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794AECE6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:05:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81913B82C97
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06258C340F6;
        Fri, 11 Feb 2022 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609921;
        bh=a3+OiQ2U9k44AyRxGUDgBmBEufOWsGoN35othw3JSeU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TiO/r+m/nk8ZETiu0jIutaXO1cLSGK9HBjbGio1nSmLCMlEJM3hW+l+G3FwYfpxBb
         BwG5rlmrPGiBnE727hhVTzGPUcUOT5fkdjUru9U4If2jROi839uPkpC2nnXUM5b6Ju
         z0HWllbszZlcHKbNkn2FNH3aJMPiGVGDYW/KCmh1Ao2rSVOA35/Sik+aMZfOIuOO2P
         7NBvD3SopAi+u9AS2Mb8krtLo537Ced7TNZqj7c8X7kqiFi4Yx1XzTN3t46iHXyD1G
         sPX/a4LbRvpLMAmMOu94hqU+e2w4sQRqca0R97P0OrTcZe/j9kjc+kYpraYK6iNV+K
         f/sRpg+7ZAELg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5DEDE6BB38;
        Fri, 11 Feb 2022 20:05:20 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-9ae96702-cb8f-4e96-b126-0ae9b4f5a7af@palmer-mbp2014>
References: <mhng-9ae96702-cb8f-4e96-b126-0ae9b4f5a7af@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-9ae96702-cb8f-4e96-b126-0ae9b4f5a7af@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc4
X-PR-Tracked-Commit-Id: 6df2a016c0c8a3d0933ef33dd192ea6606b115e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d41d2e82623b40ee27811fe9ea38bafe2e722e9
Message-Id: <164460992093.1412.10063568591934198888.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 20:05:20 +0000
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

The pull request you sent on Fri, 11 Feb 2022 11:28:17 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d41d2e82623b40ee27811fe9ea38bafe2e722e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
