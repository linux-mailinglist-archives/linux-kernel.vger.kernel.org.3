Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1655CF32
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiF0OWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiF0OVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:21:35 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2189E13CF9;
        Mon, 27 Jun 2022 07:21:33 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDUGvG019903;
        Mon, 27 Jun 2022 16:21:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=zspda62bHDTpbxjlx3pNU8tSQuN0TE9W+gSeJGZZuks=;
 b=CJOwTPStfgOH01/tErFc9mX2FtMPxEgWXNsuMoccQbNKRzQPePFi9DpEtzx7nh60FMps
 dJTznLO0Fi967vOnp/DL8NW+2afa84PtIuf5GG5BV/V+brvXLOLor/eE18Law97gpcHy
 UommIdmZnnR/KbR1tCR7R7D7S2XUqJdLHCPX1vlXbKvqbrKTBcLwCOYQM0UbLIBIZAvU
 nCz2Ha0fbEbWbpNcWxrPx/ba82XtHtUGXI/ksExNt7yBunLO4TXPXbOGwmD64Xh7E7X/
 POjR/jYnD8uXL1wxkm/m6+2eh09jqw8UL/qukvFvEtUA5yCMdJWHm0Wvza0NCtngbPbq mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gy9mr1sd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 16:21:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F97F10002A;
        Mon, 27 Jun 2022 16:21:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F318822177F;
        Mon, 27 Jun 2022 16:21:16 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.46) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 27 Jun
 2022 16:21:15 +0200
Message-ID: <845d6817-d2e4-7925-f7f5-da1102514636@foss.st.com>
Date:   Mon, 27 Jun 2022 16:21:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec: add bindings for stm32g0
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-2-fabrice.gasnier@foss.st.com>
 <ddb0e946-c955-1404-c1cd-c2548f34ec35@linaro.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ddb0e946-c955-1404-c1cd-c2548f34ec35@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 18:16, Krzysztof Kozlowski wrote:
> On 24/06/2022 17:54, Fabrice Gasnier wrote:
>> This patch adds DT schema documentation for the STM32G0 Type-C controller.
> 
> No "This patch"

Hi Krzysztof,

ack,

> 
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
>> STM32G0 provides an integrated USB Type-C and power delivery interface.
>> It can be programmed with a firmware to handle UCSI protocol over I2C
>> interface. A GPIO is used as an interrupt line.
>> It may be used as a wakeup source, so use optional "wakeup-source" and
>> "power-domains" properties to support wakeup.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>>  .../bindings/usb/st,typec-stm32g0.yaml        | 83 +++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>> new file mode 100644
>> index 0000000000000..b2729bd015a1a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/usb/st,typec-stm32g0.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> No quotes.

ack,

> 
>> +
>> +title: STMicroelectronics STM32G0 Type-C controller bindings
> 
> s/bindings//

ack,

> 
>> +
>> +description: |
>> +  The STM32G0 MCU can be programmed to control Type-C connector(s) through I2C
>> +  typically using the UCSI protocol over I2C, with a dedicated alert
>> +  (interrupt) pin.
>> +
>> +maintainers:
>> +  - Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32g0-typec
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  connector:
>> +    type: object> +    allOf:
>> +      - $ref: ../connector/usb-connector.yaml#
> 
> Full path, so /schemas/connector/...
> 
> unevaluatedProperties: false

ack,

> 
>> +
>> +  firmware-name:
>> +    description: |
>> +      Should contain the name of the default firmware image
>> +      file located on the firmware search path
>> +
>> +  wakeup-source: true
>> +  power-domains: true
> 
> maxItems

Do you mean maxItems regarding the "power-domains" property ?
This will depend on the user platform, where it's used as an I2C device.
So I'm not sure this can / should be specified here.
Could please you clarify ?

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c5 {
> 
> Just "i2c"

ack,

> 
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      stm32g0@53 {
> 
> Generic node name describing class of the device.


I wasn't aware of generic node name for an I2C device (not talking of
the controller). I may have missed it.

Could you please clarify ?

> 
>> +        compatible = "st,stm32g0-typec";
>> +        reg = <0x53>;
>> +        /* Alert pin on GPIO PE12 */
>> +        interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
>> +        interrupt-parent = <&gpioe>;
>> +
>> +        /* Example with one type-C connector */
>> +        connector {
>> +          compatible = "usb-c-connector";
>> +          label = "USB-C";
>> +
>> +          port {
> 
> This does not look like proper schema of connector.yaml.

This refers to graph.yaml [1], where similar example is seen [2].

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L79

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L207

    device-1 {
        port {
            device_1_output: endpoint {
                remote-endpoint = <&device_2_input>;
            };
        };
    };
    device-2 {
        port {
            device_2_input: endpoint {
                remote-endpoint = <&device_1_output>;
            };
        };
    };


Could you please clarify this point too ?

> 
>> +            con_usb_c_ep: endpoint {
>> +              remote-endpoint = <&usbotg_hs_ep>;
>> +            };
>> +          };
>> +        };
>> +      };
>> +    };
>> +
>> +    usbotg_hs {
> 
> Generic node names, no underscores in node names.

ack, I guess you'd recommend "usb" here. I'll update it.

Thanks for reviewing,
Best Regards,
Fabrice

> 
>> +      usb-role-switch;
>> +      port {
>> +        usbotg_hs_ep: endpoint {
>> +          remote-endpoint = <&con_usb_c_ep>;
>> +        };
>> +      };
>> +    };
>> +...
> 
> 
> Best regards,
> Krzysztof
