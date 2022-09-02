Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34A5AB835
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIBSaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIBSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8666C3DBDC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D3A6224A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E8B8C433D6;
        Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662143408;
        bh=uxtdPZ3fhiB32CN6nbo1e241h48rcaxhnJhuHSq44Kg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JsmyMdm/OCZasRgIKltLzOd2aR7qjYkECF5pgFbcOYBxNPFcsqs8EKZqmZx5YAObR
         IDDRaiWtYlCkFdICtNuAoX83Ep5Zwm+cLbstWeRdM0UYNOc2aypPx26BsZUr8k2G6e
         c/BRlkAE5yADatuQQtx5VwOAvpTp9rrdjHmrsCoD2a1bPCVb2IKiFwbh2GFa32giPQ
         zuUr34Rr2S2L+5gvWPWuhijahQKSJQFNS0RDemJIiNO45iptgOuIaHfFDAW0vfBtDb
         akX3Xar67svDhd7bQ05OnpRnmQ64acWeI2ZTlF4ErnmKQcLFgTJs8B+G2l/etnk2TJ
         2r3U+QktrIKYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C5F3C73FE0;
        Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220902111204.GA25902@willie-the-truck>
References: <20220902111204.GA25902@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220902111204.GA25902@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 5fbc49cef91916140a305f22f7430e9a7ea0c6b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf3488fa25cdfdd220dcc927ca30ea7256b037e0
Message-Id: <166214340811.20636.1316986216638306178.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Sep 2022 18:30:08 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Sep 2022 12:12:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf3488fa25cdfdd220dcc927ca30ea7256b037e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
