Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2965E4A2FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351992AbiA2Ny6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 08:54:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38664 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351603AbiA2Nyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 08:54:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA59560DDF
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 13:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AFC5C340E8;
        Sat, 29 Jan 2022 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643464490;
        bh=txDhPLoRtaiqqFGWfzdVLSVMptV59oFvuQI9M00RGGs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DD9QPqsvyF+EMGn3/pAeGDKnyxbOFJot/E0CNhV1pnmeZrl119pBJy88680Cwbivw
         keHfnZRno7toS/egxEqeECzORIDplqaGBh+aWH0uaOgHKMOdsjssohEtTj4wX5cqLX
         Bt2aKkVzz620ysYRcwqJGdj6IiV17KXBMc4gEh8IGAe0x0PotLRj+2qozW3xGTq5uQ
         rvXHg5esRiAEW31uHSIZj+whPi7X+hFy0tS7XMiIpDEfpflHYSIDqk+15PMdfxIvHZ
         vZjBY7xr+9iQkSkf7RERFUapQvbmkYDhs2Wb1WVU/VGGWXLKiZOi5y2z+TLm7Eicdl
         ET+C367GzApzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AF72E5D07E;
        Sat, 29 Jan 2022 13:54:50 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YfU9LsK5kzsyBmRH@kroah.com>
References: <YfU9LsK5kzsyBmRH@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YfU9LsK5kzsyBmRH@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc2
X-PR-Tracked-Commit-Id: fc55e63e148f1db2180867da875460a00aac8bd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e255759e5afbc233544d7246ad325417320e90b6
Message-Id: <164346449023.28926.3850708576063394912.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 13:54:50 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jan 2022 14:12:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e255759e5afbc233544d7246ad325417320e90b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
