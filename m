Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DC95A2FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbiHZTJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiHZTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3903ADD4F6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6D0A61EC7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39CFFC433D7;
        Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661540965;
        bh=6QjjBEtO3m3aDTS+sboZqzDbXJWLUW4OKiYkV03Tt2w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e/TCZz2hY37f9KpO6CZd8D2gO7C30i8hmmHWet8r4ZdMDdiuuKQkJpm0//RBFp3YW
         xczMnDKevvpu2UQIzFdi+vSVxOd/J6N4BzUctogkvKfTrs2fRcjWwUXI9sa1mNYUf5
         8nAzbhSbyP5v3mCJrLiAA1G0beT3Cl0cRDSzrFbadd8qUre34/WLUJVId4eOLQZV/L
         YsQ26wqA2t71efrOLIBzdAE47EGi8WtYWE1JNP5ELHYHGQnFduBcF4AgT307IBeBNE
         F7uMa9xKoHYjy4/9fiUIegu0zVxrOTU6KSrfO/KvvrsAEilSypLWLL3nW2Pdn4qi02
         cxv+5pKDqfPmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21AD9E2A040;
        Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzv9SAUpqMNh=4EuE3kCOYrsO9bW1vH8NiB+0rbOZv3LA@mail.gmail.com>
References: <CAPM=9tzv9SAUpqMNh=4EuE3kCOYrsO9bW1vH8NiB+0rbOZv3LA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzv9SAUpqMNh=4EuE3kCOYrsO9bW1vH8NiB+0rbOZv3LA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-08-26-1
X-PR-Tracked-Commit-Id: 100d0ae82b5c240a4dc17486698e67bf116bd598
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78effb4a9b8c3589519b84759ac1757647072448
Message-Id: <166154096513.10698.8394863129118772315.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Aug 2022 19:09:25 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Aug 2022 14:30:12 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-08-26-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78effb4a9b8c3589519b84759ac1757647072448

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
