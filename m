Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1170C58D037
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiHHWhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244574AbiHHWhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:37:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5FED5B;
        Mon,  8 Aug 2022 15:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6826B60FF6;
        Mon,  8 Aug 2022 22:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8A1EC433C1;
        Mon,  8 Aug 2022 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659998228;
        bh=z2JFBfmXjunm+Gu2CL+BYn0OqR7OLi5A3qX9UH0YlzI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f9SGqSxPdRIteumH4pwehUhdSmiZB4hLDMqOQkijr05Dn+LahXRvqxukFhTBI+1ZP
         5+He9F6jxOYSDwIV4dslPoUhQ+P5jBuHoz9sN4OsLlahvo6K5SIBGWsPH77qjMzkxg
         sfNisYb7Vnymv2pkcXe9IEDgfMMLOK9GcMhwTAgk89G2v+pXH5AAyuUCjakNJdKpn0
         qF80V6HNhvK5Y4cHxVTd4fPaFpllMdNxUF5mHsW415NRE2ZwS4tngp2LG9yax4id7Y
         tqBY36QQyv0o3lyi7X5CTNvxFt+1rEOyoIJuPGG1kJzwDlb/Beest9UuhB0wSB9iB6
         50WXsvyTkPcvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B913DC43142;
        Mon,  8 Aug 2022 22:37:08 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iTeVEHGZZeo+qBSgKENY7E-jp0MEu30Barm=yYjnYMxA@mail.gmail.com>
References: <CAJZ5v0iTeVEHGZZeo+qBSgKENY7E-jp0MEu30Barm=yYjnYMxA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iTeVEHGZZeo+qBSgKENY7E-jp0MEu30Barm=yYjnYMxA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.20-rc1-2
X-PR-Tracked-Commit-Id: 7f0169cde0ced2e2b7bdf3dcedcf8c71efc6afc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 033c88d58b66a5bf61a9a4f0029c4fb771f0555e
Message-Id: <165999822875.1400.17392658230653193656.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 22:37:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Aug 2022 20:11:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.20-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/033c88d58b66a5bf61a9a4f0029c4fb771f0555e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
