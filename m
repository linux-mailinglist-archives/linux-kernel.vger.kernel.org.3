Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC375421AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiFHFrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiFHFnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:43:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C19EC307
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2370B8251F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57A8EC3411F;
        Wed,  8 Jun 2022 03:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654658145;
        bh=leK06H80kByDZXtFvXFQDglOtMTwPv2t5xCgjZEd8cc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b5GO23W08T/jJK9C2nta5CfhV4ce2Z3JsMapEpDAGjD9a5bZtWSG1A8p+8T9un5lp
         fC1BUjNJO0dwnDgjOD+fTxYK1V/u00TPbVw7xcTtjBwbLH4HUtXxewFj5WzQYqollv
         zpVIyH/wRAhiOZxO1jQUEXfJpnzDFuPSFLL1nj3karVQaPvubAzbz0qUdI6EOWvH37
         51uYbo+6YvkLSc3X8EVxME2IGtHS6b4WkDdzWJ4VwhXx2FAJ96zToCEkqyaMjdXW5x
         gwuRWMujSRE6j/EZHVljdCmlsBCJ2N3XRO8nTssTnhvymYQWxoe4ldry50mn+iymRn
         xNm1T9gYhcZ1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 365DFE737EF;
        Wed,  8 Jun 2022 03:15:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cros_ec_commands: Fix syntax errors in comments
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165465814521.21771.12120211112670021219.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Jun 2022 03:15:45 +0000
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

This patch was applied to chrome-platform/linux.git (for-next)
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


