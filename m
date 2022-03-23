Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249764E4F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbiCWJTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242834AbiCWJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:19:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCA12D1E4;
        Wed, 23 Mar 2022 02:18:08 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22N9I0oD068206;
        Wed, 23 Mar 2022 04:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648027080;
        bh=FKhDA68ig5aZhPe8FOCO/Wk9TMGU3OIlpjEJGCM5byI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hxmrXDpPCnvxFfDGU1HEZ/6O3GYIo3XiydKVlp65bW02ykvP0dWnsU0erTUlqKwdZ
         z6F/nqnG9gYe5bswrE5cOXXeETY98CrGf8tJc0pFhwJrRnNq4ha2ezxlqEcPovTFQQ
         vkX3fdQ8MBcF8cHpsLZTc5gOG/UdWfVPUJleRcV0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22N9I0ST040583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Mar 2022 04:18:00 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Mar 2022 04:18:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Mar 2022 04:17:59 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22N9HtXY076005;
        Wed, 23 Mar 2022 04:17:56 -0500
Message-ID: <8b8dcc55-dda8-0715-ccff-22fbe84ff18a@ti.com>
Date:   Wed, 23 Mar 2022 14:47:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220323053524.7009-1-a-govindraju@ti.com>
 <20220323053524.7009-2-a-govindraju@ti.com>
 <f17f1f14-d78f-7b54-7fa7-ebf52c6da90a@kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <f17f1f14-d78f-7b54-7fa7-ebf52c6da90a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 23/03/22 14:35, Krzysztof Kozlowski wrote:
> On 23/03/2022 06:35, Aswath Govindraju wrote:
>> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
>> controller.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 98 +++++++++++++++++++
>>  1 file changed, 98 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>> new file mode 100644
>> index 000000000000..4bb139d1926d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>> @@ -0,0 +1,98 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD controller
> 
> Skip the "Bindings for the", just leave the HW description.
> 

Will drop it in the respin.

>> +
>> +maintainers:
>> +  - Aswath Govindraju <a-govindraju@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,am62-usb
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  ranges: true
>> +
>> +  power-domains:
>> +    description:
>> +      PM domain provider node and an args specifier containing
>> +      the USB ISO device id value. See,
>> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    description: Clock phandles to usb2_refclk
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ref
>> +
>> +  id-gpio:
>> +    description:
>> +      GPIO to be used as ID pin
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description:
>> +      interrupt line to be used for detecting changes in VBUS
>> +
>> +  ti,vbus-divider:
>> +    description:
>> +      Should be present if USB VBUS line is connected to the
>> +      VBUS pin of the SoC via a 1/3 voltage divider.
>> +    type: boolean
>> +
>> +  ti,syscon-phy-pll-refclk:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: Phandle to the SYSCON entry
>> +          - description: USB phy control register offset within SYSCON
>> +    description: Specifier for configuring frequency of ref clock input.
> 
> This is a bit strange. The ref clock is the "ref" input clock, right? In
> such case use clk_set_rate()... Using syscon for managing clocks is not
> the proper way.
> 

The syscon property is not being used to set the ref clock frequency but
is rather being used to indicate the input clock frequency for USB PHY
operation. I think the description seems be misleading. I will update it
in the respin, to reflect the above description.

> Plus all the issues pointed out by Roger.
> 
>> +
>> +  '#address-cells':
>> +    const: 2
>> +
>> +  '#size-cells':
>> +    const: 2
> 
> No children allowed?
> 
> I understand this is a wrapper, which explains why you do not include
> usb-hcd.yaml schema. But since it is a wrapper, what is it wrapping?
> 

Yes, there is a child node, which would be the dwc3-contoller node.
Would adding the child node too in the example help capture this better?

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - power-domains
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +  - ti,syscon-phy-pll-refclk
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    bus {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      dwc3-usb@f910000 {
> 
> Generic node name, so usb.
> 

Will correct this in the respin.


Thank you for the review.

>> +        compatible = "ti,am62-usb";
> 
> 
> Best regards,
> Krzysztof


-- 
Thanks,
Aswath
