Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3655D5883A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiHBVaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbiHBVaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B15645F;
        Tue,  2 Aug 2022 14:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 793FBB82081;
        Tue,  2 Aug 2022 21:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22456C433C1;
        Tue,  2 Aug 2022 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659475813;
        bh=7viaJidFi4TFDYYvZR6/mFtFeKT5SpgVtHKehGXjElM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mNDlPMrPF6/KJbM88BMTDP8+4ToLeWMWt2wS/Pd1bufqBrWprkDG3e0cy8+c3Vk3u
         rYifrW5MLXx5h4tWM9QvMdkNf0nU0KH0tY5pSjD0wuIXuOkOte3OdhbHpzsV5ShYMO
         yiPKA5HIMxnWwQ9ryaXkGND2HqqRLXObyND2uO2/ksPW2H4e9WE5yrsEzJL9MiVUZe
         4OCrT8fp7dv2hKm00Z/lxR1QKfCYCxnCTX9cXrTs3vfjQ1UBuBwdcSYV5cs58XMh6B
         5I4CkAXYmWMXfHGpYHtmyOC7mMsYygHsTfQs5DTrep7yfNyKZ612oyM1L5xQ9teRs2
         mjtRK66KiZ7QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0711FC43142;
        Tue,  2 Aug 2022 21:30:13 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat update to 2022.07.28
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdK=yehzeVG42K=W_chyJ2YPRh18m729S1trWk=yKVDzRQw@mail.gmail.com>
References: <CAJvTdK=yehzeVG42K=W_chyJ2YPRh18m729S1trWk=yKVDzRQw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdK=yehzeVG42K=W_chyJ2YPRh18m729S1trWk=yKVDzRQw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
X-PR-Tracked-Commit-Id: 3afe697b74bc6c59f0b9a9c89d5b163db56fd4b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efb2883060afc79638bb1eb19e2c30e7f6c5a178
Message-Id: <165947581298.30731.13114736548216294858.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 21:30:12 +0000
To:     Len Brown <lenb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Jul 2022 14:51:36 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efb2883060afc79638bb1eb19e2c30e7f6c5a178

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
