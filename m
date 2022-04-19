Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0317E50629B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbiDSDc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346676AbiDSDcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:32:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6BC13D16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 20:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22B2660FC6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81D95C385A7;
        Tue, 19 Apr 2022 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650339013;
        bh=21CBbwpI9yRTaLJ2TyxV5OxxAzfXsUtVmBkixNOLo8g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=B/XFTcI7znLKhiAkcbTY6X+9T7eh31Loir3fsXrLdvOT2sYywBE53Z+dFJjhqqspz
         LpWiC4Mjd2YIJpAbwlgXXyqS5PQzo0UraRn49Eezfw2NaTYdd6bc3e/Iyhz2oLLkBf
         11x5ErJ94irM92ukeylYrMrbcam9hOdCb2Ow5954ziLhKgRiZSCI6YxTtz1s1DubAV
         GWfwVSjXQTvf31Ffu0Vdh9/Qr10p8wSO1XYdyhEEJLEID0vmBYhk7sQM3c3MnFHXPf
         7OQf1xVMKxauqZvRSnKzZEKSIKge6d4WnKfTSxcTjLY7UPyLjT5euyT6NCL02G4r5+
         Q9ASXICsHPK4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D0ACEAC09C;
        Tue, 19 Apr 2022 03:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/5] platform/chrome: cros_ec: miscellaneous cleanups
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165033901344.10174.596989152159519892.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 03:30:13 +0000
References: <20220216080306.3864163-1-tzungbi@google.com>
In-Reply-To: <20220216080306.3864163-1-tzungbi@google.com>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, pmalani@chromium.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 16 Feb 2022 16:03:01 +0800 you wrote:
> The 1st patch fixes unhandled undos in error handling path.
> 
> The rest of patches cleans drivers/platform/chrome/cros_ec.c.
> 
> Changes from v4:
> (https://patchwork.kernel.org/project/chrome-platform/cover/20220216043639.3839185-1-tzungbi@google.com/)
> - Rollback the 3rd patch to older version.
> 
> [...]

Here is the summary with links:
  - [v5,1/5] platform/chrome: cros_ec: fix error handling in cros_ec_register()
    https://git.kernel.org/chrome-platform/c/2cd01bd6b117
  - [v5,2/5] platform/chrome: cros_ec: remove unused variable `was_wake_device`
    https://git.kernel.org/chrome-platform/c/f47a6113f4e8
  - [v5,3/5] platform/chrome: cros_ec: determine `wake_enabled` in cros_ec_suspend()
    https://git.kernel.org/chrome-platform/c/9fbe967d4e6e
  - [v5,4/5] platform/chrome: cros_ec: sort header inclusion alphabetically
    https://git.kernel.org/chrome-platform/c/5781a33098c6
  - [v5,5/5] platform/chrome: cros_ec: append newline to all logs
    https://git.kernel.org/chrome-platform/c/8d4668064cce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


