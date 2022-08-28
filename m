Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F225A3FE0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 23:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiH1Vsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 17:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiH1Vs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 17:48:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82F248C6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBE69B80C76
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97625C433C1;
        Sun, 28 Aug 2022 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661723306;
        bh=NJIMnKKAlTfH4V8rDLGKctYaYuRzZ5zReBcV2hTTtlw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FyiKq6bTlJ4UyRYtx2uOCh/RlbKTldYJX5f6GdzmwdkRNgMj+nn8o9b5g/dZUk1Tz
         Oi6kL4gdF91kadPCBuVvMOBPhW0mvGPvfTivFkjz10uPqdVAhMZBCEBB+BCzzmWQoi
         q/zCWwfy8tDDM2dJ6sgyag2H+dc31HBLHhq/LnNeO7F0ztKkyyTLLmBcheTVDEAjUs
         t2a7MqaenyPoxM14J18Pzwr4DD2Wa/XtH3K4sE7MXm5YVDPNgtvr06K5aBKAXTWliZ
         0AOxOS0e6xn8OxQiTLWmUIYdoDbGLqo3dugcRi+P0ukPgr/szMHNyDDt5N9Ge++mF8
         yRT0H1d60f9Qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FB7DC4166E;
        Sun, 28 Aug 2022 21:48:26 +0000 (UTC)
Subject: Re: [GIT PULL] bitmap fixes for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220827184150.4022255-1-yury.norov@gmail.com>
References: <20220827184150.4022255-1-yury.norov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220827184150.4022255-1-yury.norov@gmail.com>
X-PR-Tracked-Remote: git@github.com:/norov/linux.git tags/bitmap-6.0-rc3
X-PR-Tracked-Commit-Id: 5d7fef0804b0a72a7efe196cd23b438edf84726c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 373eff576e580b6bbc1e709cd3ca0d100783431f
Message-Id: <166172330651.28223.6693696574068937786.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Aug 2022 21:48:26 +0000
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Aug 2022 11:41:50 -0700:

> git@github.com:/norov/linux.git tags/bitmap-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/373eff576e580b6bbc1e709cd3ca0d100783431f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
