Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7F4591CD1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 23:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbiHMVsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbiHMVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 17:48:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CB25C4F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA597B80AD3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 21:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B12FC43144;
        Sat, 13 Aug 2022 21:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660427289;
        bh=7F6OxNu5sBRh8h/+PyaQmodcIh634vFAX8jeq6owV+Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jZbSm+c21vyB+lb330af8MD2hVG7EnSrTC+kgBQ/m2lNLp6VnQYXtKQLkJKkIjgV6
         o4gT1668EdagOul1LA7j03+/5o5qNriKFMtmTbND+P95g/G09CNDLpyt51ossArb/v
         PMrB6b9Kr+ynwuQz0LeULlVTUOzaMCF3UPSnxNcON1hZpphKQbMINcihDrMX3itUBT
         y6IbYuWGdcsHJKlGE2RQ6dLx25raVUx05hL8nycPB06XmC0RtjSrY8N1dvqjnVfSEt
         0xp4KkhJeMAiYfOpcuMFUGJ63tpnApjQz2IFkgcxksgIQuwlY/cxePun+4o6pqPif0
         O9FitE5OSMaPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 655F8C43141;
        Sat, 13 Aug 2022 21:48:09 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yvd/g8RODN/pSkCX@gmail.com>
References: <Yvd/g8RODN/pSkCX@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yvd/g8RODN/pSkCX@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-08-13
X-PR-Tracked-Commit-Id: e6cfcdda8cbe81eaf821c897369a65fec987b404
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5f1e32e323157c71eacc6fe087db8d586ff6cb5
Message-Id: <166042728941.29926.8488885026542611743.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Aug 2022 21:48:09 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Aug 2022 12:40:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-08-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5f1e32e323157c71eacc6fe087db8d586ff6cb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
