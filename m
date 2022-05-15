Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625FE5277E2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbiEONtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 09:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiEONtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 09:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF49BE08D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 06:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B1660F99
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7D09C34117;
        Sun, 15 May 2022 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652622538;
        bh=YNMKXR9/On6dt69A4IzKm1w5K81dvWUWoZWtxwniudA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e5oJ9mPSRTjuGaxeYB65Rd5VdoZmLcHhMpAYFhkNLMkLrz8Tl0Hqt3KUVPOZZg0AA
         RJsNTKC84TbdZ+0pOhImE0X5pjW1lHLIXDbhK00c7urnCABftxa+ssQkNejQNYT6VK
         gpU8JYdIRZ8Wm1axDKKVzbo0tGshv6Z2F0OcSECeCVj5FIGzvWLb7Z81nrQVeQ0C+F
         VKTznoasy+HqjT5U7E09cK9ceKCBMGMHmJYRdt13kEyHx5ZjJHGTgQiFmKDGJyb9VZ
         FlhOiQtmRU2dzbZ14mdJ16VexgmeY9StRNfcPF22rWAyz7+tUZ5igKQ2Ay8EMUgBEG
         QiBL+qRtwMwSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC17CF03934;
        Sun, 15 May 2022 13:48:58 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165260667688.920532.9348188301647885947.tglx@xen13>
References: <165260667543.920532.17932536291158599837.tglx@xen13> <165260667688.920532.9348188301647885947.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165260667688.920532.9348188301647885947.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2022-05-15
X-PR-Tracked-Commit-Id: 9c2136be0878c88c53dea26943ce40bb03ad8d8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 990e798d182a63afba6cc990f5bcd42d18436b55
Message-Id: <165262253876.32598.2450546287652382035.pr-tracker-bot@kernel.org>
Date:   Sun, 15 May 2022 13:48:58 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 May 2022 11:25:07 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2022-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/990e798d182a63afba6cc990f5bcd42d18436b55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
