Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2D495E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380282AbiAULwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:52:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51220 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380242AbiAULwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:52:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8944361A8B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 11:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDA8CC340E4;
        Fri, 21 Jan 2022 11:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642765940;
        bh=y5QyjWNiXNED/hFq9hJKu7KfpEqSd+2YGONLyDq4jtM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RCkf3itkfbEhXmR4WqR+89ZuoqGOsD/Y4SfyeVVVI6DDNbEN5lPk0vGswLV9wk7S0
         Yg+BlhBmnVh1++Md5IVsKSW/KY/j7NAz3NW1oxu4RKRRghRylp8Zku+PEpa3F+VRgK
         Mm0BS4OM87zaaMaeDSDFj8p0S8poel+/A+iCuw+b97crlMHTdqkoKk+6DLdBxJtso8
         ppYCOWlwtHYd3ncv03CLe44DZhJBEBSjPYSPNBU+wxJwWtmDSqfknKD9UYoCNp+zvY
         doRWEQqeOPPvskCdyYs5aDXu+Y7CyG153R7MW58L4QJE8oKX141IQINANoKgLwlTsV
         3WYdqHA3jFK+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDE6FF60795;
        Fri, 21 Jan 2022 11:52:19 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h5yqdv571.wl-tiwai@suse.de>
References: <s5h5yqdv571.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h5yqdv571.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.17-rc1
X-PR-Tracked-Commit-Id: 2a1355f0bf41a2132d522ed7a2a7eb1cc4fe3d8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f40caa080474d0420e0b0e6c896e455acb6e236
Message-Id: <164276593990.2956.18223576577256751356.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 11:52:19 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 09:55:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f40caa080474d0420e0b0e6c896e455acb6e236

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
