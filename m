Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD27470E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344876AbhLJWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:50:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43632 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbhLJWu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:50:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADF7BB828A7;
        Fri, 10 Dec 2021 22:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77820C00446;
        Fri, 10 Dec 2021 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639176408;
        bh=LhhefW+ZCz0AZ/8zzzDlgKAGtHLyCoLSdloSxdBmSfA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yw+3JncZI4tqRF3s0Nk+wpBymGGp2S7KeNCNt3ifvQiBLzHs8uZQKnxOaKst1D0o8
         vuFQLxi9NS7ZvL+ZzXAde7ACrMSzXBRWDEdAbJldNOnVpxAGQiAO9lG+lrMugjmhr/
         KtILbhfsZV+cOKOOf4hb+h/dScDPtq222YkZHI5segQyZwX5N4rUDZRSuaVYkZA7J8
         BKyL4BxTTFXdaZGbu6P8YFAxWY9tf3lHvc5F1ctb9CQIqC+0zQXi3TLj7SYvpdEDiQ
         hMXG7qzYJ+Cmom69eVZ/D7RA69da748xjbWB0i9eg1v1KqnTXYrqxx4uyhHRRYkrAB
         ri9zgHZ6aGmSQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 63D6560A39;
        Fri, 10 Dec 2021 22:46:48 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iTCeLF1gzf+W-ugvTex4PYiNeQOE-EO654oeuzqj1TOQ@mail.gmail.com>
References: <CAJZ5v0iTCeLF1gzf+W-ugvTex4PYiNeQOE-EO654oeuzqj1TOQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iTCeLF1gzf+W-ugvTex4PYiNeQOE-EO654oeuzqj1TOQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc5
X-PR-Tracked-Commit-Id: 11f8cb8903ba4e8ba900fa4e4ab29d0fb4c9ef5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e65da135b39cabd82dc2f56b0db526b65a8d690
Message-Id: <163917640840.4787.15579932037260372215.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 22:46:48 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 20:52:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e65da135b39cabd82dc2f56b0db526b65a8d690

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
