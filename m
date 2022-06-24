Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7165E55A1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiFXThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXThO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:37:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1BC81DA6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BED24CE2E50
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 19:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D47FC341C0;
        Fri, 24 Jun 2022 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656099431;
        bh=LgXu9p3qO29gKCNdZSeymheH+7qUMJ29Icfx2fBLIaI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=toLOayYmotAOrNDg/xUWQyxPcS+xatJ2UCnzkBgv8PBrptkqUySp6mRC++ZGG/scR
         vDNxfq+lmYkVveB3AeSD4sYkKpChdN0LvzeGv5GMn/aAmKFJF6i6Ft9/lmH6CKdv/O
         WdURQGUqmdzD7+up1DOCwDtC4audF7YiGFfu7APCSJUJSp/0SCaG9OTNS5br0GEP2r
         586MMq7Xoct/GXMlFfgdLtDEo+yiXYVe5FdKIqJvZnqv7v5EiQBd7GX8XrgHuHYn2g
         WMHUeWDL6j8emYWOo6jSxxEUMnL14qVh5e6+/H2hKl4lD+mGQtWaWblE/08FT/pk2A
         WYlMCW+xEDkSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFAE0E737F0;
        Fri, 24 Jun 2022 19:37:10 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220624160736.14606-1-jgross@suse.com>
References: <20220624160736.14606-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220624160736.14606-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19a-rc4-tag
X-PR-Tracked-Commit-Id: dbe97cff7dd9f0f75c524afdd55ad46be3d15295
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c39d612aa5f34d63d264598692a7e6cd4fb34eb
Message-Id: <165609943097.3020.15887140717397581468.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 19:37:10 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 18:07:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19a-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c39d612aa5f34d63d264598692a7e6cd4fb34eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
