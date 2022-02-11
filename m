Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229204B2E31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353183AbiBKUFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:05:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbiBKUFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:05:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B3CE5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:05:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05F0BB82C91
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF9AFC340F1;
        Fri, 11 Feb 2022 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609920;
        bh=kBI3mK87tFPw2qjgLo6XozAmUBtauzjU7K6ZBJI46C8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qg1Z+x502LtLsiy1nDN0NC2MeSKhxM3vnVGShtNN6A6Uz6+2INih4oscu2sZX6AlV
         OCYjeGZqT93eRuewbXiZauIXjS4E+o7FZcyPVpEs8ETN/wH8UrR8ckqRB33LhsUadU
         V4oh9OsuNODZ0hdep9dDeuQEgtsz+02LlErht8lh8k1Rk+5ILya2HeB4ODUMFnc2Q2
         a4FBDcrkYSJO3B+/lIacXcEWQ7GQBPNvsNaGWE9UunKVHgPPvut28awriJpCPb8cnS
         40DszxB7VSoKVFAn6kuBVz+ze3IMSa1U/2OfY90gYaErIiv2EJ1/8k68bNq86oHQcT
         twbLfpEoVLh7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 977A4E6BB38;
        Fri, 11 Feb 2022 20:05:20 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twGhyDpEsDEGQoYR2UXOp5xMAScivj8rWheh+q3ufzNjw@mail.gmail.com>
References: <CAPM=9twGhyDpEsDEGQoYR2UXOp5xMAScivj8rWheh+q3ufzNjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twGhyDpEsDEGQoYR2UXOp5xMAScivj8rWheh+q3ufzNjw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-11
X-PR-Tracked-Commit-Id: 95e875bdb1862db178bf24fb703387ec3aa3a34a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3ee3a9e4fa6b1d249b5abff2d4c7dab5a47d522
Message-Id: <164460992061.1412.8658412567709434075.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 20:05:20 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Feb 2022 13:46:47 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3ee3a9e4fa6b1d249b5abff2d4c7dab5a47d522

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
