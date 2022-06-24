Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3720D55A202
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiFXThS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiFXThO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:37:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC63E81DA1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63A31B82C0C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 19:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2739BC341C8;
        Fri, 24 Jun 2022 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656099431;
        bh=5ACM3bmKFglYuCnEdvbo4N4wC9DXmhVYmVrneXs9zUo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ejgg1Dfb0BA6H/g3XHXNaw1NYfPVuJGJxCWWXn4vSLNegNjaze12aPlk2w1sCRLyf
         VkAgPi45tspTMz9NV8S8fx5A9WIzjxaWQr9w53ydTdhTBz7bdnT3FLl5UJFjk2DtSG
         cRnyubIyxEdVEEYS0EwU2nRXjwXTdbFBJ+nU0wNHU0rIs1DJ48FHkV0xAzQwRFJZyc
         gZls1tcWZepKRqH9wWzNcwo9KgyH54ONEDnMIflXY2wjm+Zdl5CGT+rtHbKfR+J2sd
         3WweGu46f88wH0C1UIfRUn6qBzOGcAJO088D+uUsq6OonCnV8UPCRRepFrU8wRWo5a
         wrfcyG9NdRhtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10C7DE574DA;
        Fri, 24 Jun 2022 19:37:11 +0000 (UTC)
Subject: Re: [GIT PULL] A Single RISC-V Fix for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-3e339ca6-0ed6-4d02-96b8-2f664f62cc8c@palmer-mbp2014>
References: <mhng-3e339ca6-0ed6-4d02-96b8-2f664f62cc8c@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-3e339ca6-0ed6-4d02-96b8-2f664f62cc8c@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc4
X-PR-Tracked-Commit-Id: e83031564137cf37e07c2d10ad468046ff48a0cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70d605cbeecb408dd884b1f0cd3963eeeaac144c
Message-Id: <165609943106.3020.10530019402105354343.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 19:37:11 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 09:08:12 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70d605cbeecb408dd884b1f0cd3963eeeaac144c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
