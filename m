Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE148BBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347348AbiALANt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347067AbiALANm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE29C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 16:13:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCEC561601
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 226CDC36AE3;
        Wed, 12 Jan 2022 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946421;
        bh=mYFAr0fdiwChTVqjFuOpPztelIHQR5xDLGgL3UOsfRw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kXUSvKGM9LDqJ20N+oRPOZh8UY1BWZMx1aq4RvIvKNiRuRCB1f8iMMumIVjwHrU1o
         ct4hEdTfo17xwK7P68EJiHoMRR3xiKTgZRWwqvmpIDIADR7OxyMjbk8Ifrc+0zdRbf
         35cMw9cPo1/TJZuoWuMj7P9SD6U9wnKMPANMKLpz/4GiRBV+ChT2ggZgZcUCR7H20H
         cmhbbFQGf2jn0/vWzMufYBZeopDHpTM4ksFlC8dV74SR30mO2SnZ/kk2u0qPS9xL+v
         RWeHWrt4XEV5DJIz7/6B5SaMhk5CYVQl327SHte6m+++VHMk2CSgo+cMJh0E5+TTs/
         79YC6jINhy+NQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 087CEF60794;
        Wed, 12 Jan 2022 00:13:41 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110023303.GA26979@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20220110023303.GA26979@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20220110023303.GA26979@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc1
X-PR-Tracked-Commit-Id: 09c543798c3cde19aae575a0f76d5fc7c130ff18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9149fe8ba7ff798ea1c6b1fa05eeb59f95f9a94a
Message-Id: <164194642102.21161.13755763655607396721.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:41 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Yue Hu <huyue2@yulong.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:33:09 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9149fe8ba7ff798ea1c6b1fa05eeb59f95f9a94a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
