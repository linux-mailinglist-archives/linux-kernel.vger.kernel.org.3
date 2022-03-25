Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBAE4E7CA4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiCYTci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiCYTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:32:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314FA213508;
        Fri, 25 Mar 2022 12:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D4CAB829A6;
        Fri, 25 Mar 2022 19:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BD04C340EE;
        Fri, 25 Mar 2022 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648235218;
        bh=X08yVSMd8t7AOB7xu0DRbRp3VD4q5j0IOg81yugkmus=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ribhI93LiCbFDJToqS0/f/KZSaIO+A8Yh4ofBnGCC0TLaZO/jUz1fgaVGaoaJaFOX
         jjfdCvKCG93Dd889dyTXGXtJQpthts7ZkgAn+rdoq5Y0+CJlRQGnYjrqYd2gt9Dd5+
         4thGoMcBYUeT3Xvcd7XWVFArwSobjUBzawgft3Sr6GLcPHPXCjVOkdcu6IMoBW+KfD
         Ysa7UUbJTh06yYVwJ4avPbA7Z5HWPlJjjTWBI0zfSaUXlXTORd2YH5QQU3FVZ2ADkK
         wSyLlBSu1AsdyQGRvnMc4zxDQn8O0ysZtcRmtE8MKHrAdDxgRDP1amBF4Rb2qQ5Cs5
         0kwzKpMTo8uUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08FD2E6BBCA;
        Fri, 25 Mar 2022 19:06:58 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild -std=gnu11 updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQ2HET1QHG17m1vdCGMoRm6Lj=sAe+cj2Via_LHx3xBPg@mail.gmail.com>
References: <CAK7LNAQ2HET1QHG17m1vdCGMoRm6Lj=sAe+cj2Via_LHx3xBPg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQ2HET1QHG17m1vdCGMoRm6Lj=sAe+cj2Via_LHx3xBPg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild-gnu11-v5.18
X-PR-Tracked-Commit-Id: 1e24078113ae69c741cb1b03375a9f1490db7308
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50560ce6a0bdab2fc37384c52aa02c7043909d2c
Message-Id: <164823521802.3609.14455240159425041368.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 19:06:58 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 11:37:37 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild-gnu11-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50560ce6a0bdab2fc37384c52aa02c7043909d2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
