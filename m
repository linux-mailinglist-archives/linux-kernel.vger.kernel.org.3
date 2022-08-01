Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBAA586F8C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiHAR1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiHAR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD412605
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55D86B815BA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90AE1C4314A;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374827;
        bh=NdxUGP5qIL7k+AnLtpyd0AFjIhVXCyE7jMaxFkCUw14=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RuOOOZg9iFprDaKz5RFoOSmn37Ff9mGA2sPXXcQ3ZreApLgJMGvcw/GxTgsPwJdD9
         QqzjQlKdWb9MUbRAeNQPnPj9T7j+k+flXQ/uO54gxYsU1WFsI3c39AgRehlCKygGmI
         xNZlYizfxIJFM8qiGUj96MWjjDzex65BEI0cccc6Qczv7rRpMAa04HcYHrE97s4sPd
         PN/x92WRO5YCHzh1UxdXUsn2TQRo5uaQXz7OwH9kAe4FRivqRtq2Ozl0G2+XBVqxi7
         j5jtsnNAy8Hbt6ZbX/KdRtMC/wN+hJNXnNXZCL/rSGNZCcspBWg9ichOxgtUHpOoh9
         KU3JIF3bYksdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E4FBC43140;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yue+CFzVZusSJeZc@zn.tnic>
References: <Yue+CFzVZusSJeZc@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yue+CFzVZusSJeZc@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v6.0_rc1
X-PR-Tracked-Commit-Id: 2d17bd24b0169d3fdbf003dfd55af600e9a30553
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b7054528cd5ac96383aa89315670d74865c8dc2
Message-Id: <165937482751.24126.7023682028744110529.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:27:07 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 13:50:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b7054528cd5ac96383aa89315670d74865c8dc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
