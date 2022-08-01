Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC68586FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiHARve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiHARvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:51:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A813DD2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BF64B81603
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FD8DC433C1;
        Mon,  1 Aug 2022 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659376276;
        bh=Tvn0t7qwl3tw2AoLSiwAcq6yzHSPiv3Bi1lJMu+ZcWQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sXIH1uIBdQNXwGgDCK0kRRv2FYHkFMr96rwBjpgMHkcTXi0493FIg1yjrvdrRzHgB
         Nvbap+lYKqmppM+4B4RGkgEpxQdVV77StzErpwU6Q74kGsOxPy3yoSP9b7nGD5+KEt
         8QiFqTOQOb8o4bzzeda2q8pLb7LfKxs2fE9Jb3r4UPOT7ysAOXd8FdQ9MSY0hbzmXO
         9cQihy6ZF5uDnafyG0dCcd8T99mHNNT/Wu+98rM1c3+zIhEWN7k1I7cxqh0UzVC7/u
         mJZjKmP24ZQKWjGcwZ1E0tDOlpPdWabZTEl0V966EYyNC7AsrqB+vjeZyggmczikyr
         IH9PblfYqKekw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D559C43142;
        Mon,  1 Aug 2022 17:51:16 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220801123821.2028594-1-geert@linux-m68k.org>
References: <20220801123821.2028594-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220801123821.2028594-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.20-tag1
X-PR-Tracked-Commit-Id: b508128bb0d1e243beb56cca5d819bcbb5c269b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a82c58cf1a5560988d8b9b8abcd982e90a5fdaa4
Message-Id: <165937627610.8149.12880111163955388117.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:51:16 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Aug 2022 14:38:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.20-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a82c58cf1a5560988d8b9b8abcd982e90a5fdaa4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
