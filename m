Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5E50CC87
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiDWROt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 13:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiDWROi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 13:14:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A9B1B7B2;
        Sat, 23 Apr 2022 10:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DEC9B80CFC;
        Sat, 23 Apr 2022 17:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E6DFC385AB;
        Sat, 23 Apr 2022 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650733899;
        bh=ojHFg3Mll54qdMgPkyiRIPjr9LFoC7ZGc1oGmReWjG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jxuyWP0XUhJlmaslwhSSEwp2TZInKtthJGIkJaQrmYTREcnkoPXoN4y/HZuWiSOBj
         EF0w32qXg1MlYbkSl3m0mg6prqEzAMAE+9M7N04O5iUmRkA4ZY8j0Cuc32yg09Buye
         zD951rtALkniHLJahI9MqhIk23QrQdxNnMc3qZYedPX2gpYAz9MzyaBqn4aFureWnH
         SxLeLDPJXIMN5EZexT6zFoz9BNndkXKRP1lHVDzarjHXkpej97exdZLFktORBgI+pB
         5F/JbrhY5CIg07WGYH9A4mBGFjUkCdW8lLp2ydietQK3AXmD0V5zb91CBarUq6qgrE
         1dj3D+3qTi0UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C989E7399D;
        Sat, 23 Apr 2022 17:11:39 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YmOEuZ11On7T7Gbe@google.com>
References: <YmOEuZ11On7T7Gbe@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YmOEuZ11On7T7Gbe@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.18-rc3
X-PR-Tracked-Commit-Id: 470776c6b03491a3e82c644737a6da5466b8b3eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fe86b27cbad8003e90aa78ebd19c3d8a3eb89a5
Message-Id: <165073389904.30714.652964634262860801.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Apr 2022 17:11:39 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 21:46:49 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fe86b27cbad8003e90aa78ebd19c3d8a3eb89a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
