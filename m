Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FD7496B79
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiAVJkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:40:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52084 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiAVJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:40:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE834B81799;
        Sat, 22 Jan 2022 09:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 879CDC340E7;
        Sat, 22 Jan 2022 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642844405;
        bh=k8ODayuUr1Cw0A91A+Bb0/Dgy1PdbXlVBloFqK9cL8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YqnxYxYzMXMW/q+f6Dq/a8B1Jzp5emvByDDvI9nlpiw0yDhKapUYbT5PinsgjnmfR
         FWygNBGIhEfIwwwxRrZk/G8x6CtbCGVjByynN/FA56t5P6qnFBNrJJtMkgxjkhO/AK
         RHngpBaxqY+gWQ9+QhQEoAw3c65mGTWpp70ZKsftDT4BU8DTGah9x6EAT2pklDGv9g
         KXsLzjwFtibnm7O2BLB4TdHQhYP3fC0kmn6Ey10YoO/XkMqRr3gPY3M7Onpa3g/bvQ
         lNVQ2yvXDaY1gG8SQvLLDmh4kBtyoASRUJgCgNoE3ZDnjjsXR7J/YK+lkLHsaPtJ0i
         DjCmrSysMYhtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 731F8F60796;
        Sat, 22 Jan 2022 09:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] Extra ACPI updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gJkT+WwEe0=73HKek+B1Ko0XFtkFYbwxb3NBzjR-1=ng@mail.gmail.com>
References: <CAJZ5v0gJkT+WwEe0=73HKek+B1Ko0XFtkFYbwxb3NBzjR-1=ng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gJkT+WwEe0=73HKek+B1Ko0XFtkFYbwxb3NBzjR-1=ng@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc1-3
X-PR-Tracked-Commit-Id: f6f02040e0ca7cb2e82d8aeb8f7daf5d89acc04c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71f1b916d5ea4a6d781b29e2470f5870a561e82e
Message-Id: <164284440546.7666.16131154238711645866.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 09:40:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 20:25:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71f1b916d5ea4a6d781b29e2470f5870a561e82e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
