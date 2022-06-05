Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BBB53DD7F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351527AbiFESDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351501AbiFESDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:03:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E512A14019
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 11:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FFEAB80DD8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F8CFC34119;
        Sun,  5 Jun 2022 18:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654452195;
        bh=TXr2LkkQH8qNZASsnTzcIyqs4tEphLTFPDXzCKs6tOA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KodaMub8UGC6vpUP65UkVI1vVOxah73JCD79AEgrA8V2hOVW2IKO/1F7wIE7ymCZe
         XNuTlhn8c9XtEKzlbictiEh9EM0l0bKMx9iYvQemDADr88cFuj3dYEMzpUxDgymM6a
         T+ZbNqhWJ5WBfq8RdQhd2+VKenXxIdg9mOXvK8X2TCdFh79UEHPTAPsDpa6KkJxgCt
         /NUFyKyFwPFDDIQWvPi3iKQnj5pVOB01KnHbNoInGSYK6kxexhm5blNg2dJ0kJfjJo
         617DtORwDjY8CZCXhL+e3tVHpqnfMx2kQDDLz7GObmZ4oMHKbmQWY86bKTlxgKV0Pn
         f8b8qt/sLg1Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55A2BF03875;
        Sun,  5 Jun 2022 18:03:15 +0000 (UTC)
Subject: Re: [GIT pull] perf/core for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442137112.152751.11088244246622721652.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13> <165442137112.152751.11088244246622721652.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442137112.152751.11088244246622721652.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-06-05
X-PR-Tracked-Commit-Id: 108ea7eb3e754be735a1c33d2713a19527fb2065
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cc47d4a920c4766c5e6f4667d8e5194fccfc862
Message-Id: <165445219534.28605.16272143844069161378.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun,  5 Jun 2022 11:30:51 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cc47d4a920c4766c5e6f4667d8e5194fccfc862

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
