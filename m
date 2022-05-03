Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDA519229
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbiECXMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiECXMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:12:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A441F8D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:08:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77135B82229
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D245C385A4;
        Tue,  3 May 2022 23:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651619319;
        bh=GBIMCUSgNdIJUa2GkWVTSa+wgRZRFee0CH1L3AKLHNk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KEKKNt0tn2O7jxMinqnm+4fSvhpIY7L0mwZPXNGSBf2h3kHsoELz4hUUThlDVjHNb
         03gcdCx7ToxxvmEXGBJWcY/UxlbDDZGtJg0ajx6+Wr3vWWfTOeYNQOVBGpJO9zNR2w
         6jGJKhldSa90D6Bcy/WAL+G6M1TgKyZIUUYu4L4u0WwsX4V7j8MpdtL7OBcw+jWvpK
         A2W26vC8MlIob9P9WM+C670Ch7ruCI+B1io+zCUlK3IfGJ3xEp5zMOxto3D96BWNp0
         wEayTKMvDAQC1Ev0dtQc4em64Rcc/7wBfuwVm5L5k34Wkq26t8TN7NM93O+M2Lf8RZ
         V9NWGzE79nO+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0732CE7399D;
        Tue,  3 May 2022 23:08:39 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp fix for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202205031433.6CB037ED@keescook>
References: <202205031433.6CB037ED@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202205031433.6CB037ED@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.18-rc6
X-PR-Tracked-Commit-Id: 2bfed7d2ffa5d86c462d3e2067f2832eaf8c04c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 107c948d1d3e61d10aee9d0f7c3d81bbee9842af
Message-Id: <165161931902.17317.3467560220121801055.pr-tracker-bot@kernel.org>
Date:   Tue, 03 May 2022 23:08:39 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 May 2022 14:34:07 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/107c948d1d3e61d10aee9d0f7c3d81bbee9842af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
