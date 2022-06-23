Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C68558943
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiFWTkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiFWTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D6F7C50F;
        Thu, 23 Jun 2022 12:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39E2361926;
        Thu, 23 Jun 2022 19:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61428C341C7;
        Thu, 23 Jun 2022 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012608;
        bh=xCzxLAAd5okCAkMLLIDv31aoLm/OloZfzM6X0KnoL1M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t+UiqIJ/iS4menk/fFQ79VjJeMol+axJYwSkaxh4q+YLQpQHMsy4e5lTzL1RQy9xm
         E/2xRrD/r6rXJGYbw782QtF+Q6hqhej8iRV5I+dGvmWHffT1qbOt3FzYLre4IQHneg
         PhjADYdM3W6GspyjkWsAZXVZRFHMlA1ysiIcvRg8s+nlqFyK3MsdRus+mgI5E0QYBi
         +obUob8x7N3jonqGpFHkbf5dAU67gQVoDxGq/B1iHs18RqDUMZQn+Iq49YxdysMOgf
         eIQHzVUYE63wE+qhoCLbbaAhPvM33IvTo1dPrj6dYRFEQG3eoKM7NFhPs4IvLh+BIv
         SYe0O7hY3rUQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34BA6E73856;
        Thu, 23 Jun 2022 19:30:08 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hHCBE5PpqayYi8kKF-+-juJwbQZtzoQ0mNDo_4iGQ6Lw@mail.gmail.com>
References: <CAJZ5v0hHCBE5PpqayYi8kKF-+-juJwbQZtzoQ0mNDo_4iGQ6Lw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hHCBE5PpqayYi8kKF-+-juJwbQZtzoQ0mNDo_4iGQ6Lw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc4
X-PR-Tracked-Commit-Id: 202773260023b56e868d09d13d3a417028f1ff5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92f20ff72066d8d7e2ffb655c2236259ac9d1c5d
Message-Id: <165601260820.24693.18107144156032367099.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jun 2022 19:30:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

The pull request you sent on Thu, 23 Jun 2022 20:58:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92f20ff72066d8d7e2ffb655c2236259ac9d1c5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
