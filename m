Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0763F5608A5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiF2SHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiF2SGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:06:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90623FDAD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:05:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g26so34162254ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=us3+4U/6NS+9bUTvamba37DRKpthQlGNNn2eGBCrdmM=;
        b=vbuaaFUYqN1guX3EHj2/BmchL8/O601kaBMJ0zDDI6+sG4DLOkANm8JNnernJAONbn
         UcgAZArlvEyfdDw8xg9VbPHyOM97a6LZp8E9RREWM5XoeuGB/KTfZJ9n0bjMew0vnDlz
         0TJMVQo419wctcCnxgz/i+1x35gC2NhWNe47DPYG18HC4B68XRZDi2BsZNKLm6g9x3bp
         SdJ/pxYX5ibbv7r3FHqaMpQy6AUKkij4SwdHtrT4jWHw31sN+v15qrI1BDfPGRIU1NxO
         pdlvlGsboJo5pc9j3Lh1Sk7lqtmPVbNfAkXegBcYWpI6DUgg8WTY68eizLe87jJM8kil
         dN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=us3+4U/6NS+9bUTvamba37DRKpthQlGNNn2eGBCrdmM=;
        b=Sk+M7SpInBBkphjoC1cjfMFpPrL0TQiBOAKoStfdrARcVM6k95BBRgFS0ClBshwVZT
         5oqqNZpbbtS2DYdc+2uW/sLsDsRTreyGBpANiPHgcJ2ONpOqx/Ax/O0DQE7nSP5Mq44m
         002tA1zIcc0RE9V/USKH6nxj0PhnMFw1yqiO4Ev6Ome8FegQHvcBopZ8SiAGcDpslQer
         fOro28mHCKpVVcbd7nInOCOqCT7rTA7ZQxHox7mgc+TSsBhcIaRoYczfAqpz16uK4Z4s
         pbKWWv1irJv0kvq/i2dy2F8+8/aiyUMJvAOc4ky1HYxeGb2B1DUjSucKq87vz6VONqic
         gtJQ==
X-Gm-Message-State: AJIora8xWPLCRuq3L3Z5LeOF71oCRfMYnrLiJil59sl+C57sWVxkZAFs
        5O2eVPz9rFNd3k8P7MQ/KCSAhg==
X-Google-Smtp-Source: AGRyM1sWMDnn3S+Hc1i9wxDUNunPqB3FVeRluJtNmaPIT8itwCMTAUqzlXg0BsktQka3qSLa83AIJg==
X-Received: by 2002:a17:906:7c0c:b0:6f9:1fc:ebf3 with SMTP id t12-20020a1709067c0c00b006f901fcebf3mr4455187ejo.403.1656525950438;
        Wed, 29 Jun 2022 11:05:50 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ml22-20020a170906cc1600b006febce7081bsm8018575ejb.163.2022.06.29.11.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:05:49 -0700 (PDT)
Message-ID: <1303740a-d975-54ec-1bfa-6f1f6a6dc391@linaro.org>
Date:   Wed, 29 Jun 2022 20:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 12/14] arm64: dts: freescale: imx8qxp: Add fallback
 compatible for clock controller
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
 <20220629164414.301813-13-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629164414.301813-13-viorel.suman@oss.nxp.com>
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
> Both i.MX8QM and i.MX8DXL use the fallback fsl,scu-clk compatible.
> They rely on the same driver generic part as the i.MX8QXP, so
> lets add it to i.MX8QXP too, for consitency.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
