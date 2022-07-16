Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408CA577095
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiGPSGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiGPSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:06:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDB718B25;
        Sat, 16 Jul 2022 11:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0023B8090C;
        Sat, 16 Jul 2022 18:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67595C341C6;
        Sat, 16 Jul 2022 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657994775;
        bh=4wN3caMpsCVo6qzk/qaznsXpbywaRyG9+vDPRUCJYS4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SXqLOLJng6euB7wZEDx7Ti20/gi3GvM00dwO4H12Fi+KhG5MfkcJNPIZtkThQ9n5P
         fzhB734CCriGPWCngvRFvvGzMwV0O2Jj29y1CwCnAvveVnzhbakXzOB2+DmC8+7GDn
         Gga2cwqqqzQl+9K5XCepEzeYjm7s+tK8XOev8g+ie+GaRit/bLDeyG2IuZjcZBwASp
         pPO4JQ+OB2Vn55frMt1PKf1PmIJMnRpx0xMFmKQ15w4MF8xdve1QRY1zvDuAJV3W5D
         DWlwIf6mT4Ov1xwWJ6TrYW/2Sp2I/jwwcv8oIkfydYpnICduc6+74bBDwpG/feDO1I
         2CEMPly+lqqlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48DA8E45227;
        Sat, 16 Jul 2022 18:06:15 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iVmVvMK3iv0gcTeWQzbfCWrNhRw+j+-YSPtbQcNMH52g@mail.gmail.com>
References: <CAJZ5v0iVmVvMK3iv0gcTeWQzbfCWrNhRw+j+-YSPtbQcNMH52g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iVmVvMK3iv0gcTeWQzbfCWrNhRw+j+-YSPtbQcNMH52g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc7
X-PR-Tracked-Commit-Id: 5a5adb1528e59e8a4b23ffa7dda4849b61e97cf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab6efe68a736748cf922a7641751583a3c783cb1
Message-Id: <165799477529.6229.8790280749383521748.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jul 2022 18:06:15 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 20:40:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab6efe68a736748cf922a7641751583a3c783cb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
