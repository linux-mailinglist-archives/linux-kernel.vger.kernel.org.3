Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AACB5481E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbiFMIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbiFMIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:15:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E2D53;
        Mon, 13 Jun 2022 01:15:22 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D2DrHF009489;
        Mon, 13 Jun 2022 10:15:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=2jPMFCFi0BBGHxBZTXR7BgbxjmNy1phYwPLYn9sIx+I=;
 b=fycCi7tuCzPCsk/AGUc3qGuLzwcUAF+6E5uQ4mlnI0fz2Ixwd1blkhTmZEjxRE0HfYWY
 igQmzsumf53gQ5ID3fFg/+KCJcEv+F0IY/dY3MXnJcEkHpJAlo+Oo0mLf4+VYlNuTIDw
 w9j4sXnLzKD5KOSaliD5KAlJJcgI6LbDvYrQBxcfnI/lKyW8ANM9/R0GZYYTZcg9zgGD
 32SoLa02gf+LaUAg4QMom0Zf74qsEgFMlCxEtTqXe+33eo47/chHZGRSG1XgmDRKdx3B
 c0YNScwKX/VfVO0B4TecF81XCdeugQk3X68PJ63E0R3DVDqjdhA8vHRY1Oe0zbKFIglK ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gmg6a2jp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 10:15:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FA7610002A;
        Mon, 13 Jun 2022 10:15:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6B1B72128AD;
        Mon, 13 Jun 2022 10:15:12 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.116) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 13 Jun
 2022 10:15:10 +0200
Message-ID: <cd9121fb-4953-2a06-5a48-728dc4ca6caa@foss.st.com>
Date:   Mon, 13 Jun 2022 10:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] ARM: dts: stm32: correct vcc-supply for eeprom on
 stm32mp15xx-osd32
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <kernel@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220603094422.2112746-1-l.goehrs@pengutronix.de>
 <20220603094422.2112746-2-l.goehrs@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220603094422.2112746-2-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_02,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 6/3/22 11:44, Leonard Göhrs wrote:
> According to the OSD32MP1 Power System overview[1] the EEPROM is connected to
> the VDD line and not to some single-purpose fixed regulator.
> Set the EEPROM supply according to the diagram to eliminate this parent-less
> regulator.
> 
> [1]: https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>   arch/arm/boot/dts/stm32mp15xx-osd32.dtsi | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> index e997c4953fd1..935b7084b5a2 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> @@ -50,12 +50,6 @@ retram: retram@38000000 {
>   			no-map;
>   		};
>   	};
> -
> -	reg_sip_eeprom: regulator_eeprom {
> -		compatible = "regulator-fixed";
> -		regulator-name = "sip_eeprom";
> -		regulator-always-on;
> -	};
>   };
>   
>   &i2c4 {
> @@ -204,7 +198,7 @@ pmic_watchdog: watchdog {
>   
>   	sip_eeprom: eeprom@50 {
>   		compatible = "atmel,24c32";
> -		vcc-supply = <&reg_sip_eeprom>;
> +		vcc-supply = <&vdd>;
>   		reg = <0x50>;
>   	};
>   };

Applied on stm32-next.

Thanks.
Alex
