Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BF248ECA8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242828AbiANPQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242450AbiANPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:16:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C526DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:16:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 885CFB82443
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A428C36AEA;
        Fri, 14 Jan 2022 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642173407;
        bh=ApOKhYgMVJhaYpVK9HkiTO24jidYxI5fQAarH/oMkuw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WPljvhj8g2xNYhKak9nTHpfIUWB5LYZtGTNZBy66KABD8TN6eIpTzUuPw56vg6rHs
         DFLplYZvU2GeUynhYwJp2fpNy61PeUwYTCs2RthiQtwAElEoskreGSiWSJehHn4Vda
         ua6mqM52jnLZYstHEIaDeX7+xHoka85q3d06ob8DYJmSuNyTw0/2NjcwdQFTKnr6S/
         gXTBeUkseKGFXVCD5zkhN0Ts/utSQlI/XA+LrtZj1KVclw3USwJpQ895G+agq4ajKw
         BaPaghJ/sD++4UJ1YWNopBn06ksdLe9qyOsASwk9IMJaS/s6FzUjvzpsQSq8giDqqW
         /qygS+WtiQG9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 199FBF60794;
        Fri, 14 Jan 2022 15:16:47 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YeGNdoyDESoradQ+@kroah.com>
References: <YeGNdoyDESoradQ+@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YeGNdoyDESoradQ+@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc1
X-PR-Tracked-Commit-Id: d47c7407b4c88cf66098eba8893bc38279f301fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bad80dab94a16c9b7991105e3bffd5fe5957e9a
Message-Id: <164217340709.29661.6010507314943756985.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jan 2022 15:16:47 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 15:49:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bad80dab94a16c9b7991105e3bffd5fe5957e9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
