Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AFF57F07A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiGWQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:51:20 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7251CB04;
        Sat, 23 Jul 2022 09:51:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07959742|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0621329-0.00156306-0.936304;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=24;RT=24;SR=0;TI=SMTPD_---.Obla2Lb_1658595040;
Received: from 192.168.10.152(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Obla2Lb_1658595040)
          by smtp.aliyun-inc.com;
          Sun, 24 Jul 2022 00:50:42 +0800
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
 <487a93c4-3301-aefd-abba-aabf4cb8ec90@linaro.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <37062a5d-9da3-fbaf-89bd-776f32be36d9@wanyeetech.com>
Date:   Sun, 24 Jul 2022 00:50:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <487a93c4-3301-aefd-abba-aabf4cb8ec90@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/7/23 上午1:46, Krzysztof Kozlowski wrote:
> On 22/07/2022 18:48, 周琰杰 (Zhou Yanjie) wrote:
>> Add the SFC bindings for the X1000 SoC, the X1600 SoC, the X1830 SoC,
>> and the X2000 SoC from Ingenic.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>   .../devicetree/bindings/spi/ingenic,sfc.yaml       | 64 ++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>> new file mode 100644
>> index 00000000..b7c4cf4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/ingenic,sfc.yaml#
> File name should be rather based on first compatible, so
> ingenic,x1000-sfc.yaml


No offense, does it really need to be named that way?
I can't seem to find documentation with instructions on this :(

The use of "ingenic,sfc.yaml" indicates that this is the documentation
for the SFC module for all Ingenic SoCs, without misleading people into
thinking it's only for a specific model of SoC. And there seem to be many
other yaml documents that use similar names (eg. fsl,spi-fsl-qspi.yaml,
spi-rockchip.yaml, spi-nxp-fspi.yaml, ingenic,spi.yaml, spi-sifive.yaml,
omap-spi.yaml), maybe these yaml files that are not named with first
compatible are also for the same consideration. :)


>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bindings for SFC in Ingenic SoCs
>> +
>> +maintainers:
>> +  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> +
>> +description:
>> +  The SPI Flash Controller in Ingenic SoCs.
>> +
> You miss here allOf referencing spi-controller.


Sure, will add it in the next version.


>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - ingenic,x1000-sfc
>> +          - ingenic,x1600-sfc
>> +          - ingenic,x2000-sfc
>> +      - items:
>> +          - enum:
>> +              - ingenic,x1830-sfc
>> +          - const: ingenic,x1000-sfc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: sfc
> Remove the clock-names entirely, no benefits.


Sure.


>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/ingenic,x1000-cgu.h>
>> +
>> +	sfc: spi@13440000 {
>> +		compatible = "ingenic,x1000-sfc";
>
> Use 4 spaces for example indentation.


My fault, will fix it in the next version.


>> +		reg = <0x13440000 0x1000>;
>> +
>> +		interrupt-parent = <&intc>;
>> +		interrupts = <7>;
>> +
>> +		clocks = <&cgu X1000_CLK_SFC>;
>> +		clock-names = "sfc";
>> +
>> +		status = "disabled";
> No status in example.


Sure, will remove it in the next version.


Thanks and beset regards!


>
>> +	};
>> +...
>
> Best regards,
> Krzysztof
