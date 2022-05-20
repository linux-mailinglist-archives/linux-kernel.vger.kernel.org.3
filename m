Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2452F30A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352854AbiETSga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349147AbiETSgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB02E9FD
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F3561A43
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 18:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 492C2C385A9;
        Fri, 20 May 2022 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653071781;
        bh=TQzXOoYS6WLOY9eLwsKqXNwOH0zAsygnd4kvMJYTGCI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hb5Jy6jXMqL5ep3RKI/kuUEyl44zqvij5PEV9DsjG9NkAPLRTqdZ7rrouUpBI4iOd
         epuKU5MtVFUM5rpM4lRDylsYxrqBmO9f2WIs5921HBbyoW0zguTUGv8t8MlQ8WM6MO
         ypQeh4dxH7O9n2kkaDe5a4q/3HMTVkVZkWVe0/Alk14wv6aMqbNp4ihLP9vGtnAbgG
         aoaekB931XtXAW3iCjjxLO2ycUP7q65fdLpg+tZPbF+yVDCGQQUeCjtTLRjgdVHHEq
         kSKEWy0WAmF9GkdiT6O9n2bTTyxEUYC+jxdqogybg7V+1k3AHtGekiN3dS94Oni5Nv
         EOLD3YnyyHvag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3525AF0383D;
        Fri, 20 May 2022 18:36:21 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-d5b7ee6d-8d8f-4603-9a20-843f35fae857@palmer-mbp2014>
References: <mhng-d5b7ee6d-8d8f-4603-9a20-843f35fae857@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-d5b7ee6d-8d8f-4603-9a20-843f35fae857@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc8
X-PR-Tracked-Commit-Id: c932edeaf6d6e6cc25088e61c3fcf585c30497c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 265f34c25bad0d92ca439838529db366adb0e620
Message-Id: <165307178120.15282.9873885050504477794.pr-tracker-bot@kernel.org>
Date:   Fri, 20 May 2022 18:36:21 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 08:42:22 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/265f34c25bad0d92ca439838529db366adb0e620

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
