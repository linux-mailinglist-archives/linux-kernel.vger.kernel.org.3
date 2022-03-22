Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB324E49A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiCVX3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbiCVX24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65146532EF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0128B6125D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69114C340F2;
        Tue, 22 Mar 2022 23:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647991647;
        bh=raGDJnpiOkzFxVlHJXg+myOWavCaRyjpbJikY5YKdKA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BjJhECdWDg9EcEDIWtMqghtuA/KclGOFSp5q8g0KCQANKJ1gonYbUUqGY02lbffCH
         Cn2kE8eAtd/GBW6H4nTzsr6IkL09CD7pHg0WSR7ZlyJ96sFx/vxKPaZnFrurt8WhWZ
         skTZaPmC2reKcmtZtxrdM8jNDQFE3hXe1Wzbsx5UHguR4Z0LllH1WlwoepWgZueDlh
         1emXro55z4cA5WvogJCpdfRscqm14/XVWHKUpJ/Igx9kxsLNiWYYClXMmbuKhE+4Rn
         ie8c0PF+KeUY+IydAUxmTuR0xWXTSGzD6c9R5X+/jPrgp00REIcivIB87KAnd2DcFQ
         qXeAR9rfHSi3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57010E6D402;
        Tue, 22 Mar 2022 23:27:27 +0000 (UTC)
Subject: Re: [GIT PULL -v2] scheduler updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjmulZMqswiXsuki@gmail.com>
References: <YjhZUezhnamHAl0H@gmail.com> <YjmulZMqswiXsuki@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjmulZMqswiXsuki@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-03-22
X-PR-Tracked-Commit-Id: ffea9fb319360b9ead8befac6bb2db2b54fd53e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fe2f7446f1e029b220f7f650df6d138f91651f2
Message-Id: <164799164735.11565.9583328147558087117.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 23:27:27 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Mar 2022 12:10:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fe2f7446f1e029b220f7f650df6d138f91651f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
