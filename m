Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9552358ED70
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiHJNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiHJNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:35:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A0422F4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:35:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l22so17788378wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:from:to:cc;
        bh=J1VWGzexY5E6UsX9vQ6bQ6ebcpD459VexpuSjd0X1xk=;
        b=vheOj5OqXAuJQuxThF4rG1C5oUbDBkg0eqaP81N1/zP/d2jZa9v1ALY9/A2MUhuEw9
         smJunFTKU1AjT2aJIV80QHIj44qIjzbF8BiwJdd9175ExWaVpB2pQMQgB8P3sVxRoyyx
         F2QHG8UKw3o9mEzmLhxDu40YuNFpnUMlTgd0wTwAuKQS5VftwnWN2itTX5Hlyztm1Da2
         QDtIIhHm6SWFzmnEw+ab+XdPgrEo8qti39g1Uqje0M0IihYpePyJCqAgHrVQYLqT4iAa
         iAQvZ6Mnj4DjnEcBRkd5Qjs2LZ9DlwccP2qwZLY04iUhgjojRWRH+4UYOf8Qm2Z1eUuG
         g6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:x-gm-message-state:from:to:cc;
        bh=J1VWGzexY5E6UsX9vQ6bQ6ebcpD459VexpuSjd0X1xk=;
        b=tuDQpZBPkOzsLT8QC7j5xz9EV6GnjqZEnUcUGIbmrPWGuOY7PyjypieFOL0LaZjZ2H
         VSlldEUpS9ZwTSP/tJQ4kNYZ9MMSxrRiYJecBUMwHpQuowboGZvkjJrpHQiFzbonE+oy
         C4olM29l560lwnvBXriSnCbWjAwTLQtXYj17tWtv11V8IBLwqLkVmeFpnlJPBxkmKqbc
         4ZkOX2owwgCLcdSuPy0uLNEZmEp0AZHUsIWSTVFZ4VaPgOJHw0PQzvU0eRhUAgJPm0j8
         q2ED5pPiKJI6DZ69omQf65K9cAMFXFFeOllg3tQGr2VRbRRau0lK8DEEi861tuGUORzB
         irbg==
X-Gm-Message-State: ACgBeo30mpWuNhiPo9FLaPCkYD6Vd6TcOSJwffTtcdGztUqWTxm/Diif
        /65nC+zB6wZvJcxF65Qr9FxKug==
X-Google-Smtp-Source: AA6agR7NHyGKRqIxWGpE5gY+PnqJiMudQi/uUaPx51qSYupKoqvqy+xNZdCloeF+K4jcJJQZh2S9sA==
X-Received: by 2002:a5d:5a1a:0:b0:21f:a9b:62c6 with SMTP id bq26-20020a5d5a1a000000b0021f0a9b62c6mr16898673wrb.20.1660138531570;
        Wed, 10 Aug 2022 06:35:31 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05600c1f1a00b003a2ed2a40e4sm89768wmb.17.2022.08.10.06.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:35:30 -0700 (PDT)
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-3-yu.tu@amlogic.com>
 <19654574-bdc0-9fa5-6465-fc88b20e20c5@linaro.org>
 <c223a85a-b76e-0e82-9a8c-6b60588dc03a@amlogic.com>
User-agent: mu4e 1.8.7; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 2/6] arm64: dts: meson: add S4 Soc PLL clock
 controller in DT
Date:   Wed, 10 Aug 2022 15:32:08 +0200
In-reply-to: <c223a85a-b76e-0e82-9a8c-6b60588dc03a@amlogic.com>
Message-ID: <1jmtccz0f4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 05 Aug 2022 at 17:39, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Krzysztof,
>     Thank you for your reply.
>
> On 2022/8/5 17:16, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>> On 05/08/2022 10:57, Yu Tu wrote:
>>> Added information about the S4 SOC PLL Clock controller in DT.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> ---
>>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>> index ff213618a598..a816b1f7694b 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>> @@ -92,6 +92,14 @@ apb4: apb4@fe000000 {
>>>   			#size-cells = <2>;
>>>   			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>>   +			clkc_pll: pll-clock-controller@8000 {
>> Node names should be generic - clock-controller.
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>> 
> I will change to clkc_pll: clock-controller@8000, in next version.

Same comment applies to the binding doc.

Also it would be nice to split this in two series.
Bindings and drivers in one, arm64 dt in the other. These changes goes
in through different trees.

>> Best regards,
>> Krzysztof
>> .

