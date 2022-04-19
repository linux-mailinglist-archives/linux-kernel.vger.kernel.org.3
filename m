Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C24650629C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346718AbiDSDc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbiDSDcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A313D15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 20:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C8B60FC5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 369B8C385A8;
        Tue, 19 Apr 2022 03:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650339012;
        bh=r//ufWO4fvNfizfxS4vuRz+uxWC37f5ihVH/4Y4xBAE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xtc7k0+NbNf3WdkIynN4Xt+VJBtCOe1o+m2nWwP8M2VnfPZzVcxMhVLerZcThCfNs
         h0uU9ti6oALFYdH5rbIpKFSECHSK7DuY5od+77aHaKAbmeWnZW6tizpEdzL4Ldeo7m
         CPiT0iC7L5CW1vmFMvbtwNu0Hc6j1fdM3iIg7rqWBja9HugFgCtuQec9xAvFjufzjo
         zt0aAWGKsgzo+NIP8JSqytPU2wTG6mL9uQPXFURnTEge9Q110En38IqtPWVuWkYQQw
         xVnUKILVrXdunYHe+ZfQ9Z/zM3shej1+9zDrQVvT2sUDwQm61N/HQ1tn/sQpRglGMa
         OHx7ke62GwOgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16B7AE8DD61;
        Tue, 19 Apr 2022 03:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: Re-introduce cros_ec_cmd_xfer and use it
 for ioctls
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165033901208.10174.13978945686641197234.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 03:30:12 +0000
References: <20220318165422.686848-1-linux@roeck-us.net>
In-Reply-To: <20220318165422.686848-1-linux@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     bleung@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, dnojiri@chromium.org,
        robbarnes@google.com, rajatja@google.com, briannorris@chromium.org,
        parthmalkan@google.com
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri, 18 Mar 2022 09:54:22 -0700 you wrote:
> Commit 413dda8f2c6f ("platform/chrome: cros_ec_chardev: Use
> cros_ec_cmd_xfer_status helper") inadvertendly changed the userspace ABI.
> Previously, cros_ec ioctls would only report errors if the EC communication
> failed, and otherwise return success and the result of the EC
> communication. An EC command execution failure was reported in the EC
> response field. The above mentioned commit changed this behavior, and the
> ioctl itself would fail. This breaks userspace commands trying to analyze
> the EC command execution error since the actual EC command response is no
> longer reported to userspace.
> 
> [...]

Here is the summary with links:
  - [v2] platform/chrome: Re-introduce cros_ec_cmd_xfer and use it for ioctls
    https://git.kernel.org/chrome-platform/c/57b888ca2541

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


