Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89946865F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355505AbhLDQ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355427AbhLDQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:59:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADFC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 08:56:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54573B80D22
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 16:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F2ABC341C0;
        Sat,  4 Dec 2021 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638636960;
        bh=XUXJDYe1dXkLDeOiXer13SyIhtJMMv7rsnsVH88o6RM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n0v5LyHV8RdybJV9nKsR4kcYjlOLhSen6r1qEW7QKXQgtnbBnjyQMPrixb8cSytJB
         eZWdhICsqUtIPK+naFgCaAZ5Ud7R35jGNSpcCaLgajIilyzDvzAU26auqHgCVzLEbA
         Y3Ysl1UdK/7teglCg1zj/MZ7wWHGmVQYpk7qvJpTewy2DDtgWemw2Cbk/tXEWU/FnM
         nL+CsqvXA1pdfc1oauVxfL4WTLeRdb6Lev4FxMkj0P8YCJnlWmT7FDliXE+s6ItuM4
         dKzyVJLjfZWv/yzwVmvxce21fHQtKejfrDMlxHqIV/ajXzkBfg42VrxtjdyHVr8rDv
         U2SPklPErlCWQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DAE5460A90;
        Sat,  4 Dec 2021 16:55:59 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes for v5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211204102446.19275-1-agruenba@redhat.com>
References: <20211204102446.19275-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211204102446.19275-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc4-fixes
X-PR-Tracked-Commit-Id: 3d36e57ff768dbb919c06ffedec4bfe4587c6254
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c623c368933f22fcf77e040a0ad83f90c4e39ac
Message-Id: <163863695983.3540.14780222002136064380.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Dec 2021 16:55:59 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  4 Dec 2021 11:24:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c623c368933f22fcf77e040a0ad83f90c4e39ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
