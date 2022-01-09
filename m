Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9980488C0A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiAIT0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:26:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34016 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbiAIT0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:26:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 075B4B80DFF;
        Sun,  9 Jan 2022 19:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCCCDC36AE5;
        Sun,  9 Jan 2022 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641756360;
        bh=3Tc2GQCYcxRPUFCvdU/KLm9LNWZJT64QyuR3DSdax10=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=asKyt4Vxsgp3Cymxv6baBGbElkQLsS5eiafTWz+Bc5ihdjbx7hboUulI2F4r4m9qL
         fSEkbO1MTzj58HTRHdUEGGFa0Y0ZSSFRKK+X+d0Si7G9IcTQ67jTnUwZu7Mo1yzF2k
         FiQd3rhvTKfy7/gGMA3SevAY7oFfgcbuamIXDV3Xdj9atOunCRIsTfXeuzHM0+m6TU
         672zTZXBvkohqlCMqCqwGFtY4nUOfooTRkqjKP9HRNMRVVm2g4i3GYKjHSFk2UNwno
         N2cg4oAOItJkR/PCDBpCGQPuc3b6Wl0R7dAzKYnzWqUvUV8QE2zuchrkSz8BsJxHWA
         25i7vc3cbGFtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC63CF79401;
        Sun,  9 Jan 2022 19:26:00 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.16-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdqO0p960x1KT/bo@google.com>
References: <YdqO0p960x1KT/bo@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdqO0p960x1KT/bo@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: cf73ed894ee939d6706d65e0cd186e4a64e3af6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e900deb2482002a9c10b77c750f63fba928fe142
Message-Id: <164175636076.32020.13280879408061263549.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jan 2022 19:26:00 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Jan 2022 23:29:22 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e900deb2482002a9c10b77c750f63fba928fe142

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
