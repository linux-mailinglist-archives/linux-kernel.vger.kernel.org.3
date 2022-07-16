Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E11577091
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiGPSGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGPSGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:06:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07618B05;
        Sat, 16 Jul 2022 11:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2937B80B98;
        Sat, 16 Jul 2022 18:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99511C34114;
        Sat, 16 Jul 2022 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657994772;
        bh=MW0ni3zhBevoxu7s6uA4QvzuwcXiC1tBzMsJecCdHBA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=esxwRxyketusb6ICx9Qh0EQ0tiw4ZSD2BIabT3A+V1bqV9giuNLnL0VemlwyM+8Ok
         tS/FX8mU913W1npeqBACG7kDAeJG6xveEMLAUWL/K4DkI2RdEQZlnIgJ3GWA5ReMFh
         z2erTdjupduZkHwzts1DVDiSSRBJmiRjgsUx+u2WjBkHAr43igZgKJRf0FwUXleirZ
         JthiT3V3cBQsAgpYUCT6PFhETqPivryhkTF7N3fW+/PBRiexCb6Uk7ZADIl/bSUPuJ
         zLcDDy0bzcx56mYwmulVBuLwJTsPUdm3APG4W4BIqYfe2CbGMD3f9kPQddGTNJ1Tjh
         CW5w5Qy3+uoRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86714E45227;
        Sat, 16 Jul 2022 18:06:12 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YtHff24djpjhFL66@tuxmaker.boeblingen.de.ibm.com>
References: <YtHff24djpjhFL66@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YtHff24djpjhFL66@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-6
X-PR-Tracked-Commit-Id: 2f23256c0ea20627c91ea2d468cda945f68c3395
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c658cabbfd32527060c2367f405bafb4e5815c6e
Message-Id: <165799477254.6229.14891942357540935080.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jul 2022 18:06:12 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 23:43:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c658cabbfd32527060c2367f405bafb4e5815c6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
