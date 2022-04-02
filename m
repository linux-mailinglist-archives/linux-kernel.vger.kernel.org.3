Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2440B4EFE17
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 05:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiDBDJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 23:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiDBDJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E3E49933
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 20:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C383D61C1A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3423AC2BBE4;
        Sat,  2 Apr 2022 03:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648868867;
        bh=aOPqVZwUVsgERE3HUZjYHTEIcl0gPbx8M3B7pyPWPpU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H966k1Ooi2MaCmtNfvrJ8IKNarQ6dtWTGEJ18vsI0pjDlGh9axYiGMME10O15ZWTy
         ceNAd8Oeg3HicR0G+BAEJ2J7xTabgBudguc7XANh9ASLAqIJGhwPi+xkAl2AsA+pO+
         5+GIqowIYM6tSkU22ej+Sl0bPk5XJ2WG5SM8UxM9g9wjrynT8iFU+GNlu4JZWh8/Kw
         6XwXQqvHx2QpBfba28rg3B36ewp5a21gne0JHq/OtS6hLxJCPBjETWjKu1Iv94lEmT
         hj5Vgv7PeudsCB5jH10zUhx2+LIi69KtbxEIe+irFiBVNTcWOHjD4bphtWa9tOGRUx
         BJpNIW2FHXT0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1913DEAC09C;
        Sat,  2 Apr 2022 03:07:47 +0000 (UTC)
Subject: Re: [GIT PULL] A single RISC-V fix, ideally for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-e799956e-2858-4ab4-9795-1255abc93c39@palmer-mbp2014>
References: <mhng-e799956e-2858-4ab4-9795-1255abc93c39@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-e799956e-2858-4ab4-9795-1255abc93c39@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw2
X-PR-Tracked-Commit-Id: 2524257bce43610f5ec14feccbacf7a103cae94a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fdff407028c6064be96343f4bac31a0e679cbd0
Message-Id: <164886886709.20951.12719267433667674431.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Apr 2022 03:07:47 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 01 Apr 2022 17:21:25 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fdff407028c6064be96343f4bac31a0e679cbd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
