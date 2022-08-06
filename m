Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9978558B7A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbiHFSUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiHFSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:19:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C2D1057B
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6178FCE0908
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9BDEC43141;
        Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809978;
        bh=7xbIJftxaBIt9XELBds3AoojCGvYAnsU1VIfUuAC/rk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mbi16ak5SNNBbB8w7sLYKg12aQucV6+cNbxNUKTfhDPOlG6vSqS1Td8A8v0oBEngU
         7wtFe1F+lHYuDWoh9RZzaIjrqV1v11Sf8s7FgIpdKgQrjb5Ibd+iSp9VJGbiatkmmd
         nwxqYuwnL1fk9IHVAvFBcrJlZJg7llbHQUWxngj3exB2VTesGo+RKUQoM3E92gUsdK
         eL3EbpzMGSdUNIsrZskSH8pPnJ60RbMWMODMIaJimE20QYUFJ+ovdzrsmttcybtf6P
         dZ3e9pGbNq9TvIRhqSVmlLUZR94eQh3BuUwjEJ8pizqY8ndu0JQbFG/meQRtJRiiMg
         gekFRe0dFoXPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B896EC43142;
        Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yuzoz21D5Cb0yROm@google.com>
References: <Yuzoz21D5Cb0yROm@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yuzoz21D5Cb0yROm@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.20
X-PR-Tracked-Commit-Id: fe201f6fa4cf96749b0a6b6a61b33b6a82de4e49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75b9fcb530edc9731bd539353ec7ddb6c8366a25
Message-Id: <165980997874.27284.11551612085242517602.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 18:19:38 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Aug 2022 10:54:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75b9fcb530edc9731bd539353ec7ddb6c8366a25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
