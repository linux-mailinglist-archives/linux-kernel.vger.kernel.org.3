Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340AE5ABAA9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIBWH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiIBWHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C15FE053
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2955461C18
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 22:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC78C433C1;
        Fri,  2 Sep 2022 22:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662156436;
        bh=iNpb5npbEG7uwkUAyiim6o1IHE6SIZcL6Xy9bL8Krvg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xpq5Na3HlMRubINHxnK6F7V0hm6uRse8Dv2Qx8qJkGfCnafmRD+EpN4+V2s9giC58
         7TmhAi1L+2H0V9B6rseWFEbXydrCEWzbZOB6kzMQxBuBYRLHjlyrsBax7CzKtQFf4k
         Ep6L7wUlpc2emdYQZYeZo4RcTKZvx1ot8ZCDVvwhSicc71zUweH5ySAM2LIELhE3K7
         t0JTy5DVrigjyakZ7IJRV65mUB05DxNP6Va8MXoIkxFexcPj4u0EhMT5kp2Tsus0qe
         5ls3vRnPdPOfaCzH39AWMoUxMO/t49/Bm1eCRGgTiGKzy1MyS9xj19DwnTcp248eir
         z0SAC8QAb9l3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AAD5C395DB;
        Fri,  2 Sep 2022 22:07:16 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twhqKoDa84xNhsRmrfApyu206m+58-1yHnxLj=r3pxvag@mail.gmail.com>
References: <CAPM=9twhqKoDa84xNhsRmrfApyu206m+58-1yHnxLj=r3pxvag@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twhqKoDa84xNhsRmrfApyu206m+58-1yHnxLj=r3pxvag@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-02
X-PR-Tracked-Commit-Id: bfe632f6d0a1371784dd9a11fa5a9aa2dbf53bf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e8e515edd6dbe15b86003d846fee005c12c0685
Message-Id: <166215643649.30372.17824007577014953666.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Sep 2022 22:07:16 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Sep 2022 11:48:36 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e8e515edd6dbe15b86003d846fee005c12c0685

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
