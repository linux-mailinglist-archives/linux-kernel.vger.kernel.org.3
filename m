Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285394DE1E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbiCRTkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240397AbiCRTkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:40:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679DE10E042
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5430B82540
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 19:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F27DC340E8;
        Fri, 18 Mar 2022 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647632339;
        bh=uh4hShwgimRuZULyyXwWuyWdR1TFqdAV7+3Gl594/s0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MH9Ww7rnpeyohJeF0KLdTD9iUM1SNVIy1FmHcVObFdFW/w6HU1p+pV9QzhSGM1Uyf
         k6cNgocBGLeSJoVL7kfmNOzpDzkTvJ9b76uFKlLzK0haEhNjiOd2gRae+QfvQlob3o
         +6xaFHElfWVY0cFxSD8ckjFbfYmfGyueXBmWSv3Ox6Ir2RVMuYjYIKFxtteoHHiLbu
         Qu6Z92n6orJzsSdb39dLiZL/VucpAfPtKEEyrkKS3DZl66UiIFYilLF2Q1Z3hcpUH8
         fBren1V6+CNWR4i7NTjpkSm3ac1eVY9TpRhK/KUhxh7HGSFX3vvAkUU91QHlXuS6C+
         uwnjUs7twtcMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DDA1E6D402;
        Fri, 18 Mar 2022 19:38:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.17-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twzN9ybw1N=n6JWNQgUd9UNXBxis+PguKagt8DSbW=y6Q@mail.gmail.com>
References: <CAPM=9twzN9ybw1N=n6JWNQgUd9UNXBxis+PguKagt8DSbW=y6Q@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twzN9ybw1N=n6JWNQgUd9UNXBxis+PguKagt8DSbW=y6Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-18
X-PR-Tracked-Commit-Id: ca5a5761ac542691a6b3520b6c5c047cf63b4b8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cced5148a1303a2ec57d04a7745a560821b45280
Message-Id: <164763233944.31275.5322423816376845710.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Mar 2022 19:38:59 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Mar 2022 13:50:16 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cced5148a1303a2ec57d04a7745a560821b45280

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
