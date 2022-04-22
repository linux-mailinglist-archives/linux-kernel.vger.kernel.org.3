Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1286150C3B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiDVW1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiDVW0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:26:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA18E1F8EA8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A64AB8327C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 21:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26877C385A0;
        Fri, 22 Apr 2022 21:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650662372;
        bh=JltY5SgRj4SMIne9Qz0JW+LdMIJBk+be/f2l+85oq44=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RhIxxJw4KncFu3j/4iLRmd7paprqCT2PcAXyyo23e0BmjiIzYx2M3X0fdjp/yVnVJ
         1kuNGH3Lrt/s/8mpgOKNfAcoNXW6da5mOrMFHREuRb3Q5tf3s32ahRLUxPyfhATOkt
         Si1RuOlMjN2bNNSx8dEwkOoncUZ9t0emZZnHAKIP82Jr7qAAoE2uKyDdUuxSlYOzMp
         PStl9p5fogPVUC2pfdt0ALsmbA1QfDQAqEYRsVgbSoIfOJSgPT1CY5818Z8jizvFim
         GHy2HM2o2wJ3qyEhRXS+KRrO1bp3lZ7TurkZb/ZegygGe3Sq8pkausc/6PXlKrrSc8
         h0UaDiVU6Lg8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 135FDE6D402;
        Fri, 22 Apr 2022 21:19:32 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220422112028.GA9901@willie-the-truck>
References: <20220422112028.GA9901@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20220422112028.GA9901@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 23bc8f69f0eceecbb87c3801d2e48827d2dca92b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7200095feadfb9792b744a5a6e20249ce77bc6d7
Message-Id: <165066237206.18077.12690335175852932937.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Apr 2022 21:19:32 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 12:20:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7200095feadfb9792b744a5a6e20249ce77bc6d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
