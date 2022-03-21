Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6964A4E30B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352775AbiCUTU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352714AbiCUTUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3375B56434
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BD5360B99
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0877C36AEA;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890313;
        bh=sdquPTFPTkWf8jvZG9WnFTSfuJF6ECNv47jEUFOqaa0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sNebh0BkxsWd+24CwiSFs89FPufMTHoVON/6pOBAjsFeV4ZI1cC2u9b4Ht1wrPClh
         vzYRloW1L6lv9KLLkPq5fvCuIffxOZ4BDdPyDW2zce0b5JCK7F9rqzUS8qeibLB5Ki
         soBioqJ7UHtcopIicslRHDizyokGWHlmqt4LIxwFaLYbAAMkJ8xKIKgeMRVjD1EXLn
         pwK9Umh9BmNek1DaGty4px3epFW3ueZksTM0AoVPzu9UKOwLVf5lBB6WXLWoDCw9D9
         M6ClHWlzZv2cgEGdp/IrGRdWdksmSUWacZlacgtth5xLAWk5OcRnLLLIxyBEfiAXXz
         gswB7tFkAHjQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F0B1E6D44B;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220321091443.3563010-1-geert@linux-m68k.org>
References: <20220321091443.3563010-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220321091443.3563010-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.18-tag1
X-PR-Tracked-Commit-Id: 0d52a01a266ba21840c7cb02e1de39c503759dda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b74b4600d0318fd81aceb5a7b7d10432bc2306b
Message-Id: <164789031364.24158.14506912834558426905.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:33 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 10:14:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.18-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b74b4600d0318fd81aceb5a7b7d10432bc2306b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
