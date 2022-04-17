Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2F4504888
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiDQRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiDQRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481ED1C938
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C2E61278
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AC40C385AE;
        Sun, 17 Apr 2022 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650214742;
        bh=Jlc5kOdOxBvt8DQQykyopwbD4HZ/gGYyDnRM8jpUawc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GmhYWYFMeRVkZqAFvNrUbynue1zgT0k6S0H6D14GAFaM+92IDvXn9pcz01sEwSzVx
         r6IeW1KXokUZspw2FvAMuzliCeqj85FaEpOF7BZJQxM9OMSxvaFs4hv/7C8HuHnUtA
         mu6MOOoCNZpxPEuY2lYuugQPQVmWwPmJRBQPMS0CffM2vLJbR1p9ApPFPEOo+GfiyD
         OXZbFiN6vfN5iPzRhtZ1crbDZli76UpIeovSavyfiCGUqF/ANK5lQnCPM10WdyUk83
         exVIYUOTHgzhisZcEeiUfMBcQF91rLUSKItgZvuJxIz7WFHqhbItVLVZq3i/68/GhQ
         hP3ajoK+L8MbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2199BEAC09B;
        Sun, 17 Apr 2022 16:59:02 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165018953883.44773.12883227528447853271.tglx@xen13>
References: <165018953450.44773.6382828227632028472.tglx@xen13> <165018953883.44773.12883227528447853271.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165018953883.44773.12883227528447853271.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-04-17
X-PR-Tracked-Commit-Id: 400331f8ffa3bec5c561417e5eec6848464e9160
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a69a44278a72e15f12e24f5db4d277a497649aa
Message-Id: <165021474213.4330.4186273817487618260.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Apr 2022 16:59:02 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Apr 2022 11:59:16 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-04-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a69a44278a72e15f12e24f5db4d277a497649aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
