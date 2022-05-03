Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634245185F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiECNxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiECNxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:53:16 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008E37A3C;
        Tue,  3 May 2022 06:49:41 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243CF2F8025140;
        Tue, 3 May 2022 15:49:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Ra7EvUw+tATnkWZ+cGUbiubTZMp2au3XJ8odDlXQX2g=;
 b=rXb2NQhI6gTIcQ0RAFkQhyco2dK07doBDDcm8DTysaEDrPLpOWZ+xM8xxuY6uTW6IKfm
 J+CRuOWIl2NQmiqeDSDa1/dX4o77QBmPqglRRlBn2A5sTSygdOWUeMfuERXSypxaCPC4
 Xqs2x1JXbYrt5i9f+iGY2w0w6jH3Yii4HWzy+VD8ze/xp18FliW9KGzLTY0W2tA6bYSm
 I4qnz2fwSk/OCFLksm5P+kgTHQ+3/lAqkYOKLzChm2gTqd+TQJ41bmKrAp9Q3hkExRRe
 UiuHPtN4mT8N28N5isT/66j8Kg7q+Z02GH8coa+9IxuwNjYd2XShuDNMx95z1P1VU+wx sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthjpq9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 15:49:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4480510002A;
        Tue,  3 May 2022 15:49:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3D80622178D;
        Tue,  3 May 2022 15:49:27 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.44) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 3 May
 2022 15:49:26 +0200
Message-ID: <4cb68dce-b334-627f-d45d-62b9a10dab6c@foss.st.com>
Date:   Tue, 3 May 2022 15:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] ARM: dts: stm32: add UserPA13 button on
 stm32mp135f-dk
Content-Language: en-US
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220503094133.502487-1-fabien.dessenne@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220503094133.502487-1-fabien.dessenne@foss.st.com>
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
> The PA13 user button is connected to the PA13 pin of the stm32mp135f-dk
> board. It requires an internal pull-up configuration.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp135f-dk.dts | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
> index 65acee0f68b7..09d6226d598f 100644
> --- a/arch/arm/boot/dts/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
> @@ -7,6 +7,7 @@
>   /dts-v1/;
>   
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>   #include <dt-bindings/leds/common.h>
>   #include "stm32mp135.dtsi"
>   #include "stm32mp13xf.dtsi"
> @@ -25,6 +26,16 @@ memory@c0000000 {
>   		reg = <0xc0000000 0x20000000>;
>   	};
>   
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		user-pa13 {
> +			label = "User-PA13";
> +			linux,code = <BTN_1>;
> +			gpios = <&gpioa 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   
Applied on stm32-next.

Thanks.
Alex
