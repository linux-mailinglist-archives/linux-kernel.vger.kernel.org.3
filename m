Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671F0488C07
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiAIT0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:26:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54422 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiAITZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:25:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F117460FAA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 19:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61FF9C36AE5;
        Sun,  9 Jan 2022 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641756357;
        bh=MfRJBjoCGkquPhZbi0CsS96szeVClXTb8YROv3HRTVU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e4igV/q8TdTM/SdktEwtpT3Hr/SMtJCPXUBTz62QZBewuS1d5ENQugAj5X1Z9EB2J
         dfFk+ylA/O22H+mPL4PAtNhBZdPr4nDz4hGjjLh6i7yFrFQFS5g5E/Q1IPc5c/vGxK
         WXe/pB6HubsG/YtyJK/40BGJqEz9svXhDWM9VMuUGuGtEgmLjHgdHQHG20cClxqG5B
         xObawikktMQWGWuJCJZ1b7pAjoKkiwBYDKRhfhOMGrhc5+y+N0JDAWvlLXyQoBUu16
         kxqyaxELUO8y2o26GDCx4sMHakbIuDqsCowo7nydLXr8jgSrYLbmVNcbee4FsHdw/o
         kzeIjZ675HT/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51799F79408;
        Sun,  9 Jan 2022 19:25:57 +0000 (UTC)
Subject: Re: [GIT PULL] SoC: One more fix for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdqN9GxRTQYVA/f4@lx2k>
References: <YdqN9GxRTQYVA/f4@lx2k>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <YdqN9GxRTQYVA/f4@lx2k>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-5.16-5
X-PR-Tracked-Commit-Id: c8013355ead68dce152cf426686f8a5f80d88b40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95350123bb5568a7d95e3789225144bd1a154274
Message-Id: <164175635732.32020.17846257667340116617.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jan 2022 19:25:57 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, soc@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Jan 2022 23:25:40 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-5.16-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95350123bb5568a7d95e3789225144bd1a154274

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
