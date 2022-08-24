Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4459F16E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiHXCk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHXCkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8912D0D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DCFE617BD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5566AC433D7;
        Wed, 24 Aug 2022 02:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661308816;
        bh=52MZOkm07TCkBgngg1oPe807uYfaw3XtfF+tEMXzO5I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gigGPj4wtyE6qxWJf+vjL5LorGsYR5bSeJEp2do+3GfIvdkeyCFW8CBJm8LADnovS
         rspUlj+0IFtTue56eh7SXrRgbppS4KGMstkDqWsQWYD6n+evPfm56LrIjkRZXTukMl
         kGjZEya1jwrL7rbszuNQV0v6vA7Ai3CzMw9xAyxeN2xsYMc/LcYo8k/7GuhhatPfxv
         OrzJCg63eYbBM4QzXdoRMQOEVKTAhVrmb13U52eun3G8bf899CsB+0y5WxlaCzCRDX
         UjB6jTTKqAJnazY4tWLNjqBJ0NOOEqbJhxCBfwVw5ZwUoBLH7v8DZq84yPTncqUaiX
         HRyJ46mDnxpeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AA0BE2A03B;
        Wed, 24 Aug 2022 02:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Expose suspend_timeout_ms in
 debugfs
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166130881623.3545.15339051847364813207.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Aug 2022 02:40:16 +0000
References: <20220822144026.v3.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
In-Reply-To: <20220822144026.v3.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
To:     Evan Green <evgreen@chromium.org>
Cc:     enric.balletbo@collabora.com, rajatja@chromium.org,
        tzungbi@kernel.org, pmalani@chromium.org, bleung@chromium.org,
        groeck@chromium.org, swboyd@chromium.org,
        tinghan.shen@mediatek.com, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 22 Aug 2022 14:40:40 -0700 you wrote:
> In modern Chromebooks, the embedded controller has a mechanism where
> it will watch a hardware-controlled line that toggles in suspend, and
> wake the system up if an expected sleep transition didn't occur. This
> can be very useful for detecting power management issues where the
> system appears to suspend, but doesn't actually reach its lowest
> expected power states.
> 
> [...]

Here is the summary with links:
  - [v3] platform/chrome: cros_ec: Expose suspend_timeout_ms in debugfs
    https://git.kernel.org/chrome-platform/c/e8bf17d58a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


