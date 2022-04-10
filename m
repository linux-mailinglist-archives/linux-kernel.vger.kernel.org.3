Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DAB4FB00A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbiDJUOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243889AbiDJUOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:14:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3574B1CC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 13:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECC83B80E7D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96911C385A4;
        Sun, 10 Apr 2022 20:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649621542;
        bh=lXzVYyKX9kMuwe87o/UiXITPzlGmt/cZtZ4IHhprIq0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KICWpaIRjthSiv+9yN3tOsyOPejXJ7zIF+4tqohaNMwFUs+WZtt1IiqEDEH7x0PYU
         BHqbOP/qWRJ9SGJaiEvKA+j4oaTkmVH4aujcLAQYMkSnsUUTWPr6npTj/KnpzJJ3Yp
         03xffgynchV/1IBIB/AKb/FNrf1cC+7WMFyzY0PDxrVSO0kcrT+EYXlwIQnjdjULLG
         0rWcPutSknqGrh+9OTNGdu1OSHS6861Eelr1GcKvOYt9hlt+tctRw7Hj7MuXhAaMe8
         OIefpATC/hbZIeXb6OD0cVsDXklDhZsDcUVuOYMJgl/2wxHb/TnsAcJTxE0G9aaFAB
         cDDOlZ97A0v0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 847D1E8DD64;
        Sun, 10 Apr 2022 20:12:22 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fix for 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlLRwmx7f+fdiDuu@kroah.com>
References: <YlLRwmx7f+fdiDuu@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlLRwmx7f+fdiDuu@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.18-rc2
X-PR-Tracked-Commit-Id: 20314bacd2f9b1b8fc10895417e6db0dc85f8248
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95aa17c36dc89bf008753217ed27f8a8eb5faf79
Message-Id: <164962154253.385.4073204117109499480.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 20:12:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Apr 2022 14:46:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95aa17c36dc89bf008753217ed27f8a8eb5faf79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
