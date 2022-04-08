Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A024F8E2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiDHFkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiDHFkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF91187BAC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2610F61F32
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8719DC385A3;
        Fri,  8 Apr 2022 05:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649396313;
        bh=4VwFY/1dGrKNVVe0C1muo8ohXdUHOioA8pasVOe2NLU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SIag0LzbJITvSskJYSUuM+Hcj9G++x+fWXivJbjLh9jNyueu90fn07GNZ2909RvTx
         GWbD0WoHCKAcsiaLKp13CKrEP9SDqBeCyoKWmSWjEZbrGtiVXi8GVk704GxzjHO0SP
         DCPEP4OvfYVpWJQFZZ1jm2pQ+x8kOMIcllx0NUdIn81jXHBmKjW83yMEFJ798oyAQp
         AxAZ9mDJ0OFy2kfI5KU+xrIO85V32WAQggAKr99qPTWojMBXjucWPsmV+YqWgAYNdN
         9FHgAnjg2z81TeEgyyImfobuEV4boom+y1i0pAOiO5r5dTYUYXa+CEGOeCqVFAp05B
         Zq8DdOd2vsTyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 745D2E6D402;
        Fri,  8 Apr 2022 05:38:33 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx5F2iOY6S4o2Rjk3uZG_M5Tso+=j3_gyQk-p3vj8tqew@mail.gmail.com>
References: <CAPM=9tx5F2iOY6S4o2Rjk3uZG_M5Tso+=j3_gyQk-p3vj8tqew@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx5F2iOY6S4o2Rjk3uZG_M5Tso+=j3_gyQk-p3vj8tqew@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-08
X-PR-Tracked-Commit-Id: 88711fa9a14f6f473f4a7645155ca51386e36c21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1831fed559732b132aef0ea8261ac77e73f7eadf
Message-Id: <164939631346.5614.12089109522962019963.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 05:38:33 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Apr 2022 10:19:47 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1831fed559732b132aef0ea8261ac77e73f7eadf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
