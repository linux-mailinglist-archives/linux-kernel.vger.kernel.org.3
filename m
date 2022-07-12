Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C355727B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiGLUue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiGLUua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:50:30 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F73820F0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:50:29 -0700 (PDT)
Received: from [192.168.1.101] (abxj14.neoplus.adsl.tpnet.pl [83.9.3.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2C52A3F219;
        Tue, 12 Jul 2022 22:50:27 +0200 (CEST)
Message-ID: <9b535332-838d-6662-d0eb-feab075b2915@somainline.org>
Date:   Tue, 12 Jul 2022 22:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Sony Tama TD4353 JDI
 display panel
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712200244.960018-1-konrad.dybcio@somainline.org>
 <68b8da6a-03e2-9da7-795d-f028bc0ed05b@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <68b8da6a-03e2-9da7-795d-f028bc0ed05b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.07.2022 22:47, Krzysztof Kozlowski wrote:
> On 12/07/2022 22:02, Konrad Dybcio wrote:
>> Add bindings for the display panel used on some Sony Xperia XZ2 and XZ2
>> Compact smartphones.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>  .../display/panel/sony,td4353-jdi.yaml        | 84 +++++++++++++++++++
>>  1 file changed, 84 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
>> new file mode 100644
>> index 000000000000..d75abc72ad1b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/sony,td4353-jdi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sony TD4353 JDI 5 / 5.7" 2160x1080 MIPI-DSI Panel
>> +
>> +maintainers:
>> +  - Konrad Dybcio <konrad.dybcio@somainline.org>
>> +
>> +description: |
>> +  The Sony TD4353 JDI is a 5 (XZ2c) / 5.7 (XZ2) inch 2160x1080
>> +  MIPI-DSI panel, used in Xperia XZ2 and XZ2 Compact smartphones.
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - sony,td4353-jdi-akari
>> +      - sony,td4353-jdi-apollo
> 
> Shouldn't the properties of panel like width and height be specified by
> dedicated properties, instead of customizing compatible? The device is
> "td4353-jdi", the same in both cases, isn't it?
Not sure if it should, but in this case it probably could, the panels are
software-compatible, yes.

> 
>> +
>> +  reg: true
>> +
>> +  backlight: true
>> +
>> +  vddio-supply:
>> +    description: VDDIO 1.8V supply
>> +
>> +  vsp-supply:
>> +    description: Positive 5.5V supply
>> +
>> +  vsn-supply:
>> +    description: Negative 5.5V supply
>> +
>> +  preset-gpios:
>> +    description: Display panel reset pin
>> +
>> +  treset-gpios:
>> +    description: Touch panel reset pin
>> +
>> +  port: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vddio-supply
>> +  - vsp-supply
>> +  - vsn-supply
>> +  - preset-gpios
>> +  - treset-gpios
>> +  - port
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    dsi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        panel: panel@0 {
>> +            compatible = "sony,td4353-jdi-akari";
>> +            reg = <0>;
>> +
>> +            backlight = <&pmi8998_wled>;
>> +            vddio-supply = <&vreg_l14a_1p8>;
>> +            vsp-supply = <&lab>;
>> +            vsn-supply = <&ibb>;
>> +            preset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
>> +            treset-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
>> +
>> +            port {
>> +                    panel_in: endpoint {
> 
> Inconsistent indentation.
Will fix.

Konrad
> 
>> +                            remote-endpoint = <&dsi0_out>;
>> +                    };
>> +            };
>> +        };
>> +    };
>> +...
> 
> 
> Best regards,
> Krzysztof
