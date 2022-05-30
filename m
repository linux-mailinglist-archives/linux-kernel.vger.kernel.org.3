Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB5538781
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiE3Sqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbiE3Sq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:46:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80686831E;
        Mon, 30 May 2022 11:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57A63CE1234;
        Mon, 30 May 2022 18:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7F90C385B8;
        Mon, 30 May 2022 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653936384;
        bh=Yy/LG5SCOwxB3xv75IkLE+VwspEa3f5qJtZxHEYfJ3k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bj9EZSnKiT8CMNe6t6Lx2M1fBhcNa5DTs/kGTPQjX/pAvgOTAh6mLxe4P0ejxxNbV
         xRRp40tov/lIWhVzZOTxvGZsA+Sot+0wnSZaqD45KmYyHU3V8T8o/X0ex5Teg4tIIe
         Khfc8xNyvZ3CsryHKAGkblHqDiw90rqC9D5uCKUz8te31Gu7KYFfPP+3XS5wKqntev
         1mZAb8h7VTRZD8cC5xY5wUyjTXLX5C28mpe/pm11AdlZyDIzfenSK6GvvVm4OeNePO
         XnRc6Ie0imZJYQpW+4zkHiNPhL5QtIgs7hYmLNS7LO8CafDp4OnqPdTKnU2Dn9XIjF
         rRcwJQYKDS6vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ECFBF0383D;
        Mon, 30 May 2022 18:46:24 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gJ-06Zt_p9SS+wCZW60Z9TmvUF8zgL3g=iw3y_VGM71Q@mail.gmail.com>
References: <CAJZ5v0gJ-06Zt_p9SS+wCZW60Z9TmvUF8zgL3g=iw3y_VGM71Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gJ-06Zt_p9SS+wCZW60Z9TmvUF8zgL3g=iw3y_VGM71Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc1-2
X-PR-Tracked-Commit-Id: 4a577fca503a63442928ff4cec06c1136ea9b53e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 527953ef7125078cd43ccfbed042d60199842b31
Message-Id: <165393638464.11978.13710954464798807829.pr-tracker-bot@kernel.org>
Date:   Mon, 30 May 2022 18:46:24 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

The pull request you sent on Mon, 30 May 2022 18:49:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/527953ef7125078cd43ccfbed042d60199842b31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
