Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D12E5627AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 02:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiGAAYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 20:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiGAAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 20:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A71C57234
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E2846149C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A01DEC34115;
        Fri,  1 Jul 2022 00:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656635078;
        bh=o1vMaH73izzkhhJF9DTB1crEovwGoPeGwIoVDHdeCx8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fLm5eJ62pAUwhRjYft/NmqGTT954phT3+GPi8n3QjlCRNzf+BrUqsaAEoby9tTR5R
         zKumFS0af8FhwIhFk7hLRcOZyZ1C/A6wKVGGES6bon15Y6Ain8HucgqLN9HXcTW9Y+
         uSPYnBv2zqHZCK8H9xug4NG1sHImMpC6x8GO8up0MvpiHAPyB3KOw/63GvfCPLHYkf
         +qjQqAQAgQRq2DH3RN27KS79b1cdWnRqTCOrxCVP9rVybJXgRKoCX85nGCAn5+cWYU
         pVeVWn2zEJeFgWhgfZbya5+9YI6eJWZlxu29p+UDBizoGiZ47RLMDbJAACVpFFIWvi
         TPLGlNxSPtKjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A769E49BBA;
        Fri,  1 Jul 2022 00:24:38 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twfRe7w=z0ZQwBw7u6QiDQUWbXi+AZO4wE=MCzNK+RByA@mail.gmail.com>
References: <CAPM=9twfRe7w=z0ZQwBw7u6QiDQUWbXi+AZO4wE=MCzNK+RByA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twfRe7w=z0ZQwBw7u6QiDQUWbXi+AZO4wE=MCzNK+RByA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-01
X-PR-Tracked-Commit-Id: b8f0009bc9edf9186b20ae2a9e442ef0af93040e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a175eca0f3d747599f1fdfac04cc9195b71ec996
Message-Id: <165663507855.16741.3880143189300433242.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 00:24:38 +0000
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

The pull request you sent on Fri, 1 Jul 2022 09:50:09 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a175eca0f3d747599f1fdfac04cc9195b71ec996

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
