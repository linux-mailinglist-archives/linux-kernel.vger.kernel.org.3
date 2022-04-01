Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89F74EFC58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbiDAVre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353078AbiDAVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:47:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC910F6D2;
        Fri,  1 Apr 2022 14:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12C21B82680;
        Fri,  1 Apr 2022 21:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C03B1C340F3;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648849515;
        bh=8WxsSKYXfHI+ZwEAmEi6yiRFZWVkJ6ThU6B6MiPl+4k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F0T5wWfkRwuUuxjW491OHVSIArlFkLwtAVg4/lDNUeqW8Hlr5QC7JyYJpb0z4KkRs
         HDl3xRAcfrQ3weaP2BlkA/0R1JexQ8L/joqZJO1uzf8/NYUXzq9XCRrFwPh5ygIGUU
         xHz9aE14Kq0+t3/ylS2E1iWDAzQD3fJs6LMs0zH1DbQJO7oo6gdRfu0QpBK2buHl59
         tOfM0TP/kriKbgX2L7jDIShbYed0BYWarS9BF6jIzdehiKCZrIjGaDzjuEhS2i9c5g
         SyPDrpPBup9PFFq4DEt6SQrCbq0/5q0IwLZIoXJUQU18WlbrYC8pGt6KoIbztChpWQ
         WE5MPUWe8RWuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADA36EAC09C;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvE6YuhkO0AaPtmzA4V22T_T-bz7ttKbvgtqo0My68Kgg@mail.gmail.com>
References: <CAH2r5mvE6YuhkO0AaPtmzA4V22T_T-bz7ttKbvgtqo0My68Kgg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvE6YuhkO0AaPtmzA4V22T_T-bz7ttKbvgtqo0My68Kgg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/5.18-rc-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: edf5f0548fbb77e20b898460dc25281b0f4d974d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a3ecddc571cc3294e5d6bb5948ff2b0cfa12735
Message-Id: <164884951570.9554.13950030052291928613.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 21:45:15 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 13:40:40 -0500:

> git://git.samba.org/ksmbd.git tags/5.18-rc-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a3ecddc571cc3294e5d6bb5948ff2b0cfa12735

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
