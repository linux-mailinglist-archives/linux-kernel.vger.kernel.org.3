Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9742501F09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbiDNX23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbiDNX2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FC33BFB8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76975B82BD0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 192AFC385A1;
        Thu, 14 Apr 2022 23:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649978756;
        bh=zO0a7JQ4YMZAwt19rLoBWiio/HMoIOd+2+LLq7pctxQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QU8slMHfn8f2VEp1RZq0ksJ+ywoq7MRvlApGZYSthx6z/cBLQ2Ko5C/Q399VSQkEU
         pFIjeBOW4rlDtss3Bl9whikwD3zuqqlfCqDKdGHBKXfP+kFlImreCLMcD5RdMUx+4B
         KsdyjmiQbqC99uHu0NuCe+gu3fPZTwDn6W6jvrtaIOWQHI8VyX2yzVvdXT26wSRQgb
         DqlSCrzfgBprGmiILCAli/cbvtKVZZLWR7aIui1dPVmhlGhlZ2t2Aeplx7CAqNmImK
         cHSTSRTSOIBbmZDogW2RQIuH0+8SYljkOUZL8sCX101AwjCcvyRCG/hub18hEmFb+p
         tTwPlqD5sjl4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05A8EE8DBD4;
        Thu, 14 Apr 2022 23:25:56 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzmeDfgQ3VhutQWLcgVhodHJhGmzrjMTB=yvXOhwnw0CA@mail.gmail.com>
References: <CAPM=9tzmeDfgQ3VhutQWLcgVhodHJhGmzrjMTB=yvXOhwnw0CA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzmeDfgQ3VhutQWLcgVhodHJhGmzrjMTB=yvXOhwnw0CA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-15
X-PR-Tracked-Commit-Id: 8e401ff5380a921c309d4c73cacf27b0bdb5f168
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 028192fea1de083f4f12bfb1eb7c4d7beb5c8ecd
Message-Id: <164997875601.7927.18422842675469296524.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Apr 2022 23:25:56 +0000
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

The pull request you sent on Fri, 15 Apr 2022 07:33:01 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/028192fea1de083f4f12bfb1eb7c4d7beb5c8ecd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
