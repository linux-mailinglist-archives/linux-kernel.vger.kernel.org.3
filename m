Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF8479DF9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhLRWRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 17:17:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40892 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhLRWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 17:17:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 453EEB80BAB;
        Sat, 18 Dec 2021 22:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2D15C36AE5;
        Sat, 18 Dec 2021 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639865841;
        bh=Yz6UHlE6Z1WCChd+kfI/R47Avm+OtMS0vmlV7ZF/RCg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L0keUe7vAXMB7GphNza2BBO+Z5foQcbAAgpD8Suo1e8GCAtKC8ca73qPiIFjKTZfj
         sfSCOYp6sv2F6XRXIa9E7buOmvIHPV4XGCkKpHqpl1bsWKJPd8fJmHPfeWFji1qiCc
         oy45BfOcYjGSbMKVmdzyLcF3gK3jtlMkfMIAwFdLS0HN+WWDjy2pTFL9jsKHTc1ST0
         6kIDkvhOCfTqXV5GFModuEphg4g+knfnShlFAp8POl/eNPak+Ve2dCQXu9UymSbkTi
         N1mH52z+UoFlKrN4LclvESE1bCfwtaTYT4A/jwCnqQr63ze7BEhcl6PrIIRH3wEO7E
         wcisRc0Q9e2WA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BFAAF60A49;
        Sat, 18 Dec 2021 22:17:21 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yb4TNA/HoeI8NbTx@kroah.com>
References: <Yb4TNA/HoeI8NbTx@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yb4TNA/HoeI8NbTx@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc6
X-PR-Tracked-Commit-Id: c4d936efa46d8ea183df16c0f3fa4423327da51d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb7d0829135a1db9abe9b8a10e42f47d5301861a
Message-Id: <163986584177.8711.14582778516978630418.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Dec 2021 22:17:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Dec 2021 17:58:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb7d0829135a1db9abe9b8a10e42f47d5301861a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
