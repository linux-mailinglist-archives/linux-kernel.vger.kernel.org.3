Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE353DD80
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiFESDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351502AbiFESDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:03:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35168625B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 11:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D45D5B80ADB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DB5DC3411D;
        Sun,  5 Jun 2022 18:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654452195;
        bh=0xWF1lBWlOAWJvxYs4c9lqM5TmiaFxiok615QB5miIw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n3MqMjMjvJuC6JUP3lTO+f9eet/JSIW/7qVsrcLBFoo6pxo+SmhqsCJdhUSBWtRAs
         r4Y2fJZcI0BqJyOQEu9RGc+1ft9QioDqYf7O+jrsCFLtC7w/Wvf5J595OIhcHzXO0b
         jVZo4Ouvv/rwczPWGn0I4llbnMJRudJpiL80hCrnBPHD/ngXKo8xu/nFIaIS+AK6NO
         7KaPTxjMvYDH3h4FW6h65wEFiemhQSEpGxe+ifPzBzofcsIFujtW4lEcm3QCVwE78Y
         b+QBwmDrbChkhMTL11+maSQBCZKCa2FYUnftZN6/sT2s4epu+YxO1EvyZ7iDTzh2Vk
         FqVtVJ35N+7OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BC8BF03950;
        Sun,  5 Jun 2022 18:03:15 +0000 (UTC)
Subject: Re: [GIT pull] perf/urgent for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442137256.152751.9491260964554807818.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13> <165442137256.152751.9491260964554807818.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442137256.152751.9491260964554807818.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-06-05
X-PR-Tracked-Commit-Id: 8b4dd2d8627e88dc3bd71bf29c48aaae2b69572b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa11c2804652809f93f79722e770890b07b3953e
Message-Id: <165445219550.28605.5281236617663610263.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun,  5 Jun 2022 11:30:53 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa11c2804652809f93f79722e770890b07b3953e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
