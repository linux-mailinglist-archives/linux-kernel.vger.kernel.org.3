Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C8571713
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiGLKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiGLKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:19:23 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3639CACEE8;
        Tue, 12 Jul 2022 03:19:19 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C92jRH002380;
        Tue, 12 Jul 2022 12:18:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=uDqCvZc0Uom4P6pD2RoNWs0xsgJc1i+hVyrc5eMNVlw=;
 b=rtEJViEdQtlzhS7Ua/hha/MJYx3j3bs7pvfzIXTbEF5a9oC9NAwx2mY6AHNj4iGam+4d
 O6Anh78w+aCscggDD+pbr3It2RZri62h8CfuW8h/pDSScq25goBZ8eGMF3wTHzwiSFPw
 Ho8r8WBulxKthjWJsLXwi5OrOoZkpe3YouiqnfCq5Yg14HmciDQaho/P5jZPRSbGCQGa
 WNQRLsLg9vCxaIHRUay+ubGpAtTrSH1g5BcTq5Su1ogwM0cC/Z1jSYncaKtGHoGZsTrZ
 OEMsXd7cWThoHCi6Hbcimvk1gyz+bADuozNYOqxV3FBLzLjZCtYk9JbJ2bbZBYbzd0P5 MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h9173j15b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 12:18:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 740D010002A;
        Tue, 12 Jul 2022 12:18:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A6142171CC;
        Tue, 12 Jul 2022 12:18:55 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.49) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 12 Jul
 2022 12:18:54 +0200
Message-ID: <d9962ee2-bc92-e550-6dd9-1a0d0ed704e2@foss.st.com>
Date:   Tue, 12 Jul 2022 12:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: typec: add bindings for stm32g0
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <christophe.jaillet@wanadoo.fr>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>
References: <20220711120122.25804-1-fabrice.gasnier@foss.st.com>
 <20220711120122.25804-2-fabrice.gasnier@foss.st.com>
 <403ba7a3-7e3d-4daa-6c14-d8bb4a3d6087@linaro.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <403ba7a3-7e3d-4daa-6c14-d8bb4a3d6087@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_05,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 10:42, Krzysztof Kozlowski wrote:
> On 11/07/2022 14:01, Fabrice Gasnier wrote:
>> Add DT schema documentation for the STM32G0 Type-C PD (Power Delivery)
>> controller.
>> STM32G0 provides an integrated USB Type-C and power delivery interface.
>> It can be programmed with a firmware to handle UCSI protocol over I2C
>> interface. A GPIO is used as an interrupt line.
>> It may be used as a wakeup source, so use optional "wakeup-source" and
>> "power-domains" properties to support wakeup.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> ---
>> Changes in v2:
>> - Krzysztof's review comments: update commit message, use ports, use
>>   unevaluatedProperties: false for usb-connector schema, define maxItems
>>   for power-domains, adopt generic node names, remove quotes
>> ---
>>  .../bindings/usb/st,typec-stm32g0.yaml        | 90 +++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>> new file mode 100644
>> index 0000000000000..7b3a2c2124e38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>> @@ -0,0 +1,90 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/st,typec-stm32g0.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STM32G0 USB Type-C PD controller
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
>> +    type: object
>> +    $ref: /schemas/connector/usb-connector.yaml#
>> +    unevaluatedProperties: false
>> +
>> +  firmware-name:
>> +    description: |
>> +      Should contain the name of the default firmware image
>> +      file located on the firmware search path
>> +
>> +  wakeup-source: true
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
> 
> Isn't connector a required property? I would assume the device does not
> make much sense to operate without it.

Hi Krzysztof,

Indeed, that's sensible. I'll add connector to the required properties.

> 
> What about firmware-name? Do you expect hardware to work fine without it
> (default firmware?)?


Basically, the default firmware could be loaded in production. The
firmware content itself may be customized to restrict the firmware
update feature. That's a pure application decision of the firmware.
There could be other means to update it too (like via CC lines, with
external tools), instead of I2C lines.

Hence, the firmware-name is made optional here.

I can update the commit message with this explanation if this clarifies it.

Thanks for reviewing,
Best Regards,
Fabrice

> 
> 
> Best regards,
> Krzysztof
