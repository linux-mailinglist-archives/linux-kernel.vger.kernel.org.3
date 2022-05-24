Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91C5531FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiEXAXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiEXAWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:22:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE542A30
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92E9DB816DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 573BEC385A9;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653351770;
        bh=r8QUEmjFqVC4EjExfAov+i6cm9Y6w72IKy0CN2K0J3E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iOnvIlSxhev1TjANldl2QfZ2YvsyD4hfmHvETNokGHIrLS/9tepu+HH3KVjNd7LrY
         RUBFnskgkgBIdUPISN00xBDPAhx5yBK95aTtmf5DVz6Lw1+OcWdOtAjU4/dbQe6ZZ2
         UgcW4f5ihrrEOAMwas0E0/skald1Mk7boy0NvFWD/U+k+YB4a9ExaiIMWv0Jx3WAkG
         89mPCq2hgYpsCaeIuue0rcGmKDlEa+R2/lz8yAubwHFDUTx9+0FdvaQ3vf/LKCnZiG
         +e4uBVb6BRuw5tY3NdKPp6bB4n43YF8pzAH08ORZ+KGO5vpdK1X/ppIVZI6m/bWUpA
         kbURr96BtoIqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37A96F03938;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165329268192.3801280.7168389137324540940.tglx@xen13>
References: <165329267741.3801280.534077656528571075.tglx@xen13> <165329268192.3801280.7168389137324540940.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165329268192.3801280.7168389137324540940.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2022-05-23
X-PR-Tracked-Commit-Id: d308077e5e4dc8c93f97f5ebc70274e7c7a92d49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28c8f9fe94c4e0b0c27383d48da3c85b0dc17081
Message-Id: <165335177022.4476.1419070695119630090.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 00:22:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 10:02:08 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28c8f9fe94c4e0b0c27383d48da3c85b0dc17081

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
