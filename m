Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282FB538789
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbiE3Sqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243018AbiE3Sqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:46:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CFA68988;
        Mon, 30 May 2022 11:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBFBDB80E3F;
        Mon, 30 May 2022 18:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7055BC385B8;
        Mon, 30 May 2022 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653936391;
        bh=IhEK5wype1He9/Wx7O1yOSp54AT9L3opX5FIrcizRwU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n16OOl+GalGuS5LXwTfE7ZcqjneIwWJoSotwYvm441aFV/UUbleqyR926qXSm573L
         edA2lh1O8wVNYRbX3mH4ybY2gVXehH0u/nXmWGehjfrHV4Sd5RgB2nkHQ5Kh/WDh2C
         UEz6VEe33YCP11ckiEghkNqVzAaLN1zeh9IhTgyvSAuBDf0HGC2WLonBRp+qJbrvci
         sUmG58V/yRM+V6BBx9gtLJRVs/2ee7b4ai8NecVH40f6yAzVo9o0Z0h9yRrjGL0YMP
         cqKy1Hq9TWMNPR8ZCZBx37MDL31Nt/1N3sXgzv+gdTj50dgxb8yD1Piv62Sfwcs9+5
         Ttgz3OyZONu1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 584FBF0383D;
        Mon, 30 May 2022 18:46:31 +0000 (UTC)
Subject: Re: [GIT PULL] Additional thermal control update for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gxN7KxWYmTfc-o0HPD0XxEb+U7Hwjg8ZcNLp_z962YHQ@mail.gmail.com>
References: <CAJZ5v0gxN7KxWYmTfc-o0HPD0XxEb+U7Hwjg8ZcNLp_z962YHQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gxN7KxWYmTfc-o0HPD0XxEb+U7Hwjg8ZcNLp_z962YHQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.19-rc1-2
X-PR-Tracked-Commit-Id: 3c1d004bdb4e12b4b1dfbdd6a9167ea5003e48cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32665a9e5432fd88fe20f4affa8986833bbbabe7
Message-Id: <165393639135.11978.8015902993445660743.pr-tracker-bot@kernel.org>
Date:   Mon, 30 May 2022 18:46:31 +0000
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

The pull request you sent on Mon, 30 May 2022 18:50:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.19-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32665a9e5432fd88fe20f4affa8986833bbbabe7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
