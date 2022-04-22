Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8C50B830
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447870AbiDVNTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447859AbiDVNTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:19:22 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77522BE2;
        Fri, 22 Apr 2022 06:16:27 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23M9OBxR028996;
        Fri, 22 Apr 2022 15:16:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=HKrOnxEaSGOfdkC3CfqMbJmY69fcKr8J+pM8Xhq9o2k=;
 b=YhMwq6LFh+zd1r5ZRUnqrf5yp9R0/AnPP1s3+MLZK21EdCoFsFJbzpWQo/Ld9NzZX2WC
 w0MHeC8lt8e0PHpMcg7Wy6S68G/3g+7B2o22ij/ajXYN/vRKvhEA7y9EIpVW35N4Sx0y
 ytoW9Gl7l32HtFn95iQJS8J3WMNbAOwXNcj4fVIqVgNmcbdJYulgdPj97DANmlvQn3ys
 11kXgCM8fMXccbQRmQZmOIRIAGOD8aG5WYtDXFvrg6bCBRE0GOMvH3+WtVCilvAWTbcL
 O3by7a6J0nbjvWpXoT+7TXe4m771Gvac2D3xDhjBsXTjCFPgYHOy2Eu+II/uK4slJApm 6g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fk4fvf1r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 15:16:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 880AD100034;
        Fri, 22 Apr 2022 15:16:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 80D9721E663;
        Fri, 22 Apr 2022 15:16:03 +0200 (CEST)
Received: from [10.201.21.16] (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 22 Apr
 2022 15:16:02 +0200
Message-ID: <3a48ae9b-b8d9-138e-ec19-3512164bfc80@foss.st.com>
Date:   Fri, 22 Apr 2022 15:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND v3 12/13] ARM: dts: stm32: enable optee firmware
 and SCMI support on STM32MP13
Content-Language: en-US
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220316131000.9874-1-gabriel.fernandez@foss.st.com>
 <20220316131000.9874-13-gabriel.fernandez@foss.st.com>
 <31f5d4af-5a4f-e683-c50e-d59b63135a99@foss.st.com>
From:   Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <31f5d4af-5a4f-e683-c50e-d59b63135a99@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_03,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/22 17:23, Alexandre TORGUE wrote:
> Hi Gabriel
>
> On 3/16/22 14:09, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Enable optee and SCMI clocks support.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
>>   arch/arm/boot/dts/stm32mp131.dtsi | 37 +++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi 
>> b/arch/arm/boot/dts/stm32mp131.dtsi
>> index 262de4eeb4ed..78eac53224d4 100644
>> --- a/arch/arm/boot/dts/stm32mp131.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
>> @@ -27,6 +27,43 @@ arm-pmu {
>>           interrupt-parent = <&intc>;
>>       };
>>   +    scmi_sram: sram@2ffff000 {
>> +        compatible = "mmio-sram";
>> +        reg = <0x2ffff000 0x1000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0 0x2ffff000 0x1000>;
>> +
>> +        scmi_shm: scmi_shm@0 {
>
> rename to scmi-sram@0 to match with yaml description

ok


>
>> +            compatible = "arm,scmi-shmem";
>> +            reg = <0 0x80>;
>> +        };
>> +    };
>
> Can you move this sram node in Soc{ please?

ok

Thank's Alex


>
>> +
>> +    firmware {
>> +        optee {
>> +            method = "smc";
>> +            compatible = "linaro,optee-tz";
>> +        };
>> +
>> +        scmi: scmi {
>> +            compatible = "linaro,scmi-optee";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            linaro,optee-channel-id = <0>;
>> +            shmem = <&scmi_shm>;
>> +
>> +            scmi_clk: protocol@14 {
>> +                reg = <0x14>;
>> +                #clock-cells = <1>;
>> +            };
>> +
>> +            scmi_reset: protocol@16 {
>> +                reg = <0x16>;
>> +                #reset-cells = <1>;
>> +            };
>> +        };
>> +    };
>>       clocks {
>>           clk_axi: clk-axi {
>>               #clock-cells = <0>;
>
