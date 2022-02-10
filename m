Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494474B0893
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiBJIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:37:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiBJIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:37:31 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D3F01;
        Thu, 10 Feb 2022 00:37:33 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A76cqa015959;
        Thu, 10 Feb 2022 09:37:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=A/0sdX1EYOU+QxwJibhKgHsJ8pFpKN3p77dJmbpBruE=;
 b=aV4vESRMaZfTEPToGtuq1SSYFyzxpI/tJi2bAcPPDb3BNSWzX6a3Uz+jqJZyIYN5hbZA
 3kRnW+k0t18OeDGWehQX/alZJlNP1/eFKDIjZ8CvhHUJ7Zv9eAn0cVge7cdJObRyxga0
 2p9O+09ca8XitBRoz6pQqnLrvXW8ILUNMaNpxlvw9DVJhkPZkAg5YCU1rxa6IkxuM3vl
 EPftLpioTooyftO4eDBKSxGAX6B5rigDBZ/DP51rED9QgJbiOXJD9RtRoXFlxK+ls2Xu
 dZ8SL4yQaJoc+4vCcKphtlKSplaLBKmOPHRdxhDe06Onm+mPqL7PdVRmd4AnHPHM40U4 qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4x1a8h4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 09:37:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9586010002A;
        Thu, 10 Feb 2022 09:37:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E9162138E0;
        Thu, 10 Feb 2022 09:37:18 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Feb
 2022 09:37:17 +0100
Message-ID: <5164af76-18e9-e6ae-87c6-fc096d88a69e@foss.st.com>
Date:   Thu, 10 Feb 2022 09:37:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 07/12] ARM: dts: sti: update stihxxx-b2120 following
 stih407-family DT update
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, <patrice.chotard@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211202075105.195664-1-avolmat@me.com>
 <20211202075105.195664-8-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20211202075105.195664-8-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_03,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 12/2/21 08:51, Alain Volmat wrote:
> Put of the miphy28lp_phy node out of the soc section following similar
> update within stih407-family.dtsi file update.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stihxxx-b2120.dtsi | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index d051f080e52e..4c72dedcd1be 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -71,6 +71,17 @@ codec {
>  		};
>  	};
>  
> +	miphy28lp_phy: miphy28lp {
> +
> +		phy_port0: port@9b22000 {
> +			st,osc-rdy;
> +		};
> +
> +		phy_port1: port@9b2a000 {
> +			st,osc-force-ext;
> +		};
> +	};
> +
>  	soc {
>  		sbc_serial0: serial@9530000 {
>  			status = "okay";
> @@ -128,17 +139,6 @@ hdmiddc: i2c@9541000 {
>  			st,i2c-min-sda-pulse-width-us = <5>;
>  		};
>  
> -		miphy28lp_phy: miphy28lp@0 {
> -
> -			phy_port0: port@9b22000 {
> -				st,osc-rdy;
> -			};
> -
> -			phy_port1: port@9b2a000 {
> -				st,osc-force-ext;
> -			};
> -		};
> -
>  		st_dwc3: dwc3@8f94000 {
>  			status = "okay";
>  		};
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
