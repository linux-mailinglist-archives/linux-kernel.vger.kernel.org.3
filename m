Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EE552687E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383065AbiEMRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383070AbiEMR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E71712EB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A3162111
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52246C34100;
        Fri, 13 May 2022 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652462992;
        bh=B8CGDN7y6M1auE45HI99CT59aTPOWfRlXkGTTSNilxw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xqt6wock41uKVJbawsUyxIG8YmxYwfbVfFxYR4R0cgoptHCFZuol19uPFqI3wAZiI
         IONzsE7fY7K1k8RSguL6x8MjNH99zjE0ONDAkbdagCD70jv43SnoLaut0ABPpjc//E
         J9+ZCTqzB1ub8sATFOuj0QbpaIOGXROiAbOF1OvpLy+Hd0nReVpZsPBynzsoMUnkQ4
         312Hrn9Cded6Q/mTwyJ9Lh2BEMt9VKXWR+Ewrob6C84Gt1KGZlQ+YgYnsUYY+fkBgb
         StUbm5gnkmJZvww0HCx4KANZOZp4pN7xw3qmvtYaFxd5Qpwe/xlNCFFceA/fr3Py3y
         2ZkT67ibMZaeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E0A7F03934;
        Fri, 13 May 2022 17:29:52 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twJK9u=8+8UMtTRvxe4yUkSQBcOLa_gzB+Me3W=qoOv4A@mail.gmail.com>
References: <CAPM=9twJK9u=8+8UMtTRvxe4yUkSQBcOLa_gzB+Me3W=qoOv4A@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twJK9u=8+8UMtTRvxe4yUkSQBcOLa_gzB+Me3W=qoOv4A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-13
X-PR-Tracked-Commit-Id: 5005e9814698f47c5a3698fcc56c9f5e6f1d4644
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10b4b67ab58248636723af181734b9574be05ade
Message-Id: <165246299224.14811.8056452477762273863.pr-tracker-bot@kernel.org>
Date:   Fri, 13 May 2022 17:29:52 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 May 2022 15:07:55 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10b4b67ab58248636723af181734b9574be05ade

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
