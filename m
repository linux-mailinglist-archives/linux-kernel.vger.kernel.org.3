Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F70467F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383152AbhLCVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353804AbhLCVGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:06:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD888C061353;
        Fri,  3 Dec 2021 13:02:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AC51B82920;
        Fri,  3 Dec 2021 21:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B909C53FCD;
        Fri,  3 Dec 2021 21:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638565377;
        bh=Xxa/0htUZ9FzGXw3GBJuWWZEBU8YtN2dCtEnE2xsWsA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JhZ3K8p2+3/AgjSIUtWG/NY40Bo04Y/Z+Kew+MMbbHXLKqrw80LHA3t/oB9Ei1r26
         WhOAGQ9zRQp+81lKdbLfe2E0TXErDFoQtVc1jm3kye72HOT6JRIuj/aNXd63+RwEjZ
         gASSo8h+LYgQNQfYu1UgRtbkHaB0naIRcWIB9e6X6TGhuKod7RxrXL5ajoku9wjkmQ
         3sKtDNvsxKy9F5+1H6LQQD48z+1U/k8ngbNgdVhhMcFX63VTS9aOK8Z+wMolzQCJdu
         0ihZRhIoMdSxVE3o6bsXez1csvQrZHLnLNTFfvwW53QSSys0jL8Emta/Ehzjus/Lo/
         k/faBMPDrCa+Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 19B5A60A7E;
        Fri,  3 Dec 2021 21:02:57 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jkFod+DDdMFft31aHT1BXtip631LGznrryna9cBf5HHA@mail.gmail.com>
References: <CAJZ5v0jkFod+DDdMFft31aHT1BXtip631LGznrryna9cBf5HHA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jkFod+DDdMFft31aHT1BXtip631LGznrryna9cBf5HHA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc4
X-PR-Tracked-Commit-Id: 404c91218703d58c8f442aa01e4ae558f14c0e20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ec6afd628665aa2cffeddf0c9ca6ab6b984fc03
Message-Id: <163856537704.7508.100873367261853497.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Dec 2021 21:02:57 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Dec 2021 20:53:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ec6afd628665aa2cffeddf0c9ca6ab6b984fc03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
