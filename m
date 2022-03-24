Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8523B4E6987
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352052AbiCXTyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353364AbiCXTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:53:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E0A7771;
        Thu, 24 Mar 2022 12:51:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id p15so11300551ejc.7;
        Thu, 24 Mar 2022 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QPVMEnd0iC3xwqlprX0xgTYYSHSgd0be+3kt9YezMds=;
        b=MljPE+McS2wuQhEwkk1LrAglIC5leGRgFmU0FXZpwD4J1+uCL0qXaSWwznQEKg3KTm
         1OVnlLf6sjkJLSCogof5K4FX8MiTZSsjYpKEYtqCLdHQuYJ619qB1t2SpxHHH01uKHm+
         wh0QKNC5UEBGBZp8BeoJbLhrWP+8LNjePkNKOJglifv//H6rEh9XPo48KqLVOrrNS0fz
         8l+dP33ZFtmIZg6iI4TKwu6q45BtM/gyqr0QXdH8Ml+n90dAoYJEP0a0WdtYvdiYbRS/
         2ABol3ZmnJJULB7jvGTbNn5IwCj+VgdltxYsvzDzSGDgDA+ECwc0GjnV2BGLGsvBVyHe
         dClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QPVMEnd0iC3xwqlprX0xgTYYSHSgd0be+3kt9YezMds=;
        b=KLUpPNBlOvuJJVJi5n1rux8ooMhfozVyLUTAC+VLc7aZUmdnKVtuKs99n/U80TxBPb
         xOeTqh+Ny2JRXqkOH6UpOzwYPYuRyk8ftLQubyPY+rexG6PXYq/sEXd6t2j90jizHJv4
         oREeojkDG224eMluid+1h7W8X7017v3p3b9JayvOfz1x5bVM8egyzb/heIys96VbLYlP
         RnWX8AR+RNLPqadZ8N72kF67uuZgTdxDCdNoYdudIS6bwLu2UlCjq3X/uuumPDcZG8QN
         aJHLOHOUCo68RMgiJGFnwWHExnZdUujfWY1EG+3931TLGux5ACHm8+fzloef0jT/f2UM
         fhKQ==
X-Gm-Message-State: AOAM532kZ8gOe+6DWeReoU5cyi8XB4BNwwJLBw9Qdo+/gi/ISrJtZ9MO
        rlheike2aH6jI+7YEZqlDeu3W25SlEI=
X-Google-Smtp-Source: ABdhPJx2oh///UL+QFKO52M9ISf+kySQy4uhCHjDCYsDVawBiHVmtxisFPYknDmzUpfIK9l1FClRPg==
X-Received: by 2002:a17:907:a429:b0:6e0:68f3:d7a with SMTP id sg41-20020a170907a42900b006e068f30d7amr7588598ejc.75.1648151498009;
        Thu, 24 Mar 2022 12:51:38 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906275500b006d10c07fabesm1483871ejd.201.2022.03.24.12.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 12:51:37 -0700 (PDT)
Message-ID: <bf62ad40-6bcf-62ae-f56a-cdc8d17456ec@gmail.com>
Date:   Thu, 24 Mar 2022 20:51:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3188-cru.txt to
 YAML
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220324133229.24035-1-jbx6244@gmail.com>
 <f7493d93-6c8a-efa9-1f2c-a0003a6d43b2@kernel.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <f7493d93-6c8a-efa9-1f2c-a0003a6d43b2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko, Krzysztof,

Question for the Rockchip clock maintainer:
What clock should be used here and other SoCs with several clock parents
in the tree?

The clock.yaml produces a lot off notifications like:

/arch/arm/boot/dts/rk3036-evb.dtb: clock-controller@20000000: 'clocks'
is a dependency of 'assigned-clocks'

Same for power-controller:

/arch/arm/boot/dts/rk3288-evb-rk808.dtb: power-controller: 'clocks' is a
dependency of 'assigned-clocks'

Just followed rk3399.yaml that got approved recent.
The current CRU nodes are in use for a long time this way.
Converting a simple .txt comes with a lot of extra work each time. :\
Please advise.

Johan

===
dependencies:
  assigned-clocks: [clocks]

ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.7/site-packages/dtschema/schemas/clock/clock.yaml

===

See /Documentation/devicetree/bindings/clock/ grep for "assigned":

From cirrus,lochnagar.yaml:

  clocks: true
  assigned-clocks: true
  assigned-clock-parents: true

Is this a possible solution?
So we we don't have to be specific.


On 3/24/22 15:28, Krzysztof Kozlowski wrote:
> On 24/03/2022 14:32, Johan Jonker wrote:
>> Current dts files with RK3188/RK3066 'cru' nodes are manually verified.
>> In order to automate this process rockchip,rk3188-cru.txt has to be
>> converted to YAML.
>>
>> Changed:
>>   Add properties to fix notifications by clocks.yaml for example:
>>     clocks
>>     assigned-clock-rates
>>     assigned-clocks
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  .../bindings/clock/rockchip,rk3188-cru.txt    | 61 --------------
>>  .../bindings/clock/rockchip,rk3188-cru.yaml   | 81 +++++++++++++++++++
>>  2 files changed, 81 insertions(+), 61 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
>> deleted file mode 100644
>> index 7f368530a..000000000
>> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
>> +++ /dev/null
>> @@ -1,61 +0,0 @@
>> -* Rockchip RK3188/RK3066 Clock and Reset Unit
>> -
>> -The RK3188/RK3066 clock controller generates and supplies clock to various
>> -controllers within the SoC and also implements a reset controller for SoC
>> -peripherals.
>> -
>> -Required Properties:
>> -
>> -- compatible: should be "rockchip,rk3188-cru", "rockchip,rk3188a-cru" or
>> -			"rockchip,rk3066a-cru"
>> -- reg: physical base address of the controller and length of memory mapped
>> -  region.
>> -- #clock-cells: should be 1.
>> -- #reset-cells: should be 1.
>> -
>> -Optional Properties:
>> -
>> -- rockchip,grf: phandle to the syscon managing the "general register files"
>> -  If missing pll rates are not changeable, due to the missing pll lock status.
>> -
>> -Each clock is assigned an identifier and client nodes can use this identifier
>> -to specify the clock which they consume. All available clocks are defined as
>> -preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
>> -dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
>> -Similar macros exist for the reset sources in these files.
>> -
>> -External clocks:
>> -
>> -There are several clocks that are generated outside the SoC. It is expected
>> -that they are defined using standard clock bindings with following
>> -clock-output-names:
>> - - "xin24m" - crystal input - required,
>> - - "xin32k" - rtc clock - optional,
>> - - "xin27m" - 27mhz crystal input on rk3066 - optional,
>> - - "ext_hsadc" - external HSADC clock - optional,
>> - - "ext_cif0" - external camera clock - optional,
>> - - "ext_rmii" - external RMII clock - optional,
>> - - "ext_jtag" - externalJTAG clock - optional
>> -
>> -Example: Clock controller node:
>> -
>> -	cru: cru@20000000 {
>> -		compatible = "rockchip,rk3188-cru";
>> -		reg = <0x20000000 0x1000>;
>> -		rockchip,grf = <&grf>;
>> -
>> -		#clock-cells = <1>;
>> -		#reset-cells = <1>;
>> -	};
>> -
>> -Example: UART controller node that consumes the clock generated by the clock
>> -  controller:
>> -
>> -	uart0: serial@10124000 {
>> -		compatible = "snps,dw-apb-uart";
>> -		reg = <0x10124000 0x400>;
>> -		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>> -		reg-shift = <2>;
>> -		reg-io-width = <1>;
>> -		clocks = <&cru SCLK_UART0>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>> new file mode 100644
>> index 000000000..136a9771e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>> @@ -0,0 +1,81 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip RK3188/RK3066 Clock and Reset Unit (CRU)
>> +
>> +maintainers:
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +description: |
>> +  The RK3188/RK3066 clock controller generates and supplies clocks to various
>> +  controllers within the SoC and also implements a reset controller for SoC
>> +  peripherals.
>> +  Each clock is assigned an identifier and client nodes can use this identifier
>> +  to specify the clock which they consume. All available clocks are defined as
>> +  preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
>> +  dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
>> +  Similar macros exist for the reset sources in these files.
>> +  There are several clocks that are generated outside the SoC. It is expected
>> +  that they are defined using standard clock bindings with following
>> +  clock-output-names:
>> +    - "xin24m"    - crystal input                 - required
>> +    - "xin32k"    - RTC clock                     - optional
>> +    - "xin27m"    - 27mhz crystal input on RK3066 - optional
>> +    - "ext_hsadc" - external HSADC clock          - optional
>> +    - "ext_cif0"  - external camera clock         - optional
>> +    - "ext_rmii"  - external RMII clock           - optional
>> +    - "ext_jtag"  - external JTAG clock           - optional
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - rockchip,rk3066a-cru
>> +      - rockchip,rk3188-cru
>> +      - rockchip,rk3188a-cru
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  "#reset-cells":
>> +    const: 1
>> +
>> +  clocks:
>> +    minItems: 1
> 

> You need maxItems. Would be also nice to describe what should be here as
> input

Just followed rockchip,rk3399-cru.yaml that got rob+dt's ack.

Is this dependency only for simple clock consumers suitable for complex
clock trees with pll's, mux, etc? Shouldn't that be relaxed a bit?

> 
> 
>> +
>> +  assigned-clock-rates:
>> +    minItems: 1
>> +    maxItems: 64
>> +
>> +  assigned-clocks:
>> +    minItems: 1
>> +    maxItems: 64
> 
> Both assigned-xxx should not be necessary. Did you try validate the dtbs
> without these?

That's how it's currently done for Rockchip cru's.


ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml

> 
> I guess you added "clocks" above because of these, so you need to
> correct the DTS because asigned-xxx depend on clocks property.

See comment above.

> 
>> +
>> +  rockchip,grf:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the syscon managing the "general register files" (GRF),
>> +      if missing pll rates are not changeable, due to the missing pll lock status.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#clock-cells"
>> +  - "#reset-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    cru: cru@20000000 {
> 
> Node name: clock-controller

Which schema?

> 
>> +      compatible = "rockchip,rk3188-cru";
>> +      reg = <0x20000000 0x1000>;
>> +      rockchip,grf = <&grf>;
>> +      #clock-cells = <1>;
>> +      #reset-cells = <1>;
>> +    };
> 
> 
> Best regards,
> Krzysztof
