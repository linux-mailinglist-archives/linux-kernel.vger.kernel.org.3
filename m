Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1D14E7CE4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiCYWCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiCYWCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58023131F4D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA4F561231
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 22:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B450C2BBE4;
        Fri, 25 Mar 2022 22:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648245641;
        bh=4lwv51i7kdnJVIUkgE5H5qVu88oykl0a4+bTXHd5MQE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZlSTxaALhW3K1mDIw6J4mpzyH/Z9q+4U0qiBJ2ISvQddet9/4/VJg5/ZN1pd+fmEB
         aSd+gPUsEi9nmArnydmprgck9CdjrrJN+yz90W8L3777DzqSsLg7kT5xIsaUm+rssN
         6czbJHOj/DPqwi0aHXw2zPDApOWkIZkuhHq0IgytdFFuO8YPI7YvSWOfVWk2YqhumU
         dyLGhkupAj53mTenEuvDlWvE6qBG5ppvXapKNWCAbo3wiL2VHG61nz4mzyhcYYtgXt
         +UX9WVfRjJgK5DbuZtxgpMLh0PQf1FkMQlSo+F0S9XsoPP8+EfDzUAULaXzzdU9924
         SCc4fLl004rhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48877E6BBCA;
        Fri, 25 Mar 2022 22:00:41 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty8CYpuQ05BjgB9_CBRUjiL5PMTF-irHRXKOWtOrgxxZA@mail.gmail.com>
References: <CAPM=9ty8CYpuQ05BjgB9_CBRUjiL5PMTF-irHRXKOWtOrgxxZA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9ty8CYpuQ05BjgB9_CBRUjiL5PMTF-irHRXKOWtOrgxxZA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-03-25
X-PR-Tracked-Commit-Id: 2a81dba4b577099717cea86d429f053e85e74d96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb7cbaae7fd9cee64f19cdfd89d097d807b884f5
Message-Id: <164824564128.5018.4392403227348156976.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 22:00:41 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 12:13:20 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-03-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb7cbaae7fd9cee64f19cdfd89d097d807b884f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
