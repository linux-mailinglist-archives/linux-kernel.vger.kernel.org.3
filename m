Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4164A2F8B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbiA2Mvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:51:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59432 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349719AbiA2Mvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:51:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4E70B827B2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88673C340E8;
        Sat, 29 Jan 2022 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643460708;
        bh=jMZ9hXs6k3RbvSCC1+xZbzvsy6gCOmXhfn23ODqbWnA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CzF4rdcCkekU0jM4y2RMcEKA6gSv8B3CWXjF+7KjXhu3O7M3mV+jl95kmOl6Fo2y6
         P9S2MhcsMvLsdFXA67aC7eHfiFal13J2hrarNEuSSYSVR/FU7lksbgl88VphtG6Eff
         gUElJYBPNl9kChrI+Jfh5S5hYqnnzxVIZEOMhPR6/Zo339vu5oQsv8ALnfMhp+vVPD
         yuHVhwvg+VqQqUGm7Zgr4+WsYyDN340CTXO9HwFpJtr0DyhGj7ZvJLToGN/Te5s5kw
         PctjdzDxnlBf5SBePDNeOxoyvZkFwzpnQ9HRe6aCbUo2mWQizwrGAyg91ymVvfxLz9
         5L9CXNDI2lzxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 746E9E5D084;
        Sat, 29 Jan 2022 12:51:48 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871r0qbtsz.fsf@mpe.ellerman.id.au>
References: <871r0qbtsz.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871r0qbtsz.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-3
X-PR-Tracked-Commit-Id: 8defc2a5dd8f4c0cb19ecbaca8d3e89ab98524da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d66c1e79b9fcbfc6559ea3c5b1243d590fa04179
Message-Id: <164346070847.2828.16702382736239191449.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 12:51:48 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jan 2022 23:38:52 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d66c1e79b9fcbfc6559ea3c5b1243d590fa04179

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
