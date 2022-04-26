Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C8510CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356243AbiDZXxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356221AbiDZXxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEDF14F5D8;
        Tue, 26 Apr 2022 16:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDBF761A1D;
        Tue, 26 Apr 2022 23:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E22C385A0;
        Tue, 26 Apr 2022 23:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651016996;
        bh=jCMr9qQdxM5ht216QhHktzKeAsjJkbro/KEfLqtpE30=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ilCpsG5QJkuhsDM0cEdsp5dIsikfil6AKtcO8BbCWE40w8T9sm8GcQYLeMBo24+b1
         HZOW/qZMmFDEcBqVoYGF25T73a+nbjFaAl6ukCK/3sFulNLJyqhRZjMHqwAPbhPbBK
         oUpfw0Tqppo5Wfo9zkp7cYJhxvZTv9IsBZUDhTDfYHIv8mZlT/+5rs4XOIRkSEUVns
         wU4j4z9sa7BA8LHPnLm3Yf2HHJ6xOL+sIxjvIXAa9hsaPbtY7s04Qq7Hc/ykKh7474
         ZNxWvZsWc7AcVkkbnGOjPo63Gh6eYSaBfS1lBpehST8cHjmAZ08HcF9RqQQ9c1Y5iG
         lOMwJ993VYL/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33E8DF67CA0;
        Tue, 26 Apr 2022 23:49:56 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkda+GO6iZEZVTY1dWheVCz=1FaGs7NNYHhBn8Ssht3-rhg@mail.gmail.com>
References: <CACRpkda+GO6iZEZVTY1dWheVCz=1FaGs7NNYHhBn8Ssht3-rhg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkda+GO6iZEZVTY1dWheVCz=1FaGs7NNYHhBn8Ssht3-rhg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.18-2
X-PR-Tracked-Commit-Id: 0c9843a74a85224a89daa81fa66891dae2f930e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46cf2c613f4b10eb12f749207b0fd2c1bfae3088
Message-Id: <165101699620.23873.12884553594430840943.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Apr 2022 23:49:56 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Apr 2022 00:24:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46cf2c613f4b10eb12f749207b0fd2c1bfae3088

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
