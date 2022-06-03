Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8AB53D1C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbiFCSuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349270AbiFCSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8D227FD8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D8A61991
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BC55C36AEA;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282222;
        bh=Zt10z4FjMPTL/QPpCCL9bSLoVjTmhSjo1x+k4Dn70m4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k4mx9hguXeaYwA4iq2mZBMCOQ9iBUUFgM6hElUU2QEm+qbGpoLd3GtnEzR3G+zvcL
         1MMiqBkmiwmKoZpPSdeYSDDVxSrmr/O4Py06n4FxFbk/1Rz+rjEeV3cgC1j+JnC/E8
         /OcQ/DljYQjwao81wWTBgmkPe0IJA/txGC1SccjfiF4E/EPq4YCWfseXtsaKaWWZqj
         3mHvCnM0riZPa2HfucObuqkwObBcCI3EDWs5aex+/xhjJfBUW/1pjPlLqAke1n9Gc/
         e/N/F3L1IWJRWt16ndfnRrmavPzGK62rbrVL0N5eShxkEeOAedhAwAfSS/UTsYkNRm
         zmJS4n57k54ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2868FF03953;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
Subject: Re: [git pull] drm for 5.19-rc1 part2/fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyz_Waptpxd82f8fLLeqt9pp8dOUCxjxA0YtaOs31r+Fw@mail.gmail.com>
References: <CAPM=9tyz_Waptpxd82f8fLLeqt9pp8dOUCxjxA0YtaOs31r+Fw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyz_Waptpxd82f8fLLeqt9pp8dOUCxjxA0YtaOs31r+Fw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-06-03-1
X-PR-Tracked-Commit-Id: 404204340c0dc54e4b779737201044dcb231f0bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab18b7b36a82b1900687c5718f7d46f0d8e77d86
Message-Id: <165428222216.10974.7011867113246739776.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:22 +0000
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

The pull request you sent on Fri, 3 Jun 2022 13:49:48 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-06-03-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab18b7b36a82b1900687c5718f7d46f0d8e77d86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
