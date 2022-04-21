Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9FC50A3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390032AbiDUP0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiDUP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:26:42 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE1141316;
        Thu, 21 Apr 2022 08:23:52 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23LAfLVF028198;
        Thu, 21 Apr 2022 17:23:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=DplC3BzhyblI5Lxwm3NDiSXDYLPoE+n3uwb7Qwcogf0=;
 b=Pr9UPBN43blI3MNuBC4q4QuEx+wjppGjNYhPZqQYk/1eq6g/vma3OR/vcrxy2Te+1ZBS
 ABJ91MHl8SK5OqbLd2FHybIoXbms1DOCAFPJAfeB37ByfARyB4bSdFZCzL1Nzc0MLrjx
 gDbwizdZjpVr+YwnNItyW86rOMvuZBd7Oky6SurFkkswm9rGR1LWHfOTrX55uAvh7AS/
 kXcSq+gdVqXdWX63VApZGvwk8PI11iPvC+QwuENM8ciYUFahPVyxb4XfZ3mEf9KDAAOj
 RraVpB3D/tdGVA7hslZl+bobogT/06SMO+FMEvQrK7YdLuf9fVlCLUOus4Kuo1vnPxUy 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ffpqh3tk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 17:23:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F66E10002A;
        Thu, 21 Apr 2022 17:23:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A5D322ECF6;
        Thu, 21 Apr 2022 17:23:28 +0200 (CEST)
Received: from [10.48.0.142] (10.75.127.45) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 21 Apr
 2022 17:23:27 +0200
Message-ID: <31f5d4af-5a4f-e683-c50e-d59b63135a99@foss.st.com>
Date:   Thu, 21 Apr 2022 17:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND v3 12/13] ARM: dts: stm32: enable optee firmware
 and SCMI support on STM32MP13
Content-Language: en-US
To:     <gabriel.fernandez@foss.st.com>,
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
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220316131000.9874-13-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_02,2022-04-21_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel

On 3/16/22 14:09, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Enable optee and SCMI clocks support.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp131.dtsi | 37 +++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> index 262de4eeb4ed..78eac53224d4 100644
> --- a/arch/arm/boot/dts/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> @@ -27,6 +27,43 @@ arm-pmu {
>   		interrupt-parent = <&intc>;
>   	};
>   
> +	scmi_sram: sram@2ffff000 {
> +		compatible = "mmio-sram";
> +		reg = <0x2ffff000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x2ffff000 0x1000>;
> +
> +		scmi_shm: scmi_shm@0 {

rename to scmi-sram@0 to match with yaml description

> +			compatible = "arm,scmi-shmem";
> +			reg = <0 0x80>;
> +		};
> +	};

Can you move this sram node in Soc{ please?

> +
> +	firmware {
> +		optee {
> +			method = "smc";
> +			compatible = "linaro,optee-tz";
> +		};
> +
> +		scmi: scmi {
> +			compatible = "linaro,scmi-optee";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			linaro,optee-channel-id = <0>;
> +			shmem = <&scmi_shm>;
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +
> +			scmi_reset: protocol@16 {
> +				reg = <0x16>;
> +				#reset-cells = <1>;
> +			};
> +		};
> +	};
>   	clocks {
>   		clk_axi: clk-axi {
>   			#clock-cells = <0>;

