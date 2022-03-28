Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815CE4E9F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiC1TRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245624AbiC1TRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E5B4C7BC;
        Mon, 28 Mar 2022 12:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2574B6127C;
        Mon, 28 Mar 2022 19:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 813BFC340F0;
        Mon, 28 Mar 2022 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648494940;
        bh=fUykuyt+ci5j6L5MrTv+Hviy4KF45ZasIQ6f/i78xPg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lwd2A3BD6RnkclFQb+uH6wpciMq8TUlUld0rZytB7n9f4fFoL9MdYHHfmMhO5m6Gu
         JPS0fsCL1hURTZAfgMtL6/MJ9NeyTeiiYmuNH/XX8wvJIYNX++40Jn6X14FcFmkfKT
         EQI97NtwUBZ8iRmYA2KZOIm6B9HsgCfienXUDZ7zKWq4fvQg3TVjKK5Yl50+8uedTg
         mtP6N84/Gtn9/8IDIxnhinLjvBj1Vc72YVK/Die4ba2e3EimKDXwAWQZEWwOv11JRs
         HDcnmMJsuRbmV/iK3ilmVnhF3f1ERwz+7JYY3dJ/m7GxFJUoHM7yf11SF18jZezUkd
         sj3O7YqDV5xqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D8E0E7BB0B;
        Mon, 28 Mar 2022 19:15:40 +0000 (UTC)
Subject: Re: [GIT PULL] pin control bulk changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZ_Jr3OzfoOpSSsAJMy1Oe_=zD861jouDzCVD-BQ6yZMg@mail.gmail.com>
References: <CACRpkdZ_Jr3OzfoOpSSsAJMy1Oe_=zD861jouDzCVD-BQ6yZMg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZ_Jr3OzfoOpSSsAJMy1Oe_=zD861jouDzCVD-BQ6yZMg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.18-1
X-PR-Tracked-Commit-Id: 4a6d01495a167762de1691eb51e0413954db20eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff61bc81b3feebcef4d0431a92e2e40e8d4fe8b3
Message-Id: <164849494043.24728.12971269557915471221.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Mar 2022 19:15:40 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 15:08:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff61bc81b3feebcef4d0431a92e2e40e8d4fe8b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
