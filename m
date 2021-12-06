Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3160D46A5B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348544AbhLFTfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348568AbhLFTfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:35:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413EC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:32:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4F059CE17C2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 19:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BEFCC341C7;
        Mon,  6 Dec 2021 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638819135;
        bh=LjN3J+9xEa1m/NSzLW66jUdeEZ/zgbIudHgJugpOZfU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YafEJsS935spDvRMWUT4Hpzu4JEHNRV3eSNeBasBOKHinIimAcWnH6nSAjZmc3PKZ
         4wg7MYLI+NmjW+XARUT9qwUArvxMSWJwOSRKYzgRMXYrpFqt6AtjOSMZPfgIWW7skA
         41MEAIVkLtqSUAFK/MdAj5JuoOylxGVbZND8SrqHElj7zBkk5HVkN0YT5MoQBPybyX
         dPmHIre46zu1+MfPrVZB349gj00f2NcXcgdBekRKPJlZdzPpLWqH4B3ULN68Qo0j9F
         xdpGby+e80docjmg7Cq8JFFdeW6i2RpUXmt7Ww26XJTw1ibwHmkBTwfmL/TGwUr2YZ
         tz2tDZ8HOlgmw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 39EB5604EB;
        Mon,  6 Dec 2021 19:32:15 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211206160627.76A1CC341C1@smtp.kernel.org>
References: <20211206160627.76A1CC341C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211206160627.76A1CC341C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.16-rc4
X-PR-Tracked-Commit-Id: 6966df483d7b5b218aeb0e13e7e334a8fc3c1744
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b806bec53881f493c550107b8455afc7b7900009
Message-Id: <163881913523.10155.3866557502647632887.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Dec 2021 19:32:15 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 06 Dec 2021 16:06:11 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b806bec53881f493c550107b8455afc7b7900009

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
