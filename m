Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0CF48B8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiAKUxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiAKUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D0C034005
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56544616B7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8376C36AF4;
        Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934388;
        bh=V4pQesl5bauHDJp3/CfA119BG8L9xj4L3P8Y411HKrY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u3y7S9z0E3U2GM82/Vjvct9uftsyOauQJn3bJ62xWQJhWptqv6jUFYEtl6e1baoZ4
         UfJ5bAwOpz54Fb6+kfFUDrCxmLgO42gLRI14ewNtqrdks7/ccqDa7rllW0wHigwatu
         MwVzjCLmsIx/eJ3CeAdl8UWhiiydv2DPcDBwL4plrwQQ6u1KCgKXyedmLawmgwpxJF
         d0KutbhoZfTN0BDy5luf2e8a6NbuXMcS8NQ49flxdn/H23bKtrDKWPkk86mH96NedT
         tcbjORNBc1n6Cc2qNtKaoZgTLPaeA7MtwPXqBr5a/k178FKriMxnaBuPnYWFStdrHr
         qRi34AhkUHBlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7DC3F6078A;
        Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.17-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <aea4c26b-25a1-9480-f780-7eb3502a4ce4@redhat.com>
References: <aea4c26b-25a1-9480-f780-7eb3502a4ce4@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aea4c26b-25a1-9480-f780-7eb3502a4ce4@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-1
X-PR-Tracked-Commit-Id: 3367d1bd738c01b2737eaab7d922bfe5f1a41f38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 347708875a2fac81dd99ec826248ec29ac28f441
Message-Id: <164193438868.11435.13707252263306397849.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:08 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 11:31:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/347708875a2fac81dd99ec826248ec29ac28f441

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
