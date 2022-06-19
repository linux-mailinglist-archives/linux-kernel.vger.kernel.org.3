Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624E2550B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiFSPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiFSPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:01:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68649FFF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99F3AB80D33
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56FC6C341C7;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655650887;
        bh=gBPp3T5b5oU6NCopSz/p6jprpNdE+gFRnDZtVw++wCM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S7CntCSzTesJN6Djpuun0p27OHcMBZzTCwPAGbsAMftgyb1zk7RCH/n3M9vTGeCmk
         eQW371y7Eub0zT/RqZbseUXMMwg25uMiSuUWDZfNy2IF+8XWbKNv9texCElfn5AWrW
         RSdFrd9ZyQPuiySmyLYFTK074MiClzmYlY8Pt5ZzjhztgSAAw8AF3f29il82/zV4pe
         U+a3duEZipauR0ociH+3rVOwOJjYwgsss/VtVcvZ0YHnAN4FJs5sOZ1e5FGTrNG2oA
         GazO73xfag+qgpmXAqkYHwSGGt8ndkLB0OIQ6lNyWtecrHkQuz29h1dm9zBvRVU4HF
         0ly8eXnBXFLBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E248E7BB29;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165564429738.1413209.17302088152547038708.tglx@xen13>
References: <165564429738.1413209.17302088152547038708.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165564429738.1413209.17302088152547038708.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-06-19
X-PR-Tracked-Commit-Id: 6872fcac7158c3b3728a2ec1ea771ade0e61ddd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36da9f5fb6e3a0a88ba28e5a7cc7d5449641a286
Message-Id: <165565088725.16911.2695039621496776637.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jun 2022 15:01:27 +0000
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

The pull request you sent on Sun, 19 Jun 2022 15:12:33 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36da9f5fb6e3a0a88ba28e5a7cc7d5449641a286

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
