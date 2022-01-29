Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AD74A2FED
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 14:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351770AbiA2Nyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351563AbiA2Nyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 08:54:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3E7C061714;
        Sat, 29 Jan 2022 05:54:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCC94B8120C;
        Sat, 29 Jan 2022 13:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F899C340E5;
        Sat, 29 Jan 2022 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643464487;
        bh=8ktiDI5OIvg4Vo9rNyl8HLM4UCiquwXeRRr7v0knxTU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ShVgVX5btZkeMAhA77TXFTa6oIxpTk64uKZCWKWljfBYcI+2hrArvqnNL+2RVmw0u
         LUAcKfAylavevwS2Si+2YNtH0tWrA22JFBonjx/M7nrD2U624csQ4xP44QwmTKeQw8
         4M9Xd4qRaRwBIhnjiGgA0G+IGwMljXudIfG7TYv+5K4zYRyPuUY+w5u+jXvWdA9TJP
         tnbTmGuLz5CZq/GE2CCkGsFLnvN1wukSWK3XQajhY+4CxCKy5ckDyNMPpDpn9/Ng2T
         rjrPA/PhM9EDOqdKqoAKhdccKqfI6EjvvIgeBHWgz7QA5XkDJ/3ODPbvjNyuKWqa7Z
         ILbIe1V1ohrVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F576E5D07E;
        Sat, 29 Jan 2022 13:54:47 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YfU9F+OwlK+Rso3T@kroah.com>
References: <YfU9F+OwlK+Rso3T@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YfU9F+OwlK+Rso3T@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc2
X-PR-Tracked-Commit-Id: d1ad2721b1eb05d54e81393a7ebc332d4a35c68f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb37101b36332345a1e1c1f9f2f3bcc8ad7edb65
Message-Id: <164346448758.28926.807775726529878733.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 13:54:47 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jan 2022 14:11:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb37101b36332345a1e1c1f9f2f3bcc8ad7edb65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
