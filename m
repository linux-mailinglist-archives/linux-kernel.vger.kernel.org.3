Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC354E318C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353220AbiCUUO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354041AbiCUUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:14:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D147EF09
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D1E4B81997
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45196C340F3;
        Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647893557;
        bh=Q1RScy4V0b3nF08oSoETGpIOreCScBg9dOooDC4sVUo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AUvjNmp9UlDz0KAEKwc+Hg7fkmmBKyiruT3Qu2AYRJpfmFUrMFLCREPV5sYUcmDR4
         OHPsg3lORr0KG5AZuRRIZC77b4YCc5A5X3F8JS9MQuoJzIMaoQkWMy1gqfOrGjB9bo
         BQS+X4EkV0xUMZdoPktyxZGhvpp81JeplztTQ4NVFM7YLtLDyjldabdcOdjjmBf/My
         EzKJuKOMfgzAhU60iytRf0tFilC8zQOPbeXkLFCI8OmtLnZQSO8fYupaZJQydLtVIC
         ZHzAJ23x/hl44vP/5LLcmP0hqh3QjdgUiYFdeMnXPVYj6j+LE0fSoq4Z2zsBSoXlgS
         4S78zIEw9QO3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AA22E6D44B;
        Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164786042893.122591.10484394565817935694.tglx@xen13>
References: <164786042536.122591.4459156564791679956.tglx@xen13> <164786042893.122591.10484394565817935694.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164786042893.122591.10484394565817935694.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-03-21
X-PR-Tracked-Commit-Id: b166e52541f2357ce126a92ce1d9a580fdca719d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84c2e17951feeea08a1f3a01e71f8fa82b66332a
Message-Id: <164789355717.19380.16253771501184597937.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 21 Mar 2022 12:02:25 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84c2e17951feeea08a1f3a01e71f8fa82b66332a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
