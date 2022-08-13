Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19259181A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiHMB04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbiHMB0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:26:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88F979D6;
        Fri, 12 Aug 2022 18:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5022BB8254B;
        Sat, 13 Aug 2022 01:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0309FC433C1;
        Sat, 13 Aug 2022 01:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660354010;
        bh=kr0NBO0fEJMfjIoMPVV07UBeKAugpWcUVnWu6EVtriM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DkbUCUj6cvpq9ckQ9mdUc3YQ2psvw53yDbN9jlbGiDvfoWLpUWFeyRUuCx4JNUdvd
         bGlqR84F0zunaDStSgxBvd6nyL6myubCFFQV+PgyecndT1vaBgK5OrFYJsYtMCruCx
         tbfWo3apMetYOmGYMd5oU0umBarbIeWju3FoAYmIQnea1UA+yC9wdyHHOUuCegJXYy
         7qwJe82hXth2sWnCWCtlKfQTl/wV7FQNFiqbvqcv4wQOzPVbmphbqbDokAFxdzc9VH
         MX77Zm22jJdejCQAZoHhPhVwD35l842nIdpgG3OKSrZs4TBYh7mG2n5XTWF418BDCw
         aouVDpC4s7Vfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E464AC43141;
        Sat, 13 Aug 2022 01:26:49 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvZ1cz2TBIuyZ0md@mail.local>
References: <YvZ1cz2TBIuyZ0md@mail.local>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvZ1cz2TBIuyZ0md@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.0
X-PR-Tracked-Commit-Id: 03c4cd6f89e074a51e289eb9129ac646f0f2bd29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d076fec5a0c3e66e1d8cb16015ea9a59b66ae1b
Message-Id: <166035400992.11884.6679624176429083904.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Aug 2022 01:26:49 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Aug 2022 17:44:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d076fec5a0c3e66e1d8cb16015ea9a59b66ae1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
