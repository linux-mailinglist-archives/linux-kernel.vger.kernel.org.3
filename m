Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0861E54F059
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380050AbiFQEoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380017AbiFQEoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:44:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F2664D0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8E0D61E04
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16A9EC3411B;
        Fri, 17 Jun 2022 04:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655441052;
        bh=7s9DpTvHeOxDSPMsQJSfiVg3fwACOC+KfYrtWEplkAg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yq/GRo2POpBsoJqWcr8cPFxIblNW2GJPEHnmxndUSjtw7KAzUscEFofBOFCXJWwak
         Ws68Lb3lRght5pC6yDpnONDx0R6QvoCZTfRn+JVYWadRyfPGIUUxICmP+vqlYkR3ip
         WL1FHI6LlArs88PJfM6Fpoy2obo5vvGs57QzG5C2IgOqNlPBZpS5XBSTsahUQiwTqs
         63hh/vU1ASo4ae5GotPswqIjZtzaqo29yuRywFHeO2YYsZwwnijh5S9bvfr1MrNHMm
         nZgR6O0U5Jgle4QGNa8S+D5V2OUPO07RhhK6AmKueDeuMh2fHPjPq3KvnVmtmGz5j1
         Qcc7czb6b/2Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03A49E6D466;
        Fri, 17 Jun 2022 04:44:12 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twTA=AXfjj=eq558KLmE_TfmkoRsm6Sm5MUB0zCZ174Wg@mail.gmail.com>
References: <CAPM=9twTA=AXfjj=eq558KLmE_TfmkoRsm6Sm5MUB0zCZ174Wg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twTA=AXfjj=eq558KLmE_TfmkoRsm6Sm5MUB0zCZ174Wg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-06-17
X-PR-Tracked-Commit-Id: 65cf7c02cfc7c36a3e86f3da5818dabc32c270ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47700948a4abb4a5ae13ef943ff682a7f327547a
Message-Id: <165544105200.26112.4731974293198817958.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 04:44:12 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 14:13:41 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-06-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47700948a4abb4a5ae13ef943ff682a7f327547a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
