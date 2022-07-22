Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FF057E7EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiGVUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiGVUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B188CEA3;
        Fri, 22 Jul 2022 13:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B57A61F5E;
        Fri, 22 Jul 2022 20:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C831C341CF;
        Fri, 22 Jul 2022 20:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520470;
        bh=zXjsmvBAsiSw9hapsUw62g4sy4pazcAUd5siAJriP0o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fQnH/50gj3clIQTRW2GLKqSA0X/QFtVf6fbFv0eArH0V7tvbHVlqd75U+78OnZN3x
         mzogVLkdkCAjp+leAfqX29qJZufQ7rJcr2E5yRHHM6CvxFTisjQeynpPuiAzHq2Gxa
         OY8V2R+E9ReMj1DP03dQJPy8bRviYvlxUKRWn1BhzxxLWk5BAanJZsQD0qjNHAwF+Z
         7Z4W420k33EERdPnc0w6g3vGxchoHR171jcLAyJ8q8xyDSCLFIRyjBsZEuC/Or8473
         YbUYFILio9meLKdVOuciOE7mjbCAbh9ZiBqEeS634MsWXlUCRW8sw0jgJHvmMJdUSA
         Wjs3Ajjmq3t+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50EB6D9DDDD;
        Fri, 22 Jul 2022 20:07:50 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0guJm8F0myVa2DG3mxkStPQ-+vzuY6Gob2hk3Jk=guWCQ@mail.gmail.com>
References: <CAJZ5v0guJm8F0myVa2DG3mxkStPQ-+vzuY6Gob2hk3Jk=guWCQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0guJm8F0myVa2DG3mxkStPQ-+vzuY6Gob2hk3Jk=guWCQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc8
X-PR-Tracked-Commit-Id: 09073396ea62d0a10b03f5661dcabfd8eca3f098
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae21fbac18b980ecfd895ff32833a2543c157ee2
Message-Id: <165852047032.15752.12993410208862785353.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jul 2022 20:07:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jul 2022 20:17:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae21fbac18b980ecfd895ff32833a2543c157ee2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
