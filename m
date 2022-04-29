Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD15158FE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381807AbiD2XdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381792AbiD2Xc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450781663
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F5E0623C2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4FE6C385A4;
        Fri, 29 Apr 2022 23:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651274977;
        bh=00C53HimrHYPq+ZpEdfMbpGXvsJIr48Qg15VAcABdXw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cOEcEVIS1dSHi3eWXbCQ/0vs+jsZAC/RVW8gNl6UrefbLat03JIDv3bmkoqpzcMvG
         0Fgd1p4wCPQxBgi0zPOdYpsqc0MSfP+pEpA/6dx3/w5XrqHp301x9PtZyVYjIFF48q
         2/ZzinIqBmn8DVZID5JD+Z7ZNGc7LmI5B7tS6qgzn/j+UKYgwx2gCAYpBi2iNpgUMK
         x5aeheOXICSzK/rYVbHK3nwJEiZL/KNfBDtyaG2AP6ICeXyc+n1/bN5hRVu5pELViK
         bA3L4qOS9F6GXDrzM32RIhz6awdxiKToNjczm6PFf9YYmA5c2DwfHICvI4uTyDf3Ok
         MYar+w46iW4AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93380E8DBDA;
        Fri, 29 Apr 2022 23:29:37 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220429145935.2549453-1-Jason@zx2c4.com>
References: <20220429145935.2549453-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220429145935.2549453-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc5-for-linus
X-PR-Tracked-Commit-Id: 5a7e470e460fb90657343d843732325e53bb875f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdda8303f764d844e7b2fb69e5fd21c650c60943
Message-Id: <165127497759.20495.14560672243372796785.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Apr 2022 23:29:37 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Apr 2022 16:59:35 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc5-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdda8303f764d844e7b2fb69e5fd21c650c60943

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
