Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4EA53D89B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 23:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiFDVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiFDVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 17:20:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38B54D61C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 14:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67DEEB803F6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 21:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24100C385B8;
        Sat,  4 Jun 2022 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654377609;
        bh=+nTlPlfH3rEya5YlWPmNahFTP52wZZf4MtWI9B2+xjY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pS7W4O1ueAmB9KWGg+jKigrW4F29ji1K72iHRD9ytbShUVbikgzLy0YhTPC40lUtR
         N7pneiOrWpuwTLmakcsNMYp2t11aIu4iSV4cNN564J8EXDWm1FO1m8fO3qFD6wBqNH
         wjHoboShRifj7kDRdcddO2NGz2UY6zSfIKdHUv52c7dDx3rh4DuoxMlQ4459lYA4UD
         Z/UO/O3hFJha3uQ3GkKD2onKnGgIwFWxQpUx4qLOp2cJoJ8OH4c7W5/vXnSydWVjKP
         blDMWj5HSxW6bPlnH584iFtMiViSqs7o+PWH+O7duM7fR4VKvgnGol7PT9WgCbVlJL
         /yAImBvTeK1nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FA7FF03875;
        Sat,  4 Jun 2022 21:20:09 +0000 (UTC)
Subject: Re: [GIT PULL] Bitmap patches for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yppk/mN+KYTDkvz3@yury-laptop>
References: <Yppk/mN+KYTDkvz3@yury-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yppk/mN+KYTDkvz3@yury-laptop>
X-PR-Tracked-Remote: git@github.com:/norov/linux.git tags/bitmap-for-5.19-rc1
X-PR-Tracked-Commit-Id: 0dfe54071d7c828a02917b595456bfde1afdddc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0e60d46bc03252b8d4ffaaaa0b371970ac16cda
Message-Id: <165437760905.4820.4833739686139165244.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jun 2022 21:20:09 +0000
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 12:46:06 -0700:

> git@github.com:/norov/linux.git tags/bitmap-for-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0e60d46bc03252b8d4ffaaaa0b371970ac16cda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
