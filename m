Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144AC58AF06
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241621AbiHERmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241603AbiHERmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD476FA0B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F154618CF
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 17:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE9CFC433D6;
        Fri,  5 Aug 2022 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659721356;
        bh=2vJJdbGT9i2Wt+NDhMC2o2bTMNN00zXWhsuDhSO5jO8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tJTrtpMWwSqCuriBZ0BP9q/vUnkiaYa9dzp9HAYFSsgDEwN8vY5qJIo1Q0q3Vs/8+
         4GL9Nim1C07CVnNoAhvcw1N+USRq4ICWgemNmni5IcXvq+5V/GSbbK1MzDkgKV2KoI
         dCr+9dvrVexL0AfjklklTyzCixDd+AGlLHIuE2AATEktGpnyU25wy45b4WevpxzDQR
         OKUJ3eOgk25eUzxQRlVc9sx4xFJ7qNzNaQl9Jxsry59bYqpwW2xgxFiAEJ2RSvGTr/
         s5CYhyHs83TKI4o1aanfPEDkBarAAOIzv4yejIZftGqe7I7WbLUxZqslKR7g4ZC1i9
         CzMvt2GTrnkoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFA5EC43142;
        Fri,  5 Aug 2022 17:42:35 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.20-rc1/6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <56ae15f0-4172-a1bf-661f-1e4310ba60a1@monstr.eu>
References: <56ae15f0-4172-a1bf-661f-1e4310ba60a1@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <56ae15f0-4172-a1bf-661f-1e4310ba60a1@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.20
X-PR-Tracked-Commit-Id: 5b7d1d575e3f1917cd493761781314be7bc73ef4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98586bd6dce3690d8ae8d8561383d9ecc715e3c2
Message-Id: <165972135591.14838.17056115436346227999.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 17:42:35 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

The pull request you sent on Fri, 5 Aug 2022 10:49:20 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98586bd6dce3690d8ae8d8561383d9ecc715e3c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
