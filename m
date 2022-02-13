Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6EE4B3D5A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbiBMUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:18:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiBMUSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:18:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70761532DE;
        Sun, 13 Feb 2022 12:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 031A1B80B77;
        Sun, 13 Feb 2022 20:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ED68C004E1;
        Sun, 13 Feb 2022 20:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644783496;
        bh=7hU+gwrxzqlvxtOdJD4IdQ7tbL/g0b8m6As3/UyYcTo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hscTaI/HW9K6MVBiaMCkBPHsKAdYSurF3R5/t7oU441VvEVMcJKOSoGJ31gydp0BS
         j7XLbBzL6X7bZnA0A0o4hZY+WfqfkQ3LnqjpZ3LwvUeelxLdSuPMpaz+BeWcQ2yuaK
         uNc/oH9oMYqWZ94nOQDqPJkfMEI8Js9xvd2PD7rjDqk2ao0wlWOzvBYzHIw2et8xfA
         oOSdtlJ7kb/eKDe9W6A+NUup6+6AgDKaCPwxtrW8BVZVzgFNM39NwyQPNP7fjSvivf
         xhVdv09L03WA9HeLjCZHhBH7ybpNDh7G+LOfIeEC4KhlpChI8jO6FkSUATy96FZCtj
         5f0sfFFDtFABQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81E15E5D07E;
        Sun, 13 Feb 2022 20:18:16 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARgx5NDHT0RdLpogXRQadn8cZYw=D_kQ1jpC0ftJH1eyw@mail.gmail.com>
References: <CAK7LNARgx5NDHT0RdLpogXRQadn8cZYw=D_kQ1jpC0ftJH1eyw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARgx5NDHT0RdLpogXRQadn8cZYw=D_kQ1jpC0ftJH1eyw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.17-2
X-PR-Tracked-Commit-Id: 1b9e740a81f91ae338b29ed70455719804957b80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e89d3a46710908c3973397849e758f6ca42db77d
Message-Id: <164478349649.4450.10325352856863813887.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Feb 2022 20:18:16 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Feb 2022 01:53:00 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e89d3a46710908c3973397849e758f6ca42db77d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
