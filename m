Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FFE53222D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 06:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiEXE2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 00:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiEXE2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 00:28:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892138A300
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FFB1B817AA
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D64F0C34113;
        Tue, 24 May 2022 04:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653366442;
        bh=iiHnmmp9BQ/6aXWJv5Z+Ql+iOKwJRmjL/glcVGW/EKQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pkgwXrA03hov7hPC8Td8X3xFSqeIiuR2nI8pcPGxH2qmwqFtSLW8MKaO1O8kyWUeo
         l/mp2RJ0XSZ831EB04bVgKGuoR25gsBr90KoId1vyqQBFG5fmGtTAMEdzz3cWIEv1c
         z1Dw4qL0XCyuekl4XOR+0SBiCCLVCFxFBhJcNIR2r91BFr57QDHYkYcHLI09Y0W8XB
         GUd14VBhro4Ajw/XRKsUyeYCVszrcHfyUnBi2t+QujsKbkld4y0UYqqh0chdLKd38g
         NrkPzWB2L2YdTycmdUN2b+hJVIaPXOWKHb1/7rZl1IZ/nBjp9fGoMaTKsWO0wkYSLs
         mrX46v/iMLVJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C355BE8DD61;
        Tue, 24 May 2022 04:27:22 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
References: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-1
X-PR-Tracked-Commit-Id: badb81a58b9e66ca8c15405476f5134e45b57dee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8443516da676be839b54ee11350baa2605f0a445
Message-Id: <165336644279.29742.15520762585604364142.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 04:27:22 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 May 2022 22:00:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8443516da676be839b54ee11350baa2605f0a445

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
