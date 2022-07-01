Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1A563923
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiGAS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGAS1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55FF27B38
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EFC861243
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 18:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7CF7C3411E;
        Fri,  1 Jul 2022 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656700059;
        bh=4Qw6TELy1PwHY/XcfcfubMfy6y/rrfBx/cSWxYqsbT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LME67ANEzRnVzAwh0dCtVQ/KSSWRduKARaQsv0zyHcRntXIBWxag4/RAZZh3CZI2n
         Eqk5kX/L42+hAsm0PGZ7nsS+3YEZ/9VoI4/hCWUJJMSNUtmwCBNcrhPpiGvCmeHpMt
         ZZdjtlhgKHQw8HN1/pijcHuLO9SsfvStKfZivv/L+rbw9lLSu9g49Rh55IT9IUBP90
         gfRlr6yRZSr5FlvPvLspKh0T7LKo/bmgGcQNXogXbX7QAjb1yVBqzt8H09uGw+Wpv9
         2ECy3VyoXSuk2yf5u4DHiffzI5vc3Uin1sFgCj4pKypiRBpKRPU/v95jAQ6AP56AC/
         BIIrTVpH06Nqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5499E49BBC;
        Fri,  1 Jul 2022 18:27:39 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yr8v9alP3O4HZudw@arm.com>
References: <Yr8v9alP3O4HZudw@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <Yr8v9alP3O4HZudw@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 410982303772993a86bb7a9cfa7ece34522b2636
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0f67adb790698017030365e90e9e394de7cac7c
Message-Id: <165670005980.28259.8198121257784076084.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 18:27:39 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Jul 2022 18:33:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0f67adb790698017030365e90e9e394de7cac7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
