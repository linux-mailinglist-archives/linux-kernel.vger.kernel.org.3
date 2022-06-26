Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9575655B32E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiFZRgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiFZRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D38DE0B8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FA83B80DF5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEAD5C385A9;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656264974;
        bh=lyXZjtWAlKHiJLpvUlWbhF7kjfOTcgkGQmRZXI7v3PM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IbkBwBkJl31Gaf/O3tnQOsKS0Sx/34Add4e43haRxBoQa3usaIUCXxgQFmgapLzYa
         6wAsYKtbfpfI/7Y4vjkfVjTsCnD4gaGZ5ZII5wczy40jMyJrev0eyaJqJWrWeXAQ7j
         aTZWlOVlzUAhYqduZNZaLHXZbAkns4h8a4LnSgt/oADkoaHnpaNXXLTeoX5Y6Lx1q5
         b1ZLdGj/8KQAyob9E5SJ8vok6ebPrT+iTdwidSk7N5i34UaCU/DGlGAwpUD/yqFZbX
         aeajvllVWJC4Jqqrr4QfeluaEtP86V6ljuYTzSdSERJTn/h06M35IMqJVg5wuoFOnO
         Y7T+INjFo8IVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD2DBE8DBCB;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
Subject: Re: [PULL 0/3] xtensa fixes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220626104711.2024291-1-jcmvbkbc@gmail.com>
References: <20220626104711.2024291-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220626104711.2024291-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220626
X-PR-Tracked-Commit-Id: a2d9b75b19dc8863f0845ffb401d33b2286d0aa1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e963d685dda05b978cf6bcab74b3a0ad6199327a
Message-Id: <165626497390.22456.17943933827611085942.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 17:36:13 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 03:47:11 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220626

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e963d685dda05b978cf6bcab74b3a0ad6199327a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
