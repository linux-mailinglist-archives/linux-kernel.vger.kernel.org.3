Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E84F1BFF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379771AbiDDVU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379381AbiDDRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998A540A29;
        Mon,  4 Apr 2022 10:02:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0873760DBE;
        Mon,  4 Apr 2022 17:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51705C34110;
        Mon,  4 Apr 2022 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649091720;
        bh=04frVOBorwVRLC9iR0TJrmOXUmgPLE7sifjv285UBqY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u4wKiB3cMuSr8X85DCWSAFYjooVhda9cApTtmkp7tZRxtQTB+pgUau+XD8HAdu9co
         oxThbzXsle2iXHmd+iemZT0F0XHev26IPwYM4iI1hbroEUz17L+D8nm6vD0/CoCNIY
         J/21dCexLvUqK0WwftAOMKgJpGSwNk7nglnDRs06SRyKGXGlM3OTFjNFbnDAlA2Q/g
         WxrStf87q5tvCOcufEqKt9tTU4ATyPF2w4MTGfNeZBT5Ju1Na5o1C+nSOI4ojUtpe9
         Z1fpj/klB5G7TabOuiLNZF9qS0Hw4zFloxHqr5WmL1IjlaRcg2esfmHuVUGF94Rzuq
         tCqb83VI/qWcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AAA7E85B8C;
        Mon,  4 Apr 2022 17:02:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] mfd/pwm: dt-bindings: google,cros-ec: include generic pwm
 schema
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <164909172016.14329.4245687704208123308.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 17:02:00 +0000
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, bleung@chromium.org,
        groeck@chromium.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        agross@kernel.org, bjorn.andersson@linaro.org, heiko@sntech.de,
        dianders@chromium.org, devicetree@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
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

This series was applied to chrome-platform/linux.git (for-kernelci)
by Heiko Stuebner <heiko@sntech.de>:

On Mon, 14 Feb 2022 09:19:12 +0100 you wrote:
> Hi,
> 
> DTS patches are independent. Not tested, but I really hope no downstream kernel
> depends on pwm node naming... If it does, please change it to compatible. :)
> 
> Best regards,
> Krzysztof
> 
> [...]

Here is the summary with links:
  - [1/4] dt-bindings: pwm: google,cros-ec: include generic pwm schema
    https://git.kernel.org/chrome-platform/c/6b94ee669e8a
  - [2/4] arm64: dts: mt8183: align Google CROS EC PWM node name with dtschema
    (no matching commit)
  - [3/4] arm64: dts: qcom: align Google CROS EC PWM node name with dtschema
    https://git.kernel.org/chrome-platform/c/1e49defb8636
  - [4/4] arm64: dts: rk3399: align Google CROS EC PWM node name with dtschema
    https://git.kernel.org/chrome-platform/c/a0024f55eb5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


