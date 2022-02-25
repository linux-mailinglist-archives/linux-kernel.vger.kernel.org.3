Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82484C3B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiBYBiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiBYBh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:37:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4441A7DBA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:37:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D3060F45
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82FCAC340E9;
        Fri, 25 Feb 2022 01:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645753043;
        bh=MgY/heTtuC9YzfxdGaQTLjYJmNFmfmF9h/xxsRPSbgY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lXaTkvC9AoK+LwRYSqHyTNtZSXhEtMhS1ZotjCajfgYAjaeNFMdzFUhIwydEV9uui
         RxD2BntvQN83d+IVhJTq1hhC5QZ98ktqVI5iyq9rPUBRnMXP3nCrepbFnR4iA3QxMB
         PWjOKJDFTynM24wuNlVsMXLB/YAli8o63jL/7gpEXXkHUhLxlhl1lxI0Qo/y/gA7Mx
         04YogF0DwBzuynicaaVkIHqKiwg7XdzlBfsHeJffwt1lMNJI16RUsu54KUeYPUhMxy
         R4VXDcdz2HsXObepmCv2N9PH8Q77WYSTG/H1Qg2EHnk9KPQLdakuc58vi89Umk7G/E
         VI0ay6Bt5IwNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FF13E6D453;
        Fri, 25 Feb 2022 01:37:23 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twsapa3kN3wkRfpqT7dZPDbFePicHm8TT8yVnwqH6aZyA@mail.gmail.com>
References: <CAPM=9twsapa3kN3wkRfpqT7dZPDbFePicHm8TT8yVnwqH6aZyA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twsapa3kN3wkRfpqT7dZPDbFePicHm8TT8yVnwqH6aZyA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-25
X-PR-Tracked-Commit-Id: ecf8a99f4807c17fa310a83067a95964cedd9ac1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ee3d0015a4cec798b44ceefc34245752104fc08
Message-Id: <164575304345.32163.2584856599519574667.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 01:37:23 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 09:01:30 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ee3d0015a4cec798b44ceefc34245752104fc08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
