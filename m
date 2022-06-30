Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED4556221F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiF3Sds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiF3Sdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:33:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB62255A1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:33:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so19851797edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yJGEttsMIPFNExRUVjMuioYnkzWMdO3yRAB963cFp2o=;
        b=bVZKc01WEs5LMjU5JtELjSXU1pShwhHGLZhNmZYt3wfTdiQE/yN2UAshZdvCOv8QGq
         jvuwowiNtOjr5posUthWXU7PWhNZt5GOF4X2vS97DTQrhkMDd85y2516gnqfIuFFlh2I
         ruddBdJWCPzK2JSEvz6DATLXX11xi0ZKag2bf5Laj6MHMpCI7ursQwhCZpecYj90tw5h
         nPUB4qcjaCKLvbhHoLjfivF0IkdS9P0U2XM5vlr2MQX+1XbAOzaKqW9xv/xG0frtmHy6
         SsZzW6ElgdT4rkY8rdjUlQFfxOrx2HPWseOs3kKWIzs1pfoxsos6mZK6KSJsuFIKNtoI
         Jsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yJGEttsMIPFNExRUVjMuioYnkzWMdO3yRAB963cFp2o=;
        b=OPiWUXvl4xQdsP5suG4Batrd+pykNJq6wvayLLKqoKdUvNHW9vet9PgYbUiHqDmGed
         o/5NPjSIYmahFrU1cCOD05mUCjOEcfc9w16NHfYH8qTBIWBn3h5BgapZvLTc4EGRm2fx
         z2jNQkcfQbd/LJVZNdJ9+D9GQ8QN6JN9k9j3/dVHu54/Mm5IKWlH9P5z82X1rPHJPOMN
         HpusXiCFGNbx3lU0Q5XAPOsyNuLpi5VQhOzDzg2vVvbEByZyjuiBpkzXhyoOuRw/xyO3
         YrCE0yLEKcKmgbcmcLoSIBJTXTUgumM7Dr+Om4qZqo0g9Ner4RIaI4H4Fg+KC9ev1v31
         J52g==
X-Gm-Message-State: AJIora+YGQgPgY+Kff5eu6X6gWM10DYrG7ooTXaEcC9uRpI1UlzQPJ+X
        SPqjnpEDI8a2nuDMbLYCfLnrTe3pHcK3KQ==
X-Google-Smtp-Source: AGRyM1s8xy762cCi9FZl1Kcj0KeKPHclcEopngQ5Us/lz3lUXqlZKh+6oqktKAwNKh4wiC/U7Zn6jA==
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id ek8-20020a056402370800b004332d3b0ed5mr13495310edb.246.1656614022289;
        Thu, 30 Jun 2022 11:33:42 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709067c8300b00722fc0779e3sm9482072ejo.85.2022.06.30.11.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:33:41 -0700 (PDT)
Message-ID: <78faf75d-80b7-7a0e-e306-6351dbe5133c@linaro.org>
Date:   Thu, 30 Jun 2022 20:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 02/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux
 yaml file
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
 <20220629164414.301813-3-viorel.suman@oss.nxp.com>
 <f0634bf0-77e9-939e-693f-31d50af4768c@linaro.org>
 <20220630123754.esbuac4pfktlseh2@fsr-ub1664-116>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630123754.esbuac4pfktlseh2@fsr-ub1664-116>
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

On 30/06/2022 14:37, Viorel Suman (OSS) wrote:
> On 22-06-29 19:53:51, Krzysztof Kozlowski wrote:
>> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
>>> From: Abel Vesa <abel.vesa@nxp.com>
>>>
>>> In order to replace the fsl,scu txt file from bindings/arm/freescale,
>>> we need to split it between the right subsystems. This patch documents
>>> separately the 'iomux/pinctrl' child node of the SCU main node.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
>>> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>>> ---
>>>  .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 68 +++++++++++++++++++
>>>  1 file changed, 68 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
>>> new file mode 100644
>>> index 000000000000..76a2e7b28172
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> [...]
>>> +      fsl,pins:
>>> +        description:
>>> +          each entry consists of 3 integers and represents the pin ID, the mux value
>>> +          and config setting for the pin. The first 2 integers - pin_id and mux_val - are
>>> +          specified using a PIN_FUNC_ID macro, which can be found in
>>> +          <include/dt-bindings/pinctrl/pads-imx8qxp.h>. The last integer CONFIG is
>>> +          the pad setting value like pull-up on this pin. Please refer to the
>>> +          appropriate i.MX8 Reference Manual for detailed CONFIG settings.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>
>> Look at fsl,imx8mq-pinctrl.yaml. Each item is described (items under items).
> 
> Added them initially, but later dropped because of some logs like
> "pinctrl@xxxxxxx: usdhc1grp:fsl,pins:0: [...] is too long" shown by
> "make dt_binding_check dtbs_check DT_SCHEMA_FILES=[...]/fsl,scu-pinctrl.yaml"
> 
> Same logs are shown for "fsl,imx8mq-pinctrl.yaml". Will add the items description in the next
> version.
>

The fsl,imx8mq-pinctrl.yaml should be correct and I don't see the reason
why dtschema complains in some of the entries. It's like one define was
not correct... I'll take a look at this later, but anyway keep the same
as fsl,imx8mq-pinctrl.yaml even if it complains.


Best regards,
Krzysztof
