Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AB547B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiFLSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbiFLSkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399CC59969
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACC46101F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 18:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3402AC3411D;
        Sun, 12 Jun 2022 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655059253;
        bh=nvVXBwXbiRKHvs1i0mjQOrWUfmF5fk5lngWj2rmvq3Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V+MFN5jXEddGBj/armeZnbqqUyrlYLPjyjhBGbkAom9l1FpQ1H0tncAcP/M5VCWay
         vM5eJU+FQ570D3cQWlJFeSqIM/hcuS7rzP5+2YyZoxNHBSjjtu+Bjjymp8PBc47HnT
         vbJ/EJ/1BI8s7IpzYttm0pSSp8kTlVemqowQWGBT5UYY8vpkLsmj2mSO/0NN51vNfq
         I/HMLej9Lev+wFZ+D8E0XasiJKUxJuL8omUTaxo0wJZhZ0A6nA0bd32IhJ6xQLBXxc
         Xr7g3Ldhb0OVLU8J1FuZ1IQaZsZhVX+LuhKGampAOkAa6++ZfIEE5jxcc4sQuTVg+P
         g6cwMZ5tiSwxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D575E737F4;
        Sun, 12 Jun 2022 18:40:53 +0000 (UTC)
Subject: Re: [GIT PULL] wq fixes for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YqUzUBjG4N9pKlsv@slm.duckdns.org>
References: <YqUzUBjG4N9pKlsv@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YqUzUBjG4N9pKlsv@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git tags/wq-for-5.19-rc1-fixes
X-PR-Tracked-Commit-Id: 8bee9dd953b69c634d1c9a3241a8b357469ad4aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0cb8db39636f7d79caadf98a90e9367b4d9aabc
Message-Id: <165505925311.24195.14212175201811591915.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jun 2022 18:40:53 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Jun 2022 14:29:04 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git tags/wq-for-5.19-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0cb8db39636f7d79caadf98a90e9367b4d9aabc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
