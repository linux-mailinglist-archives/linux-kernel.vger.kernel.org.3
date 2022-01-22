Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D65C496AE9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiAVIGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiAVIGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:06:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ECDC06173B;
        Sat, 22 Jan 2022 00:06:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B08AE6119C;
        Sat, 22 Jan 2022 08:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 201D5C340E9;
        Sat, 22 Jan 2022 08:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642838801;
        bh=PZF6sCjjGVJ/A/xG+NQnhuOlB6l61nOmt3YKJuu6+u4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uuCTRy95wMWsFqj2O/vvN/g4E9tjU+alZlO3QEzZkR1bjTnOEGdb1kjnKSMzeRoTk
         A5XL03AwGMeZbdPLkOr4lzuF89isJvnBMX8o7Q/rAw+BxNHVPHVlpz5Qxv8jdirinD
         zwOe3BpdHv1B+azrIoFRmeOezxUEm9Qfcu8klSKh08de6dtDIBjptsDpTTlcOvR5ME
         egNzLDeFZJVdSx8baWUTuonGrzRGUpNFLezOdpwR2CIgOKoUS8scR3qE+Tb4Ac6ivX
         mH5gc6D+bLCm7RV1dB/ce85nSYEFgHkoZl3UXy5q4uzkX+8mKBZsAONdauPcodzsCk
         /qTQJUNogYK+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C5E4F60796;
        Sat, 22 Jan 2022 08:06:41 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes & updates v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YeszRlKu5dWqiHDQ@ls3530>
References: <YeszRlKu5dWqiHDQ@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YeszRlKu5dWqiHDQ@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-2
X-PR-Tracked-Commit-Id: d24846a4246b6e61ecbd036880a4adf61681d241
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc5341f41dc81bd497828e562da135bcff9c876c
Message-Id: <164283880104.17909.5130893167658400839.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 08:06:41 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 23:27:18 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc5341f41dc81bd497828e562da135bcff9c876c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
