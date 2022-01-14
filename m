Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9F348EBCA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbiANOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbiANOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:39:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69AFC06161C;
        Fri, 14 Jan 2022 06:39:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6687A61E77;
        Fri, 14 Jan 2022 14:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE0D4C36AEA;
        Fri, 14 Jan 2022 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642171140;
        bh=HWavl3cxxAnrrvk9d1dWlzPzYiQFUvvBV2f9MwAYy4Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XEzQIXr6+htyw4/GyqvsXa82IsKyFuQSXBbR6ZUHqG+Dz4eHAGWMFNhTMvprAsGqZ
         HHh1aRIQ8VCWBA+bYYzxTLzf8rp6Ce5qj4piz2wo183kpU5eI/1QZNJHzKPT7jl2W+
         4IazEVXo+a9iZhDTj3ElotOuHUopLJe5NHvy2jcqd9ZmmcJ4Ritxj/gj73E9JvIXUa
         XcUMzRoLu5+OBfqibb6cGjrfyzvxApDoskVLIsWe/IH0A/5ND0WDgaFxcTk/lPzfHn
         wmNFKuaA+hj7u+8ctQiVPXc/CkhC633kBIU8zqFOgxvFUgStk+KxHO6VBkYOs49NAR
         okM2sykkJFgeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD3DAF60794;
        Fri, 14 Jan 2022 14:39:00 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220114083938.GA4892@alpha.franken.de>
References: <20220114083938.GA4892@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220114083938.GA4892@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.17
X-PR-Tracked-Commit-Id: d3115128bdafb62628ab41861a4f06f6d02ac320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fb561b1e0bf4c75bc5f4d799845b08fa5ab3853
Message-Id: <164217114076.3976.15559922916388051600.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jan 2022 14:39:00 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 09:39:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fb561b1e0bf4c75bc5f4d799845b08fa5ab3853

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
