Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E157C53DD83
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351578AbiFESEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351515AbiFESDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:03:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AADE4B42A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 11:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 001ACB80DE1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC3F6C341CE;
        Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654452196;
        bh=i0bipNcQq4YvTA/dAYbznY3OdPGWWVmvq8X5HdlQURY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O9wDf9SUAmHMGKsANT3MuVniV2YKe1Q4rIBGPKwOJdGuGFEsH6Fa4kkGX6ZcSgxQU
         FAH5pXjLprHG3ltlpyrWtaf5Poc8Lh6mEpWHi1lttKAIPmYosGVYbeCJcO3lOwqt+J
         v3PYp1thuqy3feJnfDsjCGjN45KOGk9sDZhzKAoXhMVIDH2dJA++s/AzDlMjoXqGFd
         1nZEGiL+5jDk4qIEa2mqiabpLu7+eDkZ9klK/7lq+TuIYJpep5ZNaLK+nejCWZsdaw
         21kmFnJSvhNsBvKkPos8VRwo+chZUqTGhfpb5VkfEtrs9r11bHsqs4LGj3eCrbuZou
         v/vFlpNSw2eQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 981F9F03950;
        Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
Subject: Re: [GIT pull] x86/mm for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442138128.152751.14866011543351593668.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13> <165442138128.152751.14866011543351593668.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442138128.152751.14866011543351593668.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2022-06-05
X-PR-Tracked-Commit-Id: e19d11267f0e6c8aff2d15d2dfed12365b4c9184
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b7da15c21c2d4a37495fafc0350acec18f67d87
Message-Id: <165445219661.28605.7937126531079403245.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 18:03:16 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  5 Jun 2022 11:31:03 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b7da15c21c2d4a37495fafc0350acec18f67d87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
