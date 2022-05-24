Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C59532144
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiEXCwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiEXCvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F171220D9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C36FF6126D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3F34C341C4;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360675;
        bh=S3LHajDuAdF+hMV4LcZoq9Yrxuz4UBlcg88sVZyE0Jw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HHR4EX1SMwQZdPzaff9jxosEcr8JbZVmZPJtFLv3/R0gsYyoDurkD2UNj3VTwV4lR
         m8OO+bpmgsIvokDzW1ykwV0jRrFuOy79lyeV/WlUBU9vP5/qB8yF565Owhn5xSwbQm
         44+KnMM2FN/4YBU2a85H1bt1COarkZlhD488Sl2/unc2xVrcvfY15r9pRCGRP/jkZe
         vaMx4hOOH2YNlwX9SRbDM5Mc86pe7PYKOWNepc5xnC9U68LlTO5vl1PsMwWeURzCsR
         clKIc7IyGRPyftR3vqWAtMn6wRd3LNZrlnHFUaU1QHsltUOJn4bqk4zP+ghtpGsXkF
         3sqZo58T5sfoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADD8FF03938;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YougA/80bebDPSkh@zn.tnic>
References: <YougA/80bebDPSkh@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YougA/80bebDPSkh@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.19_rc1
X-PR-Tracked-Commit-Id: d936411dc9caeb3edb992e39c33d4d1d81ca8c08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a13dc4d40938787cfc9e520ed426df4ebf48b1aa
Message-Id: <165336067570.14181.2664510930390742065.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:15 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 17:03:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a13dc4d40938787cfc9e520ed426df4ebf48b1aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
