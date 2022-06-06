Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9B53E055
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiFFEJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 00:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFFEJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 00:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F405D1B2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 21:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A86960EFE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 034DDC34119;
        Mon,  6 Jun 2022 04:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654488497;
        bh=9de3ED9fTrLfeyMFgQ/+0XCc1KjJhelXy5OTncsMzU8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nCm3rLdkUsLFugfxmgXvc10Bq0SzQQYEJBJQm9vYGd9DQOp9UebLx7YUg4O73o2v0
         yb+JmiZroOToN0MfNSRYOe5jhfJGR5dcmyZ6342CYuC2px5j/oOKMhJuhRcxPLrfEx
         HMwICHKQO/DSi2WFvtMkdL2DhCMnNLSa+IiN+NMo8WWXVVFw1Dn5/ksr8wcfZWU5KO
         hSSMiPg+/eDvP452I9adhfEb65UcpU8vrP7AwlVh7gLFTzLDFTy18UFil5wazhNA5w
         BXq4QNmKrw3ISsP8x7fxIuAsOAtbJlWQNu4ulGYmhdjjJqJlWJeV1s4qcr0ShFmowd
         jqfcwN7tTRlJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8614E737F0;
        Mon,  6 Jun 2022 04:08:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cros_ec_commands: Fix syntax errors in comments
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165448849687.12364.11116446168981626358.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Jun 2022 04:08:16 +0000
References: <20220606022313.22912-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220606022313.22912-1-wangxiang@cdjrlc.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     bleung@chromium.org, groeck@chromium.org, gustavoars@kernel.org,
        dustin@howett.net, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon,  6 Jun 2022 10:23:13 +0800 you wrote:
> Delete the redundant word 'using'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  include/linux/platform_data/cros_ec_commands.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - cros_ec_commands: Fix syntax errors in comments
    https://git.kernel.org/chrome-platform/c/8d5976089c97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


