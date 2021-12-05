Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC34468C76
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhLERnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:43:39 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55290 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbhLERnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:43:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BC34CE125A;
        Sun,  5 Dec 2021 17:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83A50C341C5;
        Sun,  5 Dec 2021 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638726006;
        bh=E8rsJPA4ubhwO/dBE/hsySoujk4nvixp1pWiuD1UUc0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=liIyhmmZT4/hKiJqvUJ7QI2qqP4cw3bBqDOfD9GlocDvEx9sdTZjaU/hF+NxU2Fvq
         Oi6wDuM1pQ3uAjkNq5WNtaaBzzR8JYXJFAxgcLzAIZZY34WKTTz7ZAvKlbtti96FFP
         kVCXNeHn3TERqTtv1+6QTY/n2I2mhtgKMFuuXGX2tJJD5xapEgeBR3fhcRJxvko51D
         PpP5Nvu1iEoFp8d6lhtzfR2WUsXYu8toKASv+j/UlmwO4awhT8AoRCKQvlrHuDJLDv
         WyGhChdyMV0InhRupKnpme95uZMgbyXaWCobcxCC3WeNB3uxUlq//KceOSn65d2++n
         Y88sDbNzKtFvg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7264B604EB;
        Sun,  5 Dec 2021 17:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yayq/Xdb/pHSS7/l@kroah.com>
References: <Yayq/Xdb/pHSS7/l@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yayq/Xdb/pHSS7/l@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc4
X-PR-Tracked-Commit-Id: 37307f7020ab38dde0892a578249bf63d00bca64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 944207047ca4dabe8e288f653e7ec6da05e70230
Message-Id: <163872600645.987.7156724710444619664.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Dec 2021 17:40:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Dec 2021 13:05:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/944207047ca4dabe8e288f653e7ec6da05e70230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
