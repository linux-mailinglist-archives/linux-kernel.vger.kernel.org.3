Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DBA560807
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiF2R5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiF2R5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:57:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4438BC5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:57:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e40so23304125eda.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=T9Yk42NUx/MUY1DZAib6F0ViLRokZ/a41TvQe0kWdP4=;
        b=bZGQ+PT2IEAXll5w9dKNVo+xwFIadVsQwP4mPenKcpxRPckz+DkuSGS07cVZ4Ky3da
         xyOzlwLNQ8rk2i1DYGcmO5ufpqwPxs6oBI9umCtD0EELukpzT8/ZZGedDcP8dKbJEUBy
         6btkeumLsawOSMsouc7yGsLOZ0XurlSzhtDS08Pr3NRP9+Vufd+q69l6MLrhHNTP0QYO
         bBYlmpEN8lKmz530dXwgJGN90pu6N2HVRXl76+CgQDkXn9dLGMiGzcWHrVGLvMfuxksi
         j0xgTQLMVOvfkfCKT02hJTmw1YILvlq/EYFxPLr2UemI4BD1U1JqkkS0PE+J6Rnk9hUt
         GH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T9Yk42NUx/MUY1DZAib6F0ViLRokZ/a41TvQe0kWdP4=;
        b=6oSpyc3VFoy/R6wf4f9FcyI6H7oVlYQIhqPujUeWxhBfZyttjDUp2CabuHJWPhtoF8
         GvJu8Bq3a+U5wQQWYBDAguh4mZp6/I2lniwS86dlXDwTgZ2lNYldQJdYLppSd160u+pd
         DpaAIRuqWnHilTz2mRxPsLQcTlo9jQxzxjIilwcJCCS/qfFV86G1LU4iRtQh+H1+Xjdg
         ViiUixduHaPfBCPTphkG/CcMEuutkEUCYHi96b/z+IFmKZX/QMk6IdDsAQ+Dmzuq3meo
         HgYlwZ5RtmznpLAJgdXrRdUmeWbNJqG7F1Wz015eD1q53M3qFa5rOt38Ielhdwhhp1Va
         es4w==
X-Gm-Message-State: AJIora+SXlRHUopW9qg7HC9rrK7H88j8YCcJb90cVVlcZ9nVcfSEjzoH
        l+uwMjfUXL8QRLDuZiQil01ZIA==
X-Google-Smtp-Source: AGRyM1ttHQmSRv3obVLH5G+Up+jZjSldhz+fp757LYwAZjBqrotFQa2jBpRMngfGbbHSV/vTSkpI2Q==
X-Received: by 2002:a05:6402:3907:b0:431:6776:64e7 with SMTP id fe7-20020a056402390700b00431677664e7mr5936886edb.0.1656525439814;
        Wed, 29 Jun 2022 10:57:19 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lj20-20020a170906f9d400b00722e771007fsm7934176ejb.37.2022.06.29.10.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:57:19 -0700 (PDT)
Message-ID: <efd0f383-c232-e58e-12b8-2e6ee9d9d287@linaro.org>
Date:   Wed, 29 Jun 2022 19:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 05/14] dt-bindings: power: Add fsl,scu-pd yaml file
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
 <20220629164414.301813-6-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629164414.301813-6-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
> separately the 'power controller' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---

Assuming all patches are taken independently:



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
