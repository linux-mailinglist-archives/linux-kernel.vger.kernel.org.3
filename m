Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418F4CDE1E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiCDUXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiCDUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:22:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE315168E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:22:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52E22B82B88
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 20:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20743C340EE;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646425321;
        bh=k7I20oRAc7QQlFOC75wm4+L8hQNSXc34k5IdGMa59vI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GLAltWoTCLlKjQgq2q+m6CWEZx9X8h11AdHj4Q77FaptZpUNKqR9NnmH8+lsUX3ZW
         9aze1BCy95RmZ89vY7tCvkGO9BsBJk+4l3fbcAhooH/TJMEPTQorkAmVEVi84NuIPG
         H7T9UY7Kyv1zujg1b4FKDFeIKHgYANuN59d07NCOCgPWnWVJRH3mYTe+LzAQfKxRVW
         tnM9RAWZ/Q5LL49CbwghK4qtDyb3PI2A7MLsFNuDq5cEFzhHdvZqDEM70WONoBiG8b
         2lMP+jIbwBlu1Ey1o/Z81lbVS3YWiV30sSGzB5NRdqVy5SoyqZYwGJUpCq8yUg9nwB
         q0Nv8fYzIdM7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07908E7BB18;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txdUAqhJOhz+09qtFLJNOThDMNQxLu6kV-v6o1bopXhNA@mail.gmail.com>
References: <CAPM=9txdUAqhJOhz+09qtFLJNOThDMNQxLu6kV-v6o1bopXhNA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txdUAqhJOhz+09qtFLJNOThDMNQxLu6kV-v6o1bopXhNA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-04
X-PR-Tracked-Commit-Id: 8fdb19679722a02fe21642d39710c701d2ed567a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4fc118ae26f9d4e5885d151f9b0f96467a136da
Message-Id: <164642532102.24805.6722187428894435121.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Mar 2022 20:22:01 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Mar 2022 13:34:36 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4fc118ae26f9d4e5885d151f9b0f96467a136da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
