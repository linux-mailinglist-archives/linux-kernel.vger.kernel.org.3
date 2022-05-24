Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD34532224
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 06:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiEXE12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 00:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiEXE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 00:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0894253732
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D156613F1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB8F8C36AE5;
        Tue, 24 May 2022 04:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653366443;
        bh=YWdB8/Incye7PGPIuU1l6D/SUgnj0rEJksuUsdYNgS0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gfJIFSv0Pi9cG72ePpJcDJ+SNwz6qGj3HuHRzyAOlfHuvvegNXPnxmFcgnQuFv7lo
         iURcDll5Xe+3ZC8z64aw+Id70rjqYQ5ituWzRKQqrdmMrdzGwkWNR6Czb8IAzRmVlO
         9VcC7r7e4ww8zb6P/B0nb/ldh0ICz3mbAfeAD/Ttr77LtoGUoDd0hDe16Q+RLKotym
         hXjeLs3sBkGGjy+xsp0/olD+RbOpOuFUXmbV8HN+GmjRs8OY52qhZ0aOmo16hljl5o
         FJyu8ilnPaGRRmdBjQYozS8lOdc2EE3ox4rcReBizocoT7bjosjToxBLkfSFroH0A3
         PAGkQDRnq09QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5F42F03938;
        Tue, 24 May 2022 04:27:22 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523053104.22814-1-jgross@suse.com>
References: <20220523053104.22814-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523053104.22814-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19-rc1-tag
X-PR-Tracked-Commit-Id: 5b3353949e89d48b4faf54a9cc241ee5d70df615
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d61306047533eb6f63a7bd51dfa7f868503bf0ba
Message-Id: <165336644287.29742.1454436360715375036.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 04:27:22 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 07:31:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d61306047533eb6f63a7bd51dfa7f868503bf0ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
