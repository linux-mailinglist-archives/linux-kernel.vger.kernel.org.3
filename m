Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6494B558F80
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 06:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiFXEKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFXEKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2487C6808D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98BB620D1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF3BBC3411C;
        Fri, 24 Jun 2022 04:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656043812;
        bh=EBu6ckTNMwf8gEEouQT4wC2duA1lPbCyWbx4zFfY/r0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ikkV4lslhZAj1J8yHf7RZWuaGNqvg96EGWo61Fa8b605AQJww8caRpbZynV5q1kHk
         mUoikyfjx3JDLHtgcoc8Us9bZ5P65q7KZqodmMU3AL2HcrHBAVeWiAyh3QXn+I3/HA
         hDQwc+EPuENHsgp/1oWkplqLjgfNfnBM+E+sgH1Iu3bKG1CXhuwcXuAPF53P6UY5f6
         w5IkWg9vVgjnRHqwe7BsHJpMaRxhmXRy/Pw+A5/gZNd1C6DJVYclHIzP1+oKwCRbG3
         9q50nicEY9SdrDLjVztaCvkZND0qEcfw4lMqF1kZObdXuNYYi8vrOyOwgcD3+Rt474
         /M6+gQi7CRZIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B41FCE737F0;
        Fri, 24 Jun 2022 04:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: wilco_ec: event: Fix typo in comment
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165604381273.31124.6187796699911998153.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Jun 2022 04:10:12 +0000
References: <20220622061442.18242-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220622061442.18242-1-jiangjian@cdjrlc.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     bleung@chromium.org, chrome-platform@lists.linux.dev,
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 22 Jun 2022 14:14:42 +0800 you wrote:
> Drop the redundant word 'the'.
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/platform/chrome/wilco_ec/event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - platform/chrome: wilco_ec: event: Fix typo in comment
    https://git.kernel.org/chrome-platform/c/3de7203115af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


