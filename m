Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668BC56082C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiF2R7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiF2R7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:59:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A065E63
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:59:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q6so34057563eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=9oQd/aihk9MFiV6slPYqynKa26o3HWCnjoP1XQYdYX4=;
        b=JGZ4c7I/UkOZR64cp+6z+AfI133QAf6mVrdAlIAPz+hfF7OW0udq3GnJD+JIPWFVNA
         Qbt0PbBu/M8IQoLqBPcQ77r5sYlo8q40FEiO3oIyphub+iziB3l1zzaaZv2ufoNR6KRQ
         Fmgm/7KCCEFmc0Cr6ilrmuOf/oxBn7ixvXTczRTLEPjxjvfvchnYn6VLovHhgSkbqBm/
         0D8SfN4Xi9dtob5xiLOuzXipqRUbBuAhBqWFqc5r5ZjZFZDeDjXiD+EdEXj2t0yY25rn
         eZr8A54495SXi2JTkzDLZNoscAexbY+m7Tptce+Md4x6rCIihKerub+aKxvmzWd3vgXx
         nWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9oQd/aihk9MFiV6slPYqynKa26o3HWCnjoP1XQYdYX4=;
        b=YbF18zaDaDlY63DzRVE4jVE4Vv3AzVbScayBvJHJkpfs4V61Enb5ZNr4+BW2gxgtXv
         EeyU/H3Z3YW1n6oeJBhPu1lGRmshUopM5FMjH8tybPAJETPVMUTsGzF93cQt69vKadJ+
         sf9G++30dFrzW4eBOzFQFWsM7dBq1M6GWM3Itav8wclZsfq5CzN+W9qV4Ju5BKzXBnA/
         ijLbWBSOjqM7TGpT/0WuMZYWtD5TsByyjR0JSs1sLrCQNeBuCyGiO4vF06MC+KF+l3zm
         cNqeCuXMxHNrnMsektNNQI63QF8pHXR7WT+CMpI28S1eEcxkD/1cSfXdkZ1IrJf0zM20
         ZdQQ==
X-Gm-Message-State: AJIora9112u9se1EQUKbwXu4lpMxIeBSx74DjzNohQ5fS04r2XoFV0wL
        8IjRYT/OreWs0PnwedGbyg5ZvA==
X-Google-Smtp-Source: AGRyM1tEvw4Z+sdS8R2b5pMQ4mI40CTjDyQX6wt24Ed3+/7JZJ4AE+2EZXxDaUOUK81SuQaIegr+pw==
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id f17-20020a1709063f5100b0071239458c0dmr4466853ejj.302.1656525584092;
        Wed, 29 Jun 2022 10:59:44 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709063c0100b006feec47dae9sm7958751ejg.157.2022.06.29.10.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:59:43 -0700 (PDT)
Message-ID: <988844aa-f7ce-3cba-dd6c-227fa6d58102@linaro.org>
Date:   Wed, 29 Jun 2022 19:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 08/14] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
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
 <20220629164414.301813-9-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629164414.301813-9-viorel.suman@oss.nxp.com>
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
> separately the 'watchdog' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---

Assuming all patches are taken independently:



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
