Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30664AFCE0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiBITG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:06:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiBITGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:06:55 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F14C03C1A6;
        Wed,  9 Feb 2022 11:06:47 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 219J4Qkg105333;
        Wed, 9 Feb 2022 13:04:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644433466;
        bh=SRVHYoJ/oRcyKgnuNgklLIBZXWQnsAJ4r6qva6onZeQ=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=a5jJ4F59pL1B0sXVeBC87dWeMG4lIrPP25wTf3qcfo2kDTF2KhGYYaWy4HXBmvgx8
         u8FbpIdPQurIln47LsHz4UBi5FlC66lUqbPsaqnNY5gI3C8zdoPVs3ngrcjKAE1W8e
         d6mN0o8TgtZk7EB4ZYXM6BVVwcXD3FqkpgDaQ1nc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 219J4QcM007930
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 13:04:26 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 13:04:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 13:04:26 -0600
Received: from [10.250.235.90] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 219J4NtW019768;
        Wed, 9 Feb 2022 13:04:23 -0600
Message-ID: <aa042432-8e70-19d9-9bde-c6d5bf6688b1@ti.com>
Date:   Thu, 10 Feb 2022 00:34:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/5] dt-bindings: arm: ti: Add bindings for AM625 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-3-vigneshr@ti.com>
 <9303ca0e-2a83-3c3e-0892-c74a820562a9@canonical.com>
Content-Language: en-US
In-Reply-To: <9303ca0e-2a83-3c3e-0892-c74a820562a9@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/22 10:31 pm, Krzysztof Kozlowski wrote:
> On 08/02/2022 14:18, Vignesh Raghavendra wrote:
>> From: Nishanth Menon <nm@ti.com>
>>
>> The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
>> architecture platform, providing ultra-low-power modes, dual display,
>> multi-sensor edge compute, security and other BOM-saving integration.
>> The AM62 SoC targets broad market to enable applications such as
>> Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
>> Automation, Appliances and more.
>>
>> Some highlights of this SoC are:
>>
>> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>>   Pin-to-pin compatible options for single and quad core are available.
>> * Cortex-M4F for general-purpose or safety usage.
>> * Dual display support, providing 24-bit RBG parallel interface and
>>   OLDI/LVDS-4 Lane x2, up to 200MHz pixel clock support for 2K display
>>   resolution.
>> * Selectable GPUsupport, up to 8GFLOPS, providing better user experience
>>   in 3D graphic display case and Android.
>> * PRU(Programmable Realtime Unit) support for customized programmable
>>   interfaces/IOs.
>> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>>   external ports (TSN capable).
>> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for
>>   NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>>   1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
>> * Dedicated Centralized System Controller for Security, Power, and
>>   Resource Management.
>> * Multiple low power modes support, ex: Deep sleep,Standby, MCU-only,
>>   enabling battery powered system design.
>>
>> AM625 is the first device of the family. Add DT bindings for the same.
> 
> Don't paste the same huge commit description in several commits.

Sorry, I think this is the first commit with full description. I will
probably trim 4/5 at bit

> 
>>
>> More details can be found in the Technical Reference Manual:
>> https://www.ti.com/lit/pdf/spruiv7
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> index b03c10fa2e7a..64f3db3ea9dd 100644
>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> @@ -53,6 +53,12 @@ properties:
>>                - ti,am642-sk
>>            - const: ti,am642
>>  
>> +      - description: K3 AM625 SoC
>> +        items:
>> +          - enum:
>> +              - ti,am625-sk
>> +          - const: ti,am625
> 
> Why keeping it not alphabetically sorted? What sorting did you choose?
> 

Above list is not sorted alphabetically, I tried to keep similar SoCs
bunched together. AM625 and AM642 are of same family, hence chose to add
the new entry here.

One alternative is to add it to end of the list (chronologically)?
Or I can add a patch to sort the list alphabetically first and then
introduce new compatible. Please let me know your preference?

>> +
>>        - description: K3 J721s2 SoC
>>          items:
>>            - enum:
> 
> 
> Best regards,
> Krzysztof


Regards
Vignesh
