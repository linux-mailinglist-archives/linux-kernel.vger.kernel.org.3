Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92AE4F9BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbiDHRs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbiDHRsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B02BF947
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D006E621CE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39FBBC385A1;
        Fri,  8 Apr 2022 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649439981;
        bh=nb3cIGPWQg0suUl8K6PLtfrv3tfNMQ5hKjR/Rw0/hfM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wk7BeSOlEEgZPTLM5mo1pFnYpO3SxL0IUvxe2aSr1Sx7B49XhwgN8fb+4uOODdlSH
         PTX37V4d662PU8LfD0dev9VqWuf/9T06FFJu836tDgIGbetISVE1y4JfR+bxoW2FKj
         t/gIoPSihJcdpSQBrmnNYpDys4XckQjNFmTnGTefEegu8wkK9iPq4nbOt5weH0eez2
         4Va/WDIZne12jMqa/9grNNv4Ba6kzTEt1CeYqs0xrmKTnPyfAGNVxbs7VVoypmv/+c
         wMBTF3UyHcVWwjZQUnKix64wcIjrb3SVru/I2Q2seJxKPVuReMv2OSyaafhFPwIvX0
         XKZnZJgd3NXsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D321E85B76;
        Fri,  8 Apr 2022 17:46:21 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220408162900.GC28108@willie-the-truck>
References: <20220408162900.GC28108@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20220408162900.GC28108@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: d02b4dd84e1a90f7f1444d027c0289bf355b0d5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0aa53389b0c869be2e4373594a1d10e8499f5b0
Message-Id: <164943998111.23047.1066908415289438402.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 17:46:21 +0000
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

The pull request you sent on Fri, 8 Apr 2022 17:29:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0aa53389b0c869be2e4373594a1d10e8499f5b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
