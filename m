Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE95185EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiECNwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiECNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:52:13 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD101344CA;
        Tue,  3 May 2022 06:48:40 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2438jP1D016032;
        Tue, 3 May 2022 15:48:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=hXmlQLiGgHE3zXlZsvuOxd5ero+HINkzl0ATZxB73S8=;
 b=qqJhGdn2ln5gzX5nuW5LArZVdzwk7qI5sCEromTOdRQaQoBYROVqTtcldMiumqH+KX0e
 ao+nz9JTsL6w0wFvU0Rr/UDe5h5XNo6+tnNXi4MIVJsvE+AeJce4HM2fwmN/2dJSQGcu
 Zi2OnoSaONywy/xu0xpHTeNsIgjfQuVl43PrzR1IOWFjKAZ9yJp70tJ3yA6lbctE47/P
 yLrktksgYx0C7M4lPMtK5Or8uGqdMqQqMWGx4bkaOJILAKZ6Mb/GB95owHmQfTM5eIOr
 bUeqdN2myH9F1IZwjgA7E8WV74v8+fLBCowO+N3EbD0piyv9+EJnQqN06ugLXmb8ZRRG +g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frv0g7ddy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 15:48:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B96CF10002A;
        Tue,  3 May 2022 15:48:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B25CC22178B;
        Tue,  3 May 2022 15:48:30 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.44) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 3 May
 2022 15:48:29 +0200
Message-ID: <e1934106-85cb-58ab-83db-a4394982f36c@foss.st.com>
Date:   Tue, 3 May 2022 15:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ARM: dts: stm32: add blue led (Linux heartbeat) on
 stm32mp135f-dk
Content-Language: en-US
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220503094124.502416-1-fabien.dessenne@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220503094124.502416-1-fabien.dessenne@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_05,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 11:41, Fabien Dessenne wrote:
> The blue led (Linux heartbeat) is connected to the PA14 pin of the
> stm32mp135f-dk board.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp135f-dk.dts | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
> index aefa25ee897d..65acee0f68b7 100644
> --- a/arch/arm/boot/dts/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
> @@ -6,6 +6,8 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>   #include "stm32mp135.dtsi"
>   #include "stm32mp13xf.dtsi"
>   #include "stm32mp13-pinctrl.dtsi"
> @@ -23,6 +25,18 @@ memory@c0000000 {
>   		reg = <0xc0000000 0x20000000>;
>   	};
>   
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-blue {
> +			function = LED_FUNCTION_HEARTBEAT;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&gpioa 14 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "off";
> +		};
> +	};
> +
>   	vdd_sd: vdd-sd {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vdd_sd";
Applied on stm32-next.

Thanks.
Alex
