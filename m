Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44D15607AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiF2RsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiF2RsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:48:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4B611C3C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:48:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q6so33999743eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=sikhifeguM4ffT8b3q2AAA4YOa4F7ZoLxP0wUvhq6/g=;
        b=wmemF2kISMpdcc58JqukhQYHNzP+s7FHmT03Uv/WkL1lm9/TnlXYpnt9Ghat7q+t26
         Ir3UyfOTBkNLMKbg/0SztdMRSfODpBLzH7arlnBx2z4sZLhCbAchzPzfmQPPwm+d73/J
         Pizmu8v8i85FND872tmc2Y1ny2tlnB4LfQo3Czrwx/b8PE5TBhjDm4mi/tzk+tfuXM9s
         lpeGD6+kvZHpCya+UJ7J3V+dk2mjmsMi/1KdkbxmrAmFDfTMigB3ApMZ22/8YxUDnEZv
         zkvK2TDJn3adF4uCuPh33cxxF/LeB1FamNhlx85Mp8uYE2U68o9jfk+iMtc8lXD7kraL
         BN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sikhifeguM4ffT8b3q2AAA4YOa4F7ZoLxP0wUvhq6/g=;
        b=aox3ZGCxgqytv7bEyhZ/76ZLqmuwyHzgGzBmLOTJACeL1eIlUR/PSJcla0+iEwM44d
         g3aSPOAlCjAPryl7fP3SsQheRKxEtB2OeOoi/NQVHX8gY9c3r256AhQu8kazG+CUOjPi
         yapW5DH7DTY48Tj8AfZ5nnLB/B6X91wFuDccROGwBvmabQbmFEajy3rn8okUiE4fUEka
         gMzbYuntuzPo7Xi9BVJSLbrlJ0pScTCVKHAeRC2Sas9fDnyjbwRZ3qPuD270x1JRis6+
         e48WXmrC5RJhht9nxQaiQIHuS1qmY2GCyiGt51vy/k6UllGk9Gv+chFK48SreWToX5qz
         aDzQ==
X-Gm-Message-State: AJIora/uJsVVt4/azjOsYprLBteMbH/D2bxRt8xoJISh0CNGbikbgR2t
        ssEfMZyKpiZ4KzHNbYOgw/JgZA==
X-Google-Smtp-Source: AGRyM1trKjyrZm3TCGY63mfEZIhc+tkObQ9Pl2m1fVlhR+iabfH3Q+7yMBjnp58xANwGQ29L43bHLg==
X-Received: by 2002:a17:906:9c84:b0:6e0:7c75:6f01 with SMTP id fj4-20020a1709069c8400b006e07c756f01mr4552991ejc.103.1656524891488;
        Wed, 29 Jun 2022 10:48:11 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm2230990ejx.173.2022.06.29.10.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:48:10 -0700 (PDT)
Message-ID: <f559cb30-7820-bcb7-0d34-c8b32c1ee889@linaro.org>
Date:   Wed, 29 Jun 2022 19:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 01/14] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-2-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629164414.301813-2-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'clock' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  .../bindings/clock/fsl,scu-clk.yaml           | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
