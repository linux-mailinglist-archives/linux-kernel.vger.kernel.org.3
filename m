Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D94D5A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbiCKF0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346479AbiCKF0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:26:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD0C1ACA2A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:25:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4DA3B82AB2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B7A1C340EC;
        Fri, 11 Mar 2022 05:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646976332;
        bh=0OyS/c+CHHnjlxtkeX0bmgy1NsydLIwEYrKLjI6ygAg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VLYcdzlKpewDFvba/cnJmBltYv3k4gpA2kU0HYIEYwxg7JyDpmMBoqvXVflB2muv9
         4iDr/XNycH5rkHjp5ew60youXhyaCpZPGUqg2UyJ4KpT5A4PeOeVnb5ssc8/eLtWGw
         z1sf8vnZU0iM3UPBb0UPRtzmQI3JzHSXpnWtTVdFEXZ+wDJAjnl4pN1R8AI8jSiUxh
         OYH1+aYix2hfooItbgYb3jG+7OMdhMXlcswtxwCVXFNJ+ZRZ2hnJPmFUuOMU4F8xLS
         VeQ4TtwizUa+9BQChpsPxzXn6SlWGDJ1/wEYgSTQjJ2TQYSm+AxnLrXyxekSL5a4Ib
         Qb8vKveVIcmaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88A23E6D3DD;
        Fri, 11 Mar 2022 05:25:32 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.17-rc8/final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txhThmkeKMjTVXGL+RYQDxBZv2c4syb_3V7WF=8sZhaHQ@mail.gmail.com>
References: <CAPM=9txhThmkeKMjTVXGL+RYQDxBZv2c4syb_3V7WF=8sZhaHQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txhThmkeKMjTVXGL+RYQDxBZv2c4syb_3V7WF=8sZhaHQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-11
X-PR-Tracked-Commit-Id: 30eb13a26014ca640b5eb57b6d010114084d5c92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79b00034e9dcd2b065c1665c8b42f62b6b80a9be
Message-Id: <164697633255.9165.8919622792541567761.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Mar 2022 05:25:32 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Mar 2022 15:15:09 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79b00034e9dcd2b065c1665c8b42f62b6b80a9be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
