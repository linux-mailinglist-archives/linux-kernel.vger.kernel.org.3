Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B614D69A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiCKUpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiCKUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:45:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9901EC26F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:44:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EF9A61F92
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 20:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFB45C340EC;
        Fri, 11 Mar 2022 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647031482;
        bh=vDi2M9xuuoKAX94Xgn0xlD2AOH2r3dG2kCNUybD8kIY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QsC5USRG3VhfOPcwsr/WNBv/Uhyeyw2skf3/wMHhZ3q+HTq84x5G8pT36T+TqR2Sr
         npC2BVHiMv3/IeSWj/aEnQh+kdfpeCaIwYPPEsaM2jDCVN9k8TmLBM6U2HvRG2uq1h
         wCei+9hqGdwoV/t6gQT8riqc+JtIOEypMeD4a99TP1fJFdwB2L5KUedI42KYKCAfyb
         nbVouqscYJ3srpnSrkyWpbRzrl8xZiqswwD4TiUEuKvhblGSwbL5W1vlQcoAHhcl2E
         /W2Nn2WcLhSCMlR/Cc4NI6Rx/ygEd+lGwXanaLhSSsVRI/bzzGnLcE7XMTlw0V0OYV
         HwJ63waqIcITg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB828E8DD5B;
        Fri, 11 Mar 2022 20:44:42 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.17-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-1484f557-fd58-4fe3-afce-a630fac5c8b3@palmer-ri-x1c9>
References: <mhng-1484f557-fd58-4fe3-afce-a630fac5c8b3@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-1484f557-fd58-4fe3-afce-a630fac5c8b3@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc8
X-PR-Tracked-Commit-Id: 0966d385830de3470b7131db8e86c0c5bc9c52dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77fe1ba90241c2af6f14d53988bf0cd6b9586699
Message-Id: <164703148283.12993.8501085816446276759.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Mar 2022 20:44:42 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Mar 2022 09:18:12 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77fe1ba90241c2af6f14d53988bf0cd6b9586699

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
