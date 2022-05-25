Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9938534464
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbiEYTkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344820AbiEYTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:40:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0520E66F98
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B6D6CE204A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA7FBC36AEC;
        Wed, 25 May 2022 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653507626;
        bh=sgDgDPQxj8AwtGaSmHSDbCjFih9NYYz82NSq2dk9Y8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p8N3Cd2GyyUg9mceB6Ht0WV/ka25VyG3gHa6gwysueY0tcw373NGcN3ZVT5i1YDka
         Ixkhc+Oi3SkkoWU3ZQ5mS0Asg4dG8D2XTVrdNGhf1+rtFujbBfqdSX96NaC2OpDmkg
         iQjAnUGFEvbwgzTmKEcdIYiDlQfC+lDaMdGAwe4r+yCXoxikDwOsJ04PfbSjFZ8+NY
         k/4LJMbD7vhuxqZEtI46WaUZwkkT/DGAF9OuxLNt8VWF45tiPywPSKqNgX70e5jDQS
         X53nXMb45nM18cXGjA8qezkkAXK5LlPVBS0q8dXSm85n1Pfh4iQBEcFa/xl3yaIRth
         PoxYgTVlgVjwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D45E3EAC081;
        Wed, 25 May 2022 19:40:25 +0000 (UTC)
Subject: Re: [GIT PULL] wq changes for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YowdToGDbq7S3PWa@slm.duckdns.org>
References: <YowdToGDbq7S3PWa@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YowdToGDbq7S3PWa@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.19
X-PR-Tracked-Commit-Id: 10a5a651e3afc9b0b381f47e8930972e4e918397
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d1772b1739b085721431eef0c0400f3aff01abf
Message-Id: <165350762586.19106.670060029492259761.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 19:40:25 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 13:48:30 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d1772b1739b085721431eef0c0400f3aff01abf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
