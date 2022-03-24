Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44C84E6B45
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356266AbiCXXkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354028AbiCXXkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:40:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CFD27CCD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D037B8226E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46039C340EC;
        Thu, 24 Mar 2022 23:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648165120;
        bh=mScaLpR8zwsSQHZCdjC3pAla7NlmmDY7f2p4l1ohMS8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WyHpfOb6GlEJDpwNGdNAPayYsSdLNPH8GaO16q0Cwpgpw5qKhfeIMHtcPDP+OrXS6
         ysb0IPbwRyIBrrZmZVhnSxwBRtwXE5JS8rman9hz8v4jLayxWeZPYrqDUZtaOfWE67
         1tQSCGpa75OhqNRVSwAZx0kfM+03Qa/q2bsws8To85eZwLTfP6fzn0HbuMkikYr1t1
         BqWHc22+31RVBwIY8DAAH5wUHkV2ALzdNaGFzek6sGLZDOHIrLa5ytKEKEpUR2SfuS
         7V3cdRJRiqpqCwM+5U9vxWByoiG41T1ApH1AlMKc1IE/iHjImtndZVTHbrXgWB03VG
         67AQXDnn0zTgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32F45E7BB0B;
        Thu, 24 Mar 2022 23:38:40 +0000 (UTC)
Subject: Re: [git pull] drm for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
References: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-03-24
X-PR-Tracked-Commit-Id: c6e90a1c660874736bd09c1fec6312b4b4c2ff7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b14ffae378aa1db993e62b01392e70d1e585fb23
Message-Id: <164816512020.13472.6357726227995995877.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 23:38:40 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Mar 2022 12:30:02 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-03-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b14ffae378aa1db993e62b01392e70d1e585fb23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
