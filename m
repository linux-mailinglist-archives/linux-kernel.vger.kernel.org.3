Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1382F4E8A33
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 23:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbiC0V0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiC0V0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:26:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CDAE006;
        Sun, 27 Mar 2022 14:25:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99EE9B80D17;
        Sun, 27 Mar 2022 21:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68700C340ED;
        Sun, 27 Mar 2022 21:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648416303;
        bh=tnsKWkJhSpinbmoqCjsfA1kkYCgz24BvWKYLD0y2TYE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y7IGGOlHJYU+aM05a2OsgAF+r1jF/P/yzP2wjo2Uzhskn3csR1j1Rlt/b5nUSgp0r
         5azWc4GkNJGnkdczcLoAxMDYQLoIeCmtKukLDR7w5TlzvJ0DUg5q5V2ZXd4ct52due
         WpV+1RozXHklctWiae/2I0I61zcDbeggmca1tgWmBXqs1XQdYbni7BfltPCMnxCxgT
         V+8EJFkh/69IoCIju9WCg+3pNSYSbxKf1Ax6zQ7EDIfBW5bmcFBeRChRDr7jjR3nAt
         Y7X/Ut3SIk4pR5gWXW+0xya1PQ+aUOMTNb4Ki55+M9XROzAsL3sjWaAd/FX+2c+Y1w
         xqNshaGRW1bNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56E95E6D3DD;
        Sun, 27 Mar 2022 21:25:03 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs changes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220326235108.GA4456@duo.ucw.cz>
References: <20220326235108.GA4456@duo.ucw.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220326235108.GA4456@duo.ucw.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-5.18-rc1
X-PR-Tracked-Commit-Id: e26557a0aa68acfb705b51947b7c756401a1ab71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfb0a0b715fdda25a5a1f54cb9c73e1410a868e8
Message-Id: <164841630335.27961.6657124159573949216.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Mar 2022 21:25:03 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Mar 2022 00:51:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfb0a0b715fdda25a5a1f54cb9c73e1410a868e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
