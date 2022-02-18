Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0544BBE93
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiBRRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:40:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiBRRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9654E8BF13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:40:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4837EB826B4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE829C36AE2;
        Fri, 18 Feb 2022 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645206000;
        bh=Wjh+LnyUjYczQ9WxLEEgArrzQu+XMc21+6Ua5ti7AHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hfA3iTWb1FWduOTX007jkf1ND7POcN99fHuQ3UJxJ5h0U/gguCW5zmNyTmT8YmlkE
         IpzbFSz0xbTrMQiZUBsdaPKacWlje3/dFDSIRuxV1D09BmZZG7nXFbkkkGjsIAPLao
         a6643OLjBXwclhBigc4fG1M6WwWmY5Fnzn7J4RNML8o3Um3o+8JXGvLcdo2OkIrCiX
         7j1fzIwAxDtwSDOYWrsB4UDamVA7c4RUS4h6MSF+ypgjJs3K9v/ACS4n+e+99xH6yd
         o2uI2h29HWM2KIFjZnfPIPeXnJKv+XmYjPT+CQb2HopoazWICPAkLzw9ad2KJdfduQ
         v90sWSU0835YQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAEE4E7BB07;
        Fri, 18 Feb 2022 17:39:59 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yg+SHbDujjurwIqb@arm.com>
References: <Yg+SHbDujjurwIqb@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yg+SHbDujjurwIqb@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 4f6de676d94ee8ddfc2e7e7cd935fc7cb2feff3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45a98a71d2daa8c58a99c17343a5d118b085a9be
Message-Id: <164520599989.19024.16265989040203299710.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Feb 2022 17:39:59 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Feb 2022 12:33:33 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45a98a71d2daa8c58a99c17343a5d118b085a9be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
