Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FDD53213B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiEXCv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiEXCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBF9F5AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8573DB81721
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A62FC34117;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360675;
        bh=WtzYsEviENk4Kquq9B7O6ZfRTOEHUcDGIi25maB71eM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L989FB+wczmC1Yg+q6VVVFRZ9gO6pj/RqXWA8LYxoIoQmWfykIDOfnbT2msm9AEYp
         S3ku9OtZoBxi0kNA7wKkpI7pgfIuzLMVeSizOtSPfuciTE0VMS8kx3f47l52xEJy25
         1HWZiEn/fqsGdDw4oqVCD6Ux7MQcbeW9w76fpdZslZIIiZMnAHYRi4PZS9WpkMjTIV
         MPweOfUDuATssDAU2dzOQpla/Bxh6aO0E7g/LmVENiEaHcqmjBOwQIdi2btUV65zNq
         AKwx/Egdi9JUMSpKhNfreP/Equc+uHoTdEVTdhXTz1QB01p6z8W+CLv0hnvYGcaQ+/
         XghLGL6tYTjJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F28DF03938;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YottBBImBRUl5LQS@zn.tnic>
References: <YottBBImBRUl5LQS@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YottBBImBRUl5LQS@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.19_rc1
X-PR-Tracked-Commit-Id: fa619f5156cf1ee3773edc6d756be262c9ef35de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b828263b180c16037382e8ffddd0611a363aabe
Message-Id: <165336067518.14181.17406298095336298503.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:15 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 13:16:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b828263b180c16037382e8ffddd0611a363aabe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
