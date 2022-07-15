Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4596576707
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiGOTAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGOTAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EFE4C628
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C00016234D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 19:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2551EC341CD;
        Fri, 15 Jul 2022 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657911615;
        bh=bV6fjVH3Ww1z+2h4N07V4RdxlTmKgMBZ9vWZar4eZSE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IMro5uied36+7P991NTGMehlq0zfI/V967gNZN4A2RcX8FKt7nGA2yIzsmjsD5btT
         HTRezDKkS2gcjLFZKkGsFO16HgA3bErGCxxN6a9cKgXqhV3jV0g3SOnt5IQO4p2VD2
         RqnfdJ+38dyYw+uKNwlcH/AqLl5B0R3vWjk0JO51LTI/46RQwKIow9mlcKySLwDJix
         J4/ngjePdH0no7WZYGgqUDhOMuFxHEj/1c4dFA74mHeQ3B4XIUBJGWsqWuDqU8u7F9
         OS88SOcTXWEDymaR1Ip9oODq+x00FOBec2YQGbWKKnzPlao6F7Skdw60EdchSAI+7K
         pkIoiwJCiVw0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3333E4522E;
        Fri, 15 Jul 2022 19:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Use dev_err_probe on port
 register fail
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165791161498.31351.5395252927709441391.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Jul 2022 19:00:14 +0000
References: <20220712214554.545035-1-nfraprado@collabora.com>
In-Reply-To: <20220712214554.545035-1-nfraprado@collabora.com>
To:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado_=3Cnfraprado=40collabora=2Ecom?=@ci.codeaurora.org,
        =?utf-8?q?=3E?=@ci.codeaurora.org
Cc:     pmalani@chromium.org, angelogioacchino.delregno@collabora.com,
        kernel@collabora.com, bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Prashant Malani <pmalani@chromium.org>:

On Tue, 12 Jul 2022 17:45:54 -0400 you wrote:
> The typec_register_port() can fail with EPROBE_DEFER if the endpoint
> node hasn't probed yet. In order to avoid spamming the log with errors
> in that case, log using dev_err_probe().
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_typec: Use dev_err_probe on port register fail
    https://git.kernel.org/chrome-platform/c/ce838f7dc795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


