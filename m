Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4335608A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiF2SGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiF2SGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:06:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC53B40E7C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:05:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q6so34085641eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QSfgLXgFfiGaok0lJdcTWMoQDlToXF+BRlTaDwPiloE=;
        b=MeoRgOZVtDqrD1BXTHuzWUgHKg59UHeJcfZILwn01ko3si8mEmIRSF7PZGoMYFnpSe
         UPsJMrSHsVVgvuYWA0BkwQVKseCCL7fdZVk7qASBp2fBqik35D7ADK09VSAG4NXgTMMd
         Fn7MvZjStPJVT/IB0yqIlKwG2m8zdfi3lBLCMd2c70R/w3jeikg5+J0oxqeNIgv9J0SK
         FzEBOO4wjBzWSc18UAp+xZ6uusQZYAb7snw/6MCIznSFGO0tPrjNxAoB4fM4KMLT/8NI
         ohW/Jc+N5MWrwvDMCsUcl81gFhKH/4lI/zzm34r2TWSmE+LzbeEPWfJBwPsGyTN7jlEN
         XeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QSfgLXgFfiGaok0lJdcTWMoQDlToXF+BRlTaDwPiloE=;
        b=bDd4R54pw4De9Jm4geydKuKg0lekyVAyN1M8PFVA8gmD4MLrXX4N/ZGSuW/Zq9BGZW
         J9gUlabyggD35t4MQmbsE5XZmr/Tc6NfTsEwVUO8Z7vZOXwZ0+ynE3zfnceZIPqN3t8V
         tThIAq5kIQZHfRSHxdW4CJTPctVz4AWOAPLogZ1eD5VJWgz8uwdbhq9AGFJJeBsDdmTh
         w9eVtHBnVWotB/YmEGkO41Ft8D7hxN0h/0OKQUqrn+LVaz0lcELk0Auko49OjyJHHatg
         rdLZUcmVSdwabs1Xvi1Iy+HQpHtpGT/pIIGoyDMBehK7xIaVzeA/VRoBFjanbkFGSV4n
         S0Fw==
X-Gm-Message-State: AJIora/u47338+EGiT3Xar338DNYEguNs7418cjZaX1FtaaiFiI8tUKF
        C43xLow5hOT11BS8ihas1kUQfQ==
X-Google-Smtp-Source: AGRyM1uveF1FWSHXgBj8uURIFKTL+sgiRu8h6GV4IGO4002y0D6+mokBlHcmA5uQEoUy6sKdGRLgwg==
X-Received: by 2002:a17:907:3f82:b0:726:3732:961c with SMTP id hr2-20020a1709073f8200b007263732961cmr4751329ejc.727.1656525902194;
        Wed, 29 Jun 2022 11:05:02 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n6-20020a509346000000b004319b12371asm11957216eda.47.2022.06.29.11.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:05:01 -0700 (PDT)
Message-ID: <392186b6-d5cd-ec6a-ca98-c02a824eaa7c@linaro.org>
Date:   Wed, 29 Jun 2022 20:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 11/14] arm64: dts: freescale: imx8: Fix power
 controller name
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
 <20220629164414.301813-12-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629164414.301813-12-viorel.suman@oss.nxp.com>
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
> The proper name is power-controller, not imx8qx-pd.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
