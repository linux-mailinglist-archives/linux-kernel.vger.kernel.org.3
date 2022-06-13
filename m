Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E485481B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiFMIPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbiFMIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:15:12 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805B2F0;
        Mon, 13 Jun 2022 01:15:11 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D80q1D026381;
        Mon, 13 Jun 2022 10:14:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=j4qE4CmTOLx19pyEhsVTVJ4dGM7++a3J2NmTTXvsYqk=;
 b=EPUc7+MiS5BXCGfIiySRsWC6NvcAXPwukwv/vxIgWPnuMQx8XwZszulbaKyPkKPUPvsz
 rvDPbpPWfTvOJ0Sb+PFava+1lk6RiaENZoOxO92cDQ7t+URjL2gaoYIdVsRMwZ4MUOnk
 RmnWCy099u4GUQvotA9d9rnm6LNt6wQNju+JWFOpWyIhVflE3BQeCi7lIBPyzFlcglr1
 gs4LCSwIaxsV2yIVTHUEfOLyXoERNmF3TNbdtvwcvuKoVmY2+A4GUYUMy93SSc7SzSVl
 qiUBxl5HxNqZ1vbrtt9zRfJxV9D0+dMFm3RPgAGpRu5RvbklHX+olxIT4xr/69VGssDJ rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gmg6a2jm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 10:14:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E391310002A;
        Mon, 13 Jun 2022 10:14:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DEA23212311;
        Mon, 13 Jun 2022 10:14:56 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.118) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 13 Jun
 2022 10:14:56 +0200
Message-ID: <feca044e-deed-6c93-897f-59ab8ed2ba21@foss.st.com>
Date:   Mon, 13 Jun 2022 10:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] ARM: dts: stm32: fix missing internally connected
 voltage regulator for OSD32MP1
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
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220603094422.2112746-1-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.118]
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

Hi Leonard

On 6/3/22 11:44, Leonard Göhrs wrote:
> According to the OSD32MP1 Power System overview[1] ldo3's input is always
> internally connected to vdd_ddr.
> 
> [1]: https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>   arch/arm/boot/dts/stm32mp15xx-osd32.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> index 6706d8311a66..e997c4953fd1 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> @@ -78,6 +78,7 @@ regulators {
>   			compatible = "st,stpmic1-regulators";
>   
>   			ldo1-supply = <&v3v3>;
> +			ldo3-supply = <&vdd_ddr>;
>   			ldo6-supply = <&v3v3>;
>   			pwr_sw1-supply = <&bst_out>;
>   


Applied on stm32-next.

Thanks.
Alex
