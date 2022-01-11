Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2735F48A6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348134AbiAKEzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:55:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43668 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348118AbiAKEy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:54:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1C83B818B1;
        Tue, 11 Jan 2022 04:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FF07C36AF9;
        Tue, 11 Jan 2022 04:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641876897;
        bh=/T4YwNzkFbeekttAWXQFs09Gfr+kHLzNYLt30BVqcSQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T6QhskWzeoQgXEyzr7WlulgkOwiXjEeYCTmE9MMZoYC05nAJeIAs0ipp2Cjyp8L7N
         8nnp0ARVw9I9v9zDC+VN7BGbTSgHzMLgHoaPk24mVSH0nINV+O4OMv9U4DfI5xz5WN
         8Ott3WTVX1Jd7KUll24HONiy+PwYYMXm3Vdsr5aiEHMrQLjgGE0AnG8FzdCluPir/N
         K8V4aDV0ABkDne5Af9I34h+mK6u52mK4anrx1irCvlzakPwfeS9CJZHyg2qqGpsv5f
         czY9Zlqg7cPGQAjNSKbqitN2Tw4NsqtzwWzLWCZFZTwH9lX1sc5RD/rn/zf6EsZiRC
         7GbbPVYLZ0Q9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F3FFF60794;
        Tue, 11 Jan 2022 04:54:57 +0000 (UTC)
Subject: Re: [GIT PULL] Device properties framework updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h20TNyM9MW2UCPg4u=3hBRxZH+f91GSxxP0V0m0Nf1ow@mail.gmail.com>
References: <CAJZ5v0h20TNyM9MW2UCPg4u=3hBRxZH+f91GSxxP0V0m0Nf1ow@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h20TNyM9MW2UCPg4u=3hBRxZH+f91GSxxP0V0m0Nf1ow@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.17-rc1
X-PR-Tracked-Commit-Id: 3a571fc19673bc00c36b2cd8a2b9811c013115d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe8152b38d3a994c4c6fdbc0cd6551d569a5715a
Message-Id: <164187689732.26750.12241617195557654169.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 04:54:57 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 20:23:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe8152b38d3a994c4c6fdbc0cd6551d569a5715a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
