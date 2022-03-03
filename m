Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963CD4CBE8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiCCNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiCCNKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:10:33 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250B816A591;
        Thu,  3 Mar 2022 05:09:46 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2238CPqK032368;
        Thu, 3 Mar 2022 14:09:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pkx2zGWPYrmHsy35xU9yJKQc3yW9y5fEcg/t+W/SnkU=;
 b=sC6ovMPOTEXe+30l/yJflYQQHj+2vmOsf96wQ/rTixDLGP3fvI6Ooh3N3I4kV4d/h7Oe
 KD9FbaawUGGJBOW8Nm5nnzO341bzj3RTmPCs4ButNosY+EsMaGBBjQAJUyAurUkbVCcz
 8gds/mjiSvihkIeyLWHh38jH5KVu8xOGOzqNrVzNuv2xJy0NK4QOFJL40v6CVw9tCZfx
 nbhyHi9C2sWLuQguz2gzp+gdjE5fUpOWqyGIdRWvaAWhPjxG63IK5c5T+22OLQnAkhaS
 S9i1sXco1nWZBuLWsLZabmKXG32UuefhfI9Z2IlfU3JaldcjK0qwjY4X7Aey2u2bpejI OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ejsy7hw3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 14:09:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 70197100034;
        Thu,  3 Mar 2022 14:09:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A18A22178A;
        Thu,  3 Mar 2022 14:09:18 +0100 (CET)
Received: from [10.201.22.79] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 3 Mar
 2022 14:09:17 +0100
Message-ID: <65581f3a-3ae6-2dd3-7571-1e64982b5f50@foss.st.com>
Date:   Thu, 3 Mar 2022 14:09:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Linux-stm32] [PATCH v2 12/13] ARM: dts: stm32: enable optee
 firmware and SCMI support on STM32MP13
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
 <20220225133137.813919-13-gabriel.fernandez@foss.st.com>
 <1d90078d-e27f-539d-d010-78a3c4da565a@pengutronix.de>
From:   Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <1d90078d-e27f-539d-d010-78a3c4da565a@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/22 16:13, Ahmad Fatoum wrote:
> Hello Gabriel,
>
> On 25.02.22 14:31, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Enable optee and SCMI clocks support.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
>>   arch/arm/boot/dts/stm32mp131.dtsi | 37 +++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
>> index 262de4eeb4ed..78eac53224d4 100644
>> --- a/arch/arm/boot/dts/stm32mp131.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
>> @@ -27,6 +27,43 @@ arm-pmu {
>>   		interrupt-parent = <&intc>;
>>   	};
>>   
>> +	scmi_sram: sram@2ffff000 {
>> +		compatible = "mmio-sram";
>> +		reg = <0x2ffff000 0x1000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0x2ffff000 0x1000>;
>> +
>> +		scmi_shm: scmi_shm@0 {
>> +			compatible = "arm,scmi-shmem";
>> +			reg = <0 0x80>;
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		optee {
>> +			method = "smc";
>> +			compatible = "linaro,optee-tz";
>> +		};
>> +
>> +		scmi: scmi {
>> +			compatible = "linaro,scmi-optee";
> This compatible doesn't seem to be documented upstream. I am looking at v5.17-rc5.
> Do you have a reference detailing the difference between this conduit and
> plain arm,scmi-smc (as used with TF-A on the STM32MP151).
>
> Cheers,
> Ahmad

Hi

Ahmad,

it's on going.

https://lore.kernel.org/linux-arm-kernel/20211029102118.GG6526@e120937-lin/T/#mf46c83f0aadce3061ee93fa22159405f38d881a0

>
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			linaro,optee-channel-id = <0>;
>> +			shmem = <&scmi_shm>;
>> +
>> +			scmi_clk: protocol@14 {
>> +				reg = <0x14>;
>> +				#clock-cells = <1>;
>> +			};
>> +
>> +			scmi_reset: protocol@16 {
>> +				reg = <0x16>;
>> +				#reset-cells = <1>;
>> +			};
>> +		};
>> +	};
>>   	clocks {
>>   		clk_axi: clk-axi {
>>   			#clock-cells = <0>;
>
