Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17AC4E3189
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353153AbiCUUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354032AbiCUUOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB8C2D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDCB161149
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30811C340ED;
        Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647893557;
        bh=iyVb/Rmq9tMHtRZgLlJfByrNBe/aWCcxAxTy7OvN56A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AWK+lmqUTrdyj22/R+Gn2ri9G4hP6i01lLPUhE4wpyKEjishOMr7Mby0VTi2RRgFU
         kviqr9O+QS6r1tg8doik+RcfqOw+jioIMI2m7s+SpGr0q9n9F1LI3VVtaMzTt3Tw0r
         aAr7mgh0Mz9mZXx4NhM9E31LWqjZmby7ZN0zjOQ/D5h7LP3KzIhoDC0grXVqppLeld
         HOUjJwxUJpafL75tTJKkeBh9alESH+uYkTXCi9qO3J08Eu13X66CPBPmq4C4FGKv33
         VAzKT+hG97lwQl8+NcRmlKTmOEGfgPyPgRlrpgbJqJpplLzuiPLV/u4VM6PIyCls+Q
         S8vKJMX6nsXbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16DC1EAC081;
        Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164786042731.122591.2741068913623154.tglx@xen13>
References: <164786042536.122591.4459156564791679956.tglx@xen13> <164786042731.122591.2741068913623154.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164786042731.122591.2741068913623154.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-03-21
X-PR-Tracked-Commit-Id: 411472ae5bb4ffe1404dc5f1505f07e0f04770a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93287e28bcc8bcb3f23d46196845bf7c311cb8aa
Message-Id: <164789355709.19380.4380649736148380559.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 20:12:37 +0000
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

The pull request you sent on Mon, 21 Mar 2022 12:02:24 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93287e28bcc8bcb3f23d46196845bf7c311cb8aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
