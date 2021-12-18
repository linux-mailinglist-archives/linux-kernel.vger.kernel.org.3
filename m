Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF62D479DF8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 23:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhLRWR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 17:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhLRWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 17:17:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B29C061574;
        Sat, 18 Dec 2021 14:17:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44F3AB80B6F;
        Sat, 18 Dec 2021 22:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED648C36AE0;
        Sat, 18 Dec 2021 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639865842;
        bh=cx6AVz/dioYncoz6YbuFi5nS0EG/fkwRdTgwW6xFgiI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TOgTtnfhAuGLJlrRadZtUeOSUqGhzg1LOnQqh0h/FEePwv+ts9vLIHsEIRSwf6EwT
         aN6hLa4tsydgoHoY1pdFexJpywyUwfsrA9u13P+RSQ8O7elhSOwiBZhZFZ/1CgZAJS
         lTD1tA0N7IjMxiWj74faz8kNTPtEFob8SbSivV0+7Gml8D/13dIf4sNZM4R7CkFl/G
         GaM2fMuQmYaTXgYRSRnJyOV08b4S/0X3RPeNzc/bc/MpSs5mfJ9GrtZjkQ7TMsx8Z9
         n77QjTloU84OeOTq9XaIaw1IPtlyDfbjnQQVWATWz9LAjInyN3ymftec/hmGQEX/Ga
         zvhXbgUEEOseg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D77C160A3A;
        Sat, 18 Dec 2021 22:17:21 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yb4TU/m3UYg7VRJj@kroah.com>
References: <Yb4TU/m3UYg7VRJj@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yb4TU/m3UYg7VRJj@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.16-rc6
X-PR-Tracked-Commit-Id: 6c33ff728812aa18792afffaf2c9873b898e7512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f667b5d4053ad54aee13dab5c94f04ff75ddfdf
Message-Id: <163986584187.8711.4193413214250300002.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Dec 2021 22:17:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Dec 2021 17:58:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f667b5d4053ad54aee13dab5c94f04ff75ddfdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
