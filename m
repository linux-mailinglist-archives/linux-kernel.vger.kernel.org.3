Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5671F53DF14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 02:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351851AbiFFAXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 20:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351837AbiFFAXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 20:23:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A56389;
        Sun,  5 Jun 2022 17:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D064B80E16;
        Mon,  6 Jun 2022 00:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 627D8C3411C;
        Mon,  6 Jun 2022 00:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654474984;
        bh=F7JmaPT+TPdAAthcQrI5M/nMMgMa2A+xE2mclhXfsCY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JTEpta9OzdU+mCLSb92yge1m5KBLtOobIdjOs20v5NQg6Ppae5xauoHa/sTzJn43I
         +5dYIJd41Nd3xkevfi7XWWAuVSHxiJw0kbtWVDWETufn3ItCTxyrhyvX0BH1dTvGjV
         NsKYouxpJX3xM4rXCaGuUoswJ8ueu+T9HJ9fHllldm6wU+vFAyQ6I+lejpQwZ7B11+
         UbaDF/rzEo4uuDy+rE/FYM61PK5OQ4GfBkBfPxLPHbSUSuz9pflStuGWFArYztD7eH
         lBtJsbbj5irgdjVRKZl7VIbJCeI2pgSY0xac8LZCOIOxA4tRbtkB/aHiKrv50DIRWg
         iyb8cZIItpRVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C667F03875;
        Mon,  6 Jun 2022 00:23:04 +0000 (UTC)
Subject: Re: [GIT PULL] final non-MM work for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220605113800.83dfb5ac57ba1f0f64552d9f@linux-foundation.org>
References: <20220605113800.83dfb5ac57ba1f0f64552d9f@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220605113800.83dfb5ac57ba1f0f64552d9f@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-06-05
X-PR-Tracked-Commit-Id: 662ce1dc9caf493c309200edbe38d186f1ea20d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e17fee8976c3d2ccf9add6d6c8912a37b025d840
Message-Id: <165447498430.29908.10648017095522967533.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jun 2022 00:23:04 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Jun 2022 11:38:00 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e17fee8976c3d2ccf9add6d6c8912a37b025d840

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
