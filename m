Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054F0588604
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiHCDXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiHCDXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA464F64A;
        Tue,  2 Aug 2022 20:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5D861260;
        Wed,  3 Aug 2022 03:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 832BDC4347C;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659497001;
        bh=VAX3o2tqqQ/Lc6mqVqs+rQqswUZlT391CIHJezobAPE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U4EiMBVug8lu19HXVDC5X06WWLE/TvV//WH3sGdbaNPhCv/UiQ39rjyolvYYmtUiQ
         yZ72qu8hyrUZJN5gvzCdEUua/S4VbP6y4Ngk7W/8yXe4N98w/k/eOY6Vh5yVMTCRaB
         QmyOXo5D/4bKImBtoEA69ZLf+38/CivQrKvcg3pCZOEIVPVV+ltyrO8MTdOQ9q87lq
         tOyQxQVFZu83Urr9c73ax4fy5OEnr6rrOu0frXevVP5ccpoa8tUKZLsJDCsFx8QzHj
         mEwzEOyVOJQFBV/H/NuaJTqPc6v7vC44+/DzG/f/epESPmtFI9Gr594MxEyCF8cFIc
         z51yyT1GC+pWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72376C43142;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
Subject: Re: [GIT PULL] flexible-array transformations in UAPI for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yug4IJHugXBzPWFH@work>
References: <Yug4IJHugXBzPWFH@work>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yug4IJHugXBzPWFH@work>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-transformations-UAPI-6.0-rc1
X-PR-Tracked-Commit-Id: 94dfc73e7cf4a31da66b8843f0b9283ddd6b8381
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2b542100719a93f8cdf6d90185410d38a57a4c1
Message-Id: <165949700145.31205.9669792520884072712.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 03:23:21 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 15:31:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-transformations-UAPI-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2b542100719a93f8cdf6d90185410d38a57a4c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
