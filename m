Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF652536E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356937AbiELRUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356965AbiELRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32CF26AD96
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F40F6207F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8A58C34116;
        Thu, 12 May 2022 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652376015;
        bh=+7AtIdZR9osN4t5qyhi4RgNDEqKiuehscGpR7C12g9M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Yy+IEW+keTgP53+Wup42Fq4NvSlCd8SaASd7pyQ+sAnRZVDyXAJcpY5taGya6eh0n
         rM+gC2PaBAqC8l3u06r4iSRsoYJX+CLT+FM4tFre9xhzAB5at6NrYhtR0NX4CxEygw
         8OskA3qWhpcZ8abN+1WP58dPq2D9Og19Y5drh6HInXe0JKs8gB1MFxfG2JVCfbEIfy
         nGYnzw5vDk9GVwBLpT7iJQCiuluDffKbezuzzYAWNeLNIF+QNfQwTWHvQM8/8LSE27
         qHssxtmcfjM+5MEXs3oktPEIlmHrJS09l98mhPsNDDdlLoKcTSdrEYi6mSBaNmiNWJ
         YEt5kBZcvGCIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFBD1F03937;
        Thu, 12 May 2022 17:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165237601584.19682.12247816211484032812.git-patchwork-notify@kernel.org>
Date:   Thu, 12 May 2022 17:20:15 +0000
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
In-Reply-To: <20220404041101.6276-1-akihiko.odaki@gmail.com>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org
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

This patch was applied to chrome-platform/linux.git (for-next)
by Prashant Malani <pmalani@chromium.org>:

On Mon,  4 Apr 2022 13:11:01 +0900 you wrote:
> The EC driver may not be initialized when cros_typec_probe is called,
> particulary when CONFIG_CROS_EC_CHARDEV=m.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - platform/chrome: cros_ec_typec: Check for EC driver
    https://git.kernel.org/chrome-platform/c/7464ff8bf2d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


