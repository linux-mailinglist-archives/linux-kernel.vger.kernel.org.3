Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC923560819
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiF2R73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiF2R7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:59:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E74D6C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:59:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so23237806edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=qLQoQNqzIX44NBq4eyXo8pb4zSiHlNiTFmIzQcS3Dno=;
        b=Mz1L28ohTu6cZ91xNTXSq6PQXSe7pEV86eueM3ccaMT7npnybQ7OsqG1zzkrZrtTjt
         YE9c+/tj9f5cATNFEOVPBbAqsw8RQ9FqxRQ055C8kabY1gNvzoLjKFoBMExzsgsZGBQs
         NMByrjLnhXz3SydxjsxGlhms159RezTVkwPw75noYwsyVgI69gnBHfbMsxoL487g9ooH
         Wcw/cX/cHNB89dZ7+9rmtLaYwoO/wVt012A7vW9Q0D2YDfdtYpUZPtP9McRMCBL40+DB
         is/IojyBhL5bugopD4xcTvondIPaL15gMOgS1WWrtAEDtgxH84bWShukCjqMwI64ug+q
         4NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qLQoQNqzIX44NBq4eyXo8pb4zSiHlNiTFmIzQcS3Dno=;
        b=YkLBemCc5B9pMlePXMZcUpL8ar3rqVbGa6qZs0nfA6Ab0uyOWM20mzntotkVIyasYV
         oyL5My6ePQs240zEWXtVHKOFc3HuwvBjwlI2ukdw9XEaTkrALAwvX5vcS8LOotyA16it
         hK694mCthjNtFLCoFrqwvpkq95neTOhM1Xd8iR1eYkyIauVp8ev1AOZjeuivlnxGK4W1
         VYlcU8Veh/V5CEXZyxKcXf8m/PcA6zWfGTEJcIM9N73GbyGPTDyjZzijqKJfDAPSdk8Z
         a9RuLAWGpCJxlXPs5mBQECB7Wh3ec8VAVWx/vf2emgE+Wk+XnFcSJ0OoA+bBxesvEbkR
         YEFQ==
X-Gm-Message-State: AJIora/MAQ8EcoykRjT+YNLD53kgflk4bc7KM/czuBk+DhmvEi63am0M
        PgS4QV+e1YmyVN+qtt+bdtSWJw==
X-Google-Smtp-Source: AGRyM1t97qwz1beIrGRPTxbppC20aUggb1YzhT36TA5Umo2qx6ih3V8+jwWRhbMZVzIExLz3IbVmrA==
X-Received: by 2002:a05:6402:d05:b0:425:b7ab:776e with SMTP id eb5-20020a0564020d0500b00425b7ab776emr5998674edb.142.1656525552801;
        Wed, 29 Jun 2022 10:59:12 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bo5-20020a170906d04500b006ff0fe78cb7sm7981879ejb.133.2022.06.29.10.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:59:12 -0700 (PDT)
Message-ID: <7560d60d-b4bb-6fcd-bfac-e9f4da911561@linaro.org>
Date:   Wed, 29 Jun 2022 19:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 07/14] dt-bindings: thermal: Add fsl,scu-thermal yaml
 file
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
 <20220629164414.301813-8-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629164414.301813-8-viorel.suman@oss.nxp.com>
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
> separately the 'thermal' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---

Assuming all patches are taken independently:



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
