Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38253DD7E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351466AbiFESD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351452AbiFESDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCCCA45E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 11:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CBCB61180
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1113BC341C6;
        Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654452196;
        bh=0M3mEGNT8DB+yAXb8Ws/ohN6wm4JDDci7YNZzgN9LSU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c6JNhRk7Ba1Z5d2W9tXsIWqgK78LoD4RpEiMFW78SVW4ifp0mffa8KvjKnZVHO98a
         qIlAJ3ujskQZIvWfVrbwEY8Fz6d98zROPjlBzDdou+cSierBzgNj/zwAwUcQYmME7d
         apc/MESmyWMHdnevibqvp7ZwsmZ/goC9jFSuRpVuH3C6k8rdpg0evLpCp1XNNHuOnX
         UPoQxd+jo6Xyus4bZ/dy7g/4dz9B7Xojmn7Go7NASZNmTwzJ+3eIG8zjTX0mD+1CWT
         BFfgH5FvrrpAMIVZQPUP2hRCGmWnGnlWNksA2jlhwIzWi4wZdWi74TQV8dSo3fYruE
         uV2as/LRUSOkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F33FDF03875;
        Sun,  5 Jun 2022 18:03:15 +0000 (UTC)
Subject: Re: [GIT pull] x86/boot for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442137692.152751.10573871631238612414.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13> <165442137692.152751.10573871631238612414.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442137692.152751.10573871631238612414.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2022-06-05
X-PR-Tracked-Commit-Id: 8a33d96bd178d5f49cc5c1898e4cda08e221d2db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fd9f4ce8442e34d4f817924d191d2855cdb80c5
Message-Id: <165445219599.28605.12183186294405566341.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 18:03:15 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  5 Jun 2022 11:30:58 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fd9f4ce8442e34d4f817924d191d2855cdb80c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
