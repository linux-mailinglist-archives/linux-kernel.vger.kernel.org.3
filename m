Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778850AE7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 05:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443756AbiDVD0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 23:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443730AbiDVD0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 23:26:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9914D63E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 20:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7865B82A2A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 854FBC385A7;
        Fri, 22 Apr 2022 03:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650597811;
        bh=O/viPJYPHRZIpmTuoEaBkacx7MMguY7hWUbhqksXnkw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qpXXyjfJ14mvXbLvLyq0qTyy6Lpg5nd5+Uklkec6LhqNaQQFoK6uRFWUoXPi3hmEx
         yIDfY1lDEpd+5boLProrbBQgWfphGoPfQ6qTkjMc+rszrxuVysTE/5/Wrkv0ofsL89
         GMhUv7UY5V804heZb/3dA3w4nz8Sx/6EvjQTLfg2NZDY9CgH5scmmTpJlhndIpcPjI
         OUUNnrrzzCA5/mP0Q3m7+P+T7q30TXv5ch7OQBVd/8VuhlT3GgKAXIBadDkDWmAhYB
         t1tK6NXvSQ+vNN5h6ofj2a12PROKt11zvbRzycFY4aRVkqfMAUTLqqvE4R+gmLlomz
         lVHraWmV3hkhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70CDAE8DBDA;
        Fri, 22 Apr 2022 03:23:31 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzQpOnBBNNYWDaJRBztOCVM-PmprHHWZnr2yLh2rb2Y8g@mail.gmail.com>
References: <CAPM=9tzQpOnBBNNYWDaJRBztOCVM-PmprHHWZnr2yLh2rb2Y8g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzQpOnBBNNYWDaJRBztOCVM-PmprHHWZnr2yLh2rb2Y8g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-22
X-PR-Tracked-Commit-Id: 70da382e1c5b9b2049c10abfd4489a40c1b60df0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d569e86915b7f2f9795588591c8d5ea0b66481cb
Message-Id: <165059781145.714.9614384696896372863.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Apr 2022 03:23:31 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 12:56:18 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d569e86915b7f2f9795588591c8d5ea0b66481cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
