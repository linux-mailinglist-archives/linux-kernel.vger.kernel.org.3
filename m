Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127B5A2FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbiHZTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344998AbiHZTJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318F8DC0B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C631B61E61
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30A19C433C1;
        Fri, 26 Aug 2022 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661540964;
        bh=HOVDYXATetmyN7jy8n9mBEj06qUsyen4zmVNe7LZOzE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MMjkj40LzvKgivKTIi9tMKv4Acr258gTHIBUCxz30/RsmCZY3lrpbn+h11oiGwAWH
         U/cwKW7nryOCec5bpr1AjkAhifmWAGfqudSR85XjAdOrtXn5yKDFasrOOhR6HUrjgz
         Iq2W6ILXUj0AUQqfbc08wRDql4aixgBsBwUUxvfY2TBn4ryfNsZfO3xykEiujIv5FB
         GQnfeKNXWLN2itWvWe4kAFF9FK1gLFAly55XbIah26U1halo+rcubGc8sMKYNPrBwA
         ccPlxqHu+s3ObFUEl+Q9YcP/Z8I+rrfLnpyinsdr8OevofpyF9i8xTZ9omIPUD4+Ig
         W+mkXXGn1Hw/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E3CBC0C3EC;
        Fri, 26 Aug 2022 19:09:24 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220826175857.GA20431@willie-the-truck>
References: <20220826175857.GA20431@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20220826175857.GA20431@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 714f3cbd70a4db9f9b7fe5b8a032896ed33fb824
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e022620b5d056e822e42eb9bc0f24fcb97389d86
Message-Id: <166154096411.10698.10295862005173961891.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Aug 2022 19:09:24 +0000
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

The pull request you sent on Fri, 26 Aug 2022 18:58:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e022620b5d056e822e42eb9bc0f24fcb97389d86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
