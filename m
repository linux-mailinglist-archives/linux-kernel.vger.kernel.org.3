Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B18589681
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiHDDSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbiHDDSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:18:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF256050A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AE47B8244B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41F3CC433D7;
        Thu,  4 Aug 2022 03:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659583075;
        bh=teA4AMmtGGE5tPWB7CsjfMwgkD+96W6hd/TD1ykoqyU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g+6H0+Xb+lYr1qbx/IP/bEUAotoLEDMt/GZxi4KiNcYiFfp7i8iUZ4QjWR1uwo4wI
         6ycf777I34sI5jwoLoKjpWPIXhzFk4q5kB7Z/upVnS8xQDOqVIP4v22g/CYAOz8N8T
         ZWCG6gxUK1DMWuQEOmZpbDUfhy1vsQrzp4ZWajU6PlBdUIC4NGpOXJ7ilyz9s4mHrT
         D07xtQFvjm9EvLpQB13KwL49gDnRJCeN7TxdubtG5sz7r4j60LAeY+H95fo8rSqNWk
         rOyzlyArQjKAdpvwd7JuQiToiE7DRE2mXDJsLZS9V+0djwLbtrQ7upzp1K3CTT8/MF
         5Lir8xEkzz45A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31227C43142;
        Thu,  4 Aug 2022 03:17:55 +0000 (UTC)
Subject: Re: [git pull] drm for 5.20/6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-08-03
X-PR-Tracked-Commit-Id: 5493ee1919eae4f49d62276cf5986b7f7c7aa8f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
Message-Id: <165958307519.6841.14174025933378032922.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 03:17:55 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 15:37:43 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
