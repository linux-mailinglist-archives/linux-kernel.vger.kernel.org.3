Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806E35152CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379784AbiD2Rut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379783AbiD2Rup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:50:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F89398A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDC24B8376A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94A2BC385A7;
        Fri, 29 Apr 2022 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254444;
        bh=sjogVW4WSI/rvmmsuS3ZMJqDdqcIFSbwKHhfT79lTzk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nTTAKwdjj+rs+oWQBMPL1SBOW5NkVhxQ9oEeqZ3IZVV6v/sYKf+1/SruDnOuUoLmU
         N1iizOgpKSMh062xW4K4zBqq0JYwuCkQzL79DUkLL3Bmy2WAKZASySiS130AIDbzZX
         hdGlKQppMejYl/C7YJEAaaW2coPhrrwL4zD4PBIaA7pDOcsLlg8weP1HZdPlqKEY9H
         y2ySTnYt2AgByesXFeyESCLExMOeP1ikr/bG3iqT0m2B+g1a2TjmMZF1nfMfy266Ih
         HYu+DCdUXZ9lbw4ofA3qLo1M0a69sPaHFovnnXb8zSBmAaCVxo3d/EEfyt62qAdFoO
         goP9lTaOuC4yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81978E5D087;
        Fri, 29 Apr 2022 17:47:24 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for -rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220429113353.GA16032@willie-the-truck>
References: <20220429113353.GA16032@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20220429113353.GA16032@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: c35fe2a68f29a0bda15ae994154cacaae5f69791
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66c2112b74c2b94ee5191bfb8acb717b79377e98
Message-Id: <165125444452.17620.9895574266504196013.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Apr 2022 17:47:24 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, luis.machado@arm.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Apr 2022 12:33:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66c2112b74c2b94ee5191bfb8acb717b79377e98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
