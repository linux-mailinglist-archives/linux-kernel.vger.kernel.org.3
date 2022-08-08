Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8951F58D038
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbiHHWha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244825AbiHHWhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:37:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62B2B0;
        Mon,  8 Aug 2022 15:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30112B810D5;
        Mon,  8 Aug 2022 22:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF0A2C433B5;
        Mon,  8 Aug 2022 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659998229;
        bh=ypU1ekBmO9eH94NIO5RXka2TukuhlZJ5JqQI3eSLXXY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DmDBUBui4e0iNAS6aek5XLgs4iehzFE/8HzCzHYuN1xUxvVlULhm9NbxQUr906kXD
         pMo1xa0cL+9BhFqB02QwpxGFLJP6Qp6H7OgKvUhsAEOWBuaV8JhTuq2da2p5lNEbGt
         4X3JGMRSesCqIEMhQtwTPx1nC/8XZJCA99lf8mmnZ8LqbwT9MFblhOXCSANc5Zd5sp
         dyQgBZWEO5LKVObP1PQe5E04JhftrWAA3lfIu6NC96j6NhSB+aZ7l9Mh9hHLFuuS5F
         2m0krhX3y8vCI+w7C8JiTq1GM2zypHw0e88myY2xiw/ZDvtl9rvXy/6FGgxWSJc7Ey
         BFnSeS66f1wZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC2D9C43140;
        Mon,  8 Aug 2022 22:37:08 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i8zu7SUgf2Bp3TZnxzHS_Oa9oQVKSN2rezDAisYdrWZQ@mail.gmail.com>
References: <CAJZ5v0i8zu7SUgf2Bp3TZnxzHS_Oa9oQVKSN2rezDAisYdrWZQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i8zu7SUgf2Bp3TZnxzHS_Oa9oQVKSN2rezDAisYdrWZQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.20-rc1-2
X-PR-Tracked-Commit-Id: c3f834df191ac2e5e58c215b9110e7e19553100f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 507f811f205c17fd6f64e8d34d4bf91cd01b07a2
Message-Id: <165999822889.1400.13948234317372627937.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 22:37:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

The pull request you sent on Mon, 8 Aug 2022 20:13:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.20-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/507f811f205c17fd6f64e8d34d4bf91cd01b07a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
