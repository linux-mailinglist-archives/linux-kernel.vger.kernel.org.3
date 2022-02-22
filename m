Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885D04C0556
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiBVX1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbiBVX1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:27:49 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D4292D01;
        Tue, 22 Feb 2022 15:27:22 -0800 (PST)
Received: from [185.156.123.69] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nMeYp-0006wl-RD; Wed, 23 Feb 2022 00:27:11 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-mediatek@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-msm@vger.kernel.org, chrome-platform@lists.linux.dev,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: (subset) [PATCH 0/4] mfd/pwm: dt-bindings: google, cros-ec: include generic pwm schema
Date:   Wed, 23 Feb 2022 00:27:08 +0100
Message-Id: <164557235424.1264579.14486504733557463529.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 09:19:12 +0100, Krzysztof Kozlowski wrote:
> DTS patches are independent. Not tested, but I really hope no downstream kernel
> depends on pwm node naming... If it does, please change it to compatible. :)
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (4):
>   dt-bindings: pwm: google,cros-ec: include generic pwm schema
>   arm64: dts: mt8183: align Google CROS EC PWM node name with dtschema
>   arm64: dts: qcom: align Google CROS EC PWM node name with dtschema
>   arm64: dts: rk3399: align Google CROS EC PWM node name with dtschema
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: rk3399: align Google CROS EC PWM node name with dtschema
      commit: 474a84be692d893f45a54b405dcbc137cbf77949

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
