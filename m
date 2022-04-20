Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345FC508654
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377836AbiDTKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377797AbiDTKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D1101FD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A84216185A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10D7CC385A8;
        Wed, 20 Apr 2022 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650451812;
        bh=lDXrcIhmwRkt0SoBQSq31ilCNPvYUV3Ka7JEeaJkBYQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b8P+jObYZqjxupBrlHKoHEx2qtERNAh5plgNRJggXSWWfBJwv2E3wzWKeUQZJRO83
         EKCMKgX6gQ+2Rhw087fg/MlKjfFBK0E4tJNVYxtfdM0qLGr5NUm8LhYg3gFKV6k7l0
         wdSkIYtILMtQ6VYjsAFxOoAuwHUzCbgQmUyuTJ+x4WGZVtiHsrx2uzIxMr3fxIrY8P
         fbnUe48fEBhAr8cwUF6ZC3jX/ixdwm+Dr2/afaoYx2O4WHJynktovsj+lCHh4R1HW0
         XcqNVOYT396n/636JeOF2Is36SvDMZls45fBwfwgTp15xCkFtYTI7sppFvhHKrWS/g
         bGsXTH4gJOOGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9F89E8DD85;
        Wed, 20 Apr 2022 10:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165045181194.29490.17184763637444609886.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Apr 2022 10:50:11 +0000
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
In-Reply-To: <20220404041101.6276-1-akihiko.odaki@gmail.com>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

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
    https://git.kernel.org/chrome-platform/c/cce465a867bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


