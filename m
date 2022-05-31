Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C794539901
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348111AbiEaVuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348186AbiEaVuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:50:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A622985A9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B78A96140B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87BC1C3411F;
        Tue, 31 May 2022 21:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654033829;
        bh=zeuo1QMULipBjYnq4qVt9fhOCdx8r1VKebqnYocYO4I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WSr7eFr3OAchW0kJiPtmjdZzqDFw37MGXttdj2EtN1AXyHu1T9dMnBLPDKWYbYWIt
         f0GGHijSCyt1XVxDXxGym3/b/85lrhaJlEzeuP/+NaZpNTik+3zkeUF0osvPkTG9c/
         OtWZkMwQ67uZP3xPbxC1LnVCxWx5/k75NCnPbXm+md2iiGw5Ny5C5B4E0F39VgWp8Z
         9KI3vZ/LfFnPees0BwwjTclDR+ABUwnvIkEVdVrrhcRWVgCOPtT+idPqbDLJHiwcYy
         ZSo4LM9u7aEjirL0ljYQJ4uHZkSdWNZwBK25i8XtxiGCk0a0ssbisi/2s6ugnNqDiE
         eCVDv/yg3jxbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75484F0383D;
        Tue, 31 May 2022 21:50:29 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.19 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9>
References: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-mw0
X-PR-Tracked-Commit-Id: 7699f7aacf3ebfee51c670b6f796b2797f0f7487
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35b51afd23c98e2f055ac563aca36173a12588b9
Message-Id: <165403382945.9010.13864501013200150707.pr-tracker-bot@kernel.org>
Date:   Tue, 31 May 2022 21:50:29 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 May 2022 10:13:06 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35b51afd23c98e2f055ac563aca36173a12588b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
