Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2372522228
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbiEJRWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243692AbiEJRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:22:11 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7643222C35;
        Tue, 10 May 2022 10:18:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24AHI6oZ079593;
        Tue, 10 May 2022 12:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652203086;
        bh=vG8qH7Id0KatZxxnzh45gjQie9mxliK6XF0aBz5/SDc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=i+M2nbjyMujhQv1B9XR/zfYyfNw05HiP4ulC4MND6fiRM3MkqvI49HugvmEh+afG8
         T9Z/viFLg9IGt6OwlPNnqq1AH+cJ/ld8Yl4EoeSCdEI+x0oXefOfXWk/e2v3O0I24+
         MiOfkT3mJUNx7FzVw6TjNatoo/oGUZiHzsNSw5/s=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24AHI66F024926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 May 2022 12:18:06 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 10
 May 2022 12:18:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 10 May 2022 12:18:04 -0500
Received: from [10.250.234.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24AHI0TQ063624;
        Tue, 10 May 2022 12:18:01 -0500
Message-ID: <ffafc50e-9adb-9d66-3d1f-4ebc9f91f47d@ti.com>
Date:   Tue, 10 May 2022 22:47:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver
 support
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <robh+dt@kernel.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <krzysztof.kozlowski@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220427064635.24898-1-j-keerthy@ti.com>
 <20220427064635.24898-5-j-keerthy@ti.com>
 <78a3cc4d-8ce4-0dae-2f4e-7522a0a3aa0b@ti.com>
 <d94ea6b0-e138-951d-5405-375255104adb@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <d94ea6b0-e138-951d-5405-375255104adb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2022 8:55 PM, Daniel Lezcano wrote:
> On 09/05/2022 05:10, J, KEERTHY wrote:
>>
>>
>> On 4/27/2022 12:16 PM, Keerthy wrote:
>>> Add VTM thermal support. In the Voltage Thermal Management
>>> Module(VTM), K3 J72XX supplies a voltage reference and a temperature
>>> sensor feature that are gathered in the band gap voltage and
>>> temperature sensor (VBGAPTS) module. The band gap provides current and
>>> voltage reference for its internal circuits and other analog IP
>>> blocks. The analog-to-digital converter (ADC) produces an output value
>>> that is proportional to the silicon temperature.
>>>
>>> Currently reading temperatures only is supported.  There are no
>>> active/passive cooling agent supported.
>>>
>>> J721e SoCs have errata i2128: https://www.ti.com/lit/pdf/sprz455
>>>
>>> The VTM Temperature Monitors (TEMPSENSORs) are trimmed during 
>>> production,
>>> with the resulting values stored in software-readable registers. 
>>> Software
>>> should use these  register values when translating the Temperature
>>> Monitor output codes to temperature values.
>>>
>>> It has an involved workaround. Software needs to read the error codes 
>>> for
>>> -40C, 30C, 125C from the efuse for each device & derive a new look up 
>>> table
>>> for adc to temperature conversion. Involved calculating slopes & 
>>> constants
>>> using 3 different straight line equations with adc refernce codes as the
>>> y-axis & error codes in the x-axis.
>>>
>>> -40C to 30C
>>> 30C to 125C
>>> 125C to 150C
>>>
>>> With the above 2 line equations we derive the full look-up table to
>>> workaround the errata i2128 for j721e SoC.
>>
>> Hi Daniel,
>>
>> Any feedback on this series? Let me know.
> 
> There are a few but that would be nit picking and I don't want to 
> postpone this driver any longer.
> 
> How do you want to proceed? Shall I take it through my tree?

Hi Daniel,

Patch 1 & 4 i.e Documentation patch and driver patch can be picked by 
you. I believe Vignesh will take the dts patches.

Vignesh,

Can you confirm?

- Keerthy

> 
> 
