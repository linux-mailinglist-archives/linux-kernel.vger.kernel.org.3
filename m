Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECF5A3A6C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 01:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiH0XHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 19:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiH0XHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:07:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA78329817;
        Sat, 27 Aug 2022 16:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7925A60EED;
        Sat, 27 Aug 2022 23:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0359C433C1;
        Sat, 27 Aug 2022 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661641643;
        bh=IpDcaqEHVsEA2KN1LKL+kTVXQ0usQeaKT7JA7qYRSM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ictxJ4sUoO4KGeNCFJEKT+C6ee+7UFkAQBdKdhcABJByn82/88H2U5YBKwViN4wHy
         q85VnJ+B8vlFx32H2VsurPj0wx1I9uelsL09zyjTOAFAjWTy2F9weRVZT246wnWrOe
         +T5aNtnTHX3HuCCBS6WmL4sEFknG4T6AJQ+uXB90YGzQqPEKu38QVFtRjlMhdBZHRk
         JUrVXNdOIjTW1EFoCcIkGXSlpN5g9nMmfHMfYpRCw0BJV8nBbdPJvZ0xmSsQQo38k3
         94BH2xSNQPYY4yg4DrR9DYcavUT+EGTZ2e9qKm+tENSNYoq83ZBT4RGUvzj5AChDTp
         Ax/lUCEu2/eSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3FDDE2A041;
        Sat, 27 Aug 2022 23:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jnkSjtMff7uEKTCHLENMJYDd26BEjjZ3XK7fZMxHtd=Q@mail.gmail.com>
References: <CAJZ5v0jnkSjtMff7uEKTCHLENMJYDd26BEjjZ3XK7fZMxHtd=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jnkSjtMff7uEKTCHLENMJYDd26BEjjZ3XK7fZMxHtd=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.0-rc3
X-PR-Tracked-Commit-Id: 2413a85200ee9cbed40d12c6e3b856752b089790
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b1ddb5950a65a6d5aa42ea381284d00fab7fb69
Message-Id: <166164164379.8591.2512414407568661455.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Aug 2022 23:07:23 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Aug 2022 15:39:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b1ddb5950a65a6d5aa42ea381284d00fab7fb69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
