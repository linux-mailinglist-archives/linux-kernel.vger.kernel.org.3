Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07A0533401
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242927AbiEXXme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbiEXXmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:42:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7581F57B35;
        Tue, 24 May 2022 16:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FDF7B81C07;
        Tue, 24 May 2022 23:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE66FC34117;
        Tue, 24 May 2022 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653435734;
        bh=2xLVxDBN96RpkS5KPp4X/Q7fEY/yzOzqwveZEuMO1uI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dNfqX/v+/4MgIt/7NROt4lAT9JHF7UM0l+IJU0ehRcLY+PHNtnJ5/95wHYgYYTfg+
         edrPeZlCmwHf/VB40PvZByQPEodofL43wPwoYI2KuOdFDyW+4MH6CttMthP6msJJzP
         MqSzWcqAgGzK1YgcqxzOJzHKg10IQknm7QVgZln5zUGBQ0QNB8/a1+0CMnJ5hNwjcx
         lDICNqmyIKU3gYUGiTfxDkdnfXPyA+iIgXmbRGIH4GNH8X6RdRPIUU5Cz4eQrsGAac
         +feFej80CSy95N6ADc0FI2aLXD2xTFtCQ6qOIEQGbAuQMYpvhNxxYfcW95LCvdxaxq
         769XNtH3nu5cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3D3EF03938;
        Tue, 24 May 2022 23:42:14 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iMu3BP9bo_pjHmCB=+Y_7yir3pvLvoALR98=6NoE7ZYw@mail.gmail.com>
References: <CAJZ5v0iMu3BP9bo_pjHmCB=+Y_7yir3pvLvoALR98=6NoE7ZYw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iMu3BP9bo_pjHmCB=+Y_7yir3pvLvoALR98=6NoE7ZYw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc1
X-PR-Tracked-Commit-Id: 5db9ce20951c8163ee3d505b81d458c83155e311
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1961b06c9126e5b2b949fab806c4e4304d1eae8b
Message-Id: <165343573472.8820.5229179370018405921.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 23:42:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 21:05:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1961b06c9126e5b2b949fab806c4e4304d1eae8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
