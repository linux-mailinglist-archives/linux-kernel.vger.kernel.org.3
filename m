Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08444F1BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381888AbiDDVYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379506AbiDDRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:18:12 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0E13F77;
        Mon,  4 Apr 2022 10:16:13 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nbQJC-0002Kh-2L; Mon, 04 Apr 2022 19:16:06 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        patchwork-bot+chrome-platform@kernel.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, bleung@chromium.org,
        groeck@chromium.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/4] mfd/pwm: dt-bindings: google,cros-ec: include generic pwm schema
Date:   Mon, 04 Apr 2022 19:16:03 +0200
Message-ID: <2259298.ElGaqSPkdT@diego>
In-Reply-To: <164909246180.14329.3397709419938843373.git-patchwork-notify@kernel.org>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com> <164909246180.14329.3397709419938843373.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. April 2022, 19:14:21 CEST schrieb patchwork-bot+chrome-platform@kernel.org:
> Hello:
> 
> This series was applied to chrome-platform/linux.git (for-next)
> by Heiko Stuebner <heiko@sntech.de>:

does someone know what goes on here?

I did apply only patch4 back in feburary and I definitly don't have any
access to a chrome-platform tree ;-)


Heiko

> On Mon, 14 Feb 2022 09:19:12 +0100 you wrote:
> > Hi,
> > 
> > DTS patches are independent. Not tested, but I really hope no downstream kernel
> > depends on pwm node naming... If it does, please change it to compatible. :)
> > 
> > Best regards,
> > Krzysztof
> > 
> > [...]
> 
> Here is the summary with links:
>   - [1/4] dt-bindings: pwm: google,cros-ec: include generic pwm schema
>     https://git.kernel.org/chrome-platform/c/6b94ee669e8a
>   - [2/4] arm64: dts: mt8183: align Google CROS EC PWM node name with dtschema
>     (no matching commit)
>   - [3/4] arm64: dts: qcom: align Google CROS EC PWM node name with dtschema
>     https://git.kernel.org/chrome-platform/c/1e49defb8636
>   - [4/4] arm64: dts: rk3399: align Google CROS EC PWM node name with dtschema
>     https://git.kernel.org/chrome-platform/c/a0024f55eb5b
> 
> You are awesome, thank you!
> 




