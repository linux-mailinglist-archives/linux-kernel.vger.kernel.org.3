Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1058550C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiG2SgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiG2Sfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204A6390C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07CE7B8280F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8616C4314D;
        Fri, 29 Jul 2022 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659119749;
        bh=PBywkvRHSHO2pg1dKB/BhIOZwbF89bg99eb+VUdRijg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B2d3SIf1VjAeHwk0Un/CWR9qwdstkJcTcRKF0fvlz0d5bDBnL2hawvTg0RxNvD3gr
         /x0klsPA6j2MWwBh8TcvXBb6WKDE9mcEA90zZOW2P0SKkAPWRyheLzm9PMs0pUu+Vt
         jaDpOmEBzb/6RTsmJK1pXSluuLCVbh3pVIVe9IZ6kn1zBAgqIj5ytGWpGDY2NL1Zp2
         gsokN7wK+BkpCvR+xbfgpWoWGW6epXyHhwvSpNCck47WYuVIfvZdsT0sUEiZ7p8iya
         Lk7tMMEsVXKALYc6j3VytcBTONJWXI3G8Sk2MdTgUYeOiZNh4FvxprASn7yJRi2KCm
         mpwDxhgbLjqxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7289C43140;
        Fri, 29 Jul 2022 18:35:49 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue fixes for 5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuQgDORbY8eFIJU1@slm.duckdns.org>
References: <YuQgDORbY8eFIJU1@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuQgDORbY8eFIJU1@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-5.19-rc8-fixes
X-PR-Tracked-Commit-Id: 46a4d679ef88285ea17c3e1e4fed330be2044f21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b20426d044163df0ff9d868e9767ca9e65dd36c
Message-Id: <165911974968.994.3092303676170385756.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jul 2022 18:35:49 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 07:59:40 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-5.19-rc8-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b20426d044163df0ff9d868e9767ca9e65dd36c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
