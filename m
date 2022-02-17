Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549484BABC4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245521AbiBQVfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:35:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbiBQVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:35:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A32313CEC4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:34:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7D1CB824AA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 21:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66AA0C340E8;
        Thu, 17 Feb 2022 21:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645133688;
        bh=qbafOEf/uBHmpli3QQAfd8aj1cX2r3aA252P+JKq++Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EmQu1pH8GOKz+XJk5++vIXOPg6J2QabIfw1e1IaLn00uGkp0rW0tjuqYbXmCtujA7
         Roku1ZWYkkvwAcPF+k+06MQ+2QYcWfsCPXulcqAzzxWRBPXn+sVupVALG0ovNTb34t
         FKx7g7m6vq64ExnUm/Aqr5QnBWWnCDzDgf8QYY+QFEC3K2k5f/4cCUjsTEz3xh81j0
         aOV9pfFLaZrmmtPd8B/kbulsqbe2iumOqmsYonPoow4kq24ziiP4EkwP2QKmOh+RSq
         feVvQ9TQyKbe+v6roZZFvmghsp7E36FnTCVGDxpcM5gKcuT/gj4IqMTcziTPtDv8o4
         1chMWOhWVxacA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55967E6D446;
        Thu, 17 Feb 2022 21:34:48 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txai3TyGC3KHjkjLi6UMC-vKRoPJ8p+UpNKXy6Km=1jNQ@mail.gmail.com>
References: <CAPM=9txai3TyGC3KHjkjLi6UMC-vKRoPJ8p+UpNKXy6Km=1jNQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txai3TyGC3KHjkjLi6UMC-vKRoPJ8p+UpNKXy6Km=1jNQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-18
X-PR-Tracked-Commit-Id: 5666b610194705587807a1078753eadc007b9d79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3d971ec25346d6890e9e8f05b63f758cfcef8c5
Message-Id: <164513368834.29727.9550946484573068640.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Feb 2022 21:34:48 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Feb 2022 06:02:24 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3d971ec25346d6890e9e8f05b63f758cfcef8c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
