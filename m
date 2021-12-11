Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BAE4714F2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhLKR2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhLKR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:28:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D61EC061751;
        Sat, 11 Dec 2021 09:28:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2921B80B2A;
        Sat, 11 Dec 2021 17:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54C52C004DD;
        Sat, 11 Dec 2021 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639243725;
        bh=Xb/MVo00Rci8kL0bZm2iOeR2z9WLQBlJLZMMt7IFc9A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FPFwpUhazUaat7SxDKNKg5fkkUkbpjhhRxMSOeMo3d6HUFQBmvgFvbD6lnOUTXM/J
         8Wluxhc96cWleANJjqyswzo+nm7VpXdmK2lzD62Rqp8v7gw31V3YpLlyFmO8/fuWTt
         hBivu48dB2g6+/pDJZQD8o+oNPRC1x47aTo0N/mT10+sVgMw44Rqcl7j1oJXqI8qLP
         HBk3SJuNANXWcj5v7cXwZRWUOdgmTmmNb/0rta4Me9k2nMiOnwf6leYyeZNF86mQLJ
         3I1KH9qyxmYuALxGKxWN92rKe9eU7WkT5s9UC4rdKOCJ09UASZzhDBNaRuYrOXLgqY
         /KB+0SdJdeWUw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2D79860A4D;
        Sat, 11 Dec 2021 17:28:45 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.16, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YbPZuCq+xIc6tqaZ@robh.at.kernel.org>
References: <YbPZuCq+xIc6tqaZ@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YbPZuCq+xIc6tqaZ@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.16-2
X-PR-Tracked-Commit-Id: 75e895343d5a2fcbdf4cb3d31ab7492bd65925f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a84e0b319908e297b04392879bd8ce7a8338c1ab
Message-Id: <163924372512.9148.1856726408089251917.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Dec 2021 17:28:45 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 16:50:32 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a84e0b319908e297b04392879bd8ce7a8338c1ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
