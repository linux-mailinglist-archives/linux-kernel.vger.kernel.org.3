Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0426C5158FB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381802AbiD2XdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381789AbiD2Xc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4551CD335;
        Fri, 29 Apr 2022 16:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7097A623E0;
        Fri, 29 Apr 2022 23:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE2EBC385AC;
        Fri, 29 Apr 2022 23:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651274977;
        bh=SOxvHWF/MTb7rLbkQ3GAVki1VB4HwbPvKhMHS+vEjFE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tzUYzbv4w3Ll7bQp5Vqp5y+Ck9U9qhFeR3w9xzeOxPDXwZBw1Cgdw2MmkqPj2JmiY
         1FEQ9SAjwC20TpYjMSHp2YS0Ot3h7rCav5qKfWS94HfjCytp7jDWTrMmdPc11jS1t8
         GIQkgQ4epgx4TLWiFMdTMSUFDygoe615XWJh2Y2XyP1V/Wq3DJVctRFGpYrCe94pZo
         nsYZnvoRqOT4SUc/rKmqxc1kdvUVQMIlX9CVOlY5wxtpwm1WURW5S4NYq+H7l32SVP
         4eUBFdtcekwphRfQRN/lSZYRugSsT7Tg9qcrBxo1Y9Nl83GktKusGhqK8dw9cSDWPO
         1pUnxmsKwM3vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAE91F67CA0;
        Fri, 29 Apr 2022 23:29:37 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220429204451.2794649-1-sboyd@kernel.org>
References: <20220429204451.2794649-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220429204451.2794649-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: a91b05f6b928e8fab750fc953d7df0aa6dc43547
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0e6265e6c2dd3f1bc37d929194c97079f7ffd3f
Message-Id: <165127497776.20495.3183521395094456296.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Apr 2022 23:29:37 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Apr 2022 13:44:51 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0e6265e6c2dd3f1bc37d929194c97079f7ffd3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
