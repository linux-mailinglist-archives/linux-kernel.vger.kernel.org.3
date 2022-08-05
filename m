Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468F558B2CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiHEXkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbiHEXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB21F7821D;
        Fri,  5 Aug 2022 16:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E78614C6;
        Fri,  5 Aug 2022 23:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 367B2C433C1;
        Fri,  5 Aug 2022 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659742804;
        bh=lFkcazodv0eT9g8xMN2SYHeA8H5Gka0Bc/opl9Iswzw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SeZp8c4gaW9xnYN5eqV+iRsQkdr+8vO8LYRAG9a9eYxGUdxNFCLZ6qsI6X4Gdwnvb
         ovCoXARkoGeLKtJzaWgy0vrw5aWqwd6MKDj4mE1xtL1ZMF4/Nv4QbcVYw31fYE514D
         1Vjj3+pOCrAzC5+Pi/0pIrhynpP1+84HPQEXoSHzFtJU6+3GI7tz5++n8Lh/v0dCXb
         YEuVdRNwPT1ZO3J0Fz7dWGZ337HQGvmCqQM7C852izNyZM0JSVC9klSZQNEbADLtZu
         njSrONEvwN51HNHRpVQWWH4ryuaP1dgtcqX6K6uyxR4fWTqDdxTTaCxdYZBoIIFBeN
         9y3+e4taT80wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19957C43142;
        Fri,  5 Aug 2022 23:40:04 +0000 (UTC)
Subject: Re: [GIT PULL] MM updates for 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
References: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-08-03
X-PR-Tracked-Commit-Id: 360614c01f81f48a89d8b13f8fa69c3ae0a1f5c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6614a3c3164a5df2b54abb0b3559f51041cf705b
Message-Id: <165974280408.17862.1430140279382151006.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 23:40:04 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 13:35:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6614a3c3164a5df2b54abb0b3559f51041cf705b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
