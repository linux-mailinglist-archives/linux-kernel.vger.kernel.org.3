Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ECC5AC15C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiICU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiICU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 16:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E4B5246A
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 13:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C472D60DE9
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 20:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DEF9C433D7;
        Sat,  3 Sep 2022 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662236950;
        bh=Mf+tK2Y3ypAtX/kvPF7uzRvJIYaqF6rhBP6iGfMIOfY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F3tJ4TprMNuh4pGYCdaXhzguaGi2fsdfeCI0Yiar0ifXpbQ1K3usxFAIVP01qVgiB
         I/C4UwpOuWRlWkevVLTtTVcShJiXi/cEMJmcey4aHOjs/rai0Jr9cIVnXOs3EIXSE7
         5O0ykDE+rTZvzVbj1+B+olnHdBob2XYC4V4cLV+shOWhEze+MCxk2irWISK0/Cpm9S
         nfBNjcUkNcQTR7XWQ/JDK9txvtIunTzz0jk6actxKeMCyRS4q56zKXiZjtgkArbhqY
         inkOG24UYo/G3YUv1yIgSgbsXHq8f0FTyCCck6wWLxPTutKBSJBAbYET42Syndwc2x
         EOKFexc/5igVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1441DC4166E;
        Sat,  3 Sep 2022 20:29:10 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220903145428.29553-1-jgross@suse.com>
References: <20220903145428.29553-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20220903145428.29553-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc4-tag
X-PR-Tracked-Commit-Id: e9ea0b30ada008f4e65933f449db6894832cb242
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65eea2c060aee3bf6d27ea365360059fbd4eeff4
Message-Id: <166223695007.8828.12790840864237325625.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Sep 2022 20:29:10 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  3 Sep 2022 16:54:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65eea2c060aee3bf6d27ea365360059fbd4eeff4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
