Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E114E49A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiCVX3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbiCVX25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:28:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4329532EB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CDF0B81DAB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F110BC340F6;
        Tue, 22 Mar 2022 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647991647;
        bh=AWlB00YHGmlczlDQEJMBKfhu5pKN7oMG2YtAaMytQvw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vse/EBiQnxCb/grk+0Paqknt+QWE+V0NYhXNfhgbUBbAvxrUCAb1T4s4/4aJGn6Ru
         EesE4afTbtRzhvu7v+QRxBmgTuMz1a8S4l/s7cOWy0pnpo5n30iAVHpmLKPnPsfQ0d
         EeLVeY+w+/QT4q1lteXKjpQxW5KnIMsWlA1T6pVjirUhOMSBTwGNpqUmXxbhHlrN3Z
         b7k6gHzhMfk/1PrMcTgCFqBX6zfKMpezLGtMo6UzFeLjtxHuCfoFlnKI/mRIa8qHvy
         1JXUGXjdj6anKKjDMyY2TEI9CIUBM3zaVIG5CBGTQYZDD8C5LNhDOZgISWNnqOcJN+
         1laWKg+JcurMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF02CE6D402;
        Tue, 22 Mar 2022 23:27:26 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhdcJB4FaLfsoyO@gmail.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhdcJB4FaLfsoyO@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-03-21
X-PR-Tracked-Commit-Id: cd27ccfc727e99352321c0c75012ab9c5a90321e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebd326ce724d5b2e5274724e6d6a46a046e28203
Message-Id: <164799164690.11565.4407042081542491958.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 23:27:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 12:11:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebd326ce724d5b2e5274724e6d6a46a046e28203

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
