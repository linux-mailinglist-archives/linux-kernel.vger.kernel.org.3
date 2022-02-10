Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010654B088F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiBJIhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:37:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiBJIhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:37:39 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 00:37:41 PST
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61C1A4;
        Thu, 10 Feb 2022 00:37:40 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A71bUJ029172;
        Thu, 10 Feb 2022 09:37:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=BoDZ6GknbuIy0l7D85+ruOCne3Xrx9q0A41HVlrYsJM=;
 b=xZ0n/i6LTgcrSUPs7abvZDDqcMjhEV6pqeXfj1EWn9G9E73NFAJiFE21yTV7n2e/A/Uy
 1D+PCEGE4TIFB2UeBc1T1L2kRvrpFvervNr/8m0C/NiUDaoFpsjXv9agcoLV/eIINVAv
 qLWEUXddSQsbIz4OQf14t4lRGBQB8mTe4mjb0n2kC14v+fs4z+0x8mPD24WDTQ3QuiB6
 oNshoZYJQVw0KD0flWMguaqRrQz9PKOMzRCzYGd/nkcpaepT4U24PkJ3IBrrVhzVUj+2
 CUaGZL1lVa6wARamQeB1VxuTIpb98AX5/z0t+eVLekWxnz4xXBjgl5XiShUgbvnf8feV dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4wy1gjyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 09:37:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D817100034;
        Thu, 10 Feb 2022 09:37:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 86A962138E6;
        Thu, 10 Feb 2022 09:37:29 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Feb
 2022 09:37:28 +0100
Message-ID: <3c0e16ff-26cd-f00d-26ea-ff2e065c32a2@foss.st.com>
Date:   Thu, 10 Feb 2022 09:37:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 08/12] ARM: dts: sti: remove delta node from stih410.dtsi
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, <patrice.chotard@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211202075105.195664-1-avolmat@me.com>
 <20211202075105.195664-9-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20211202075105.195664-9-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
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
> The delta0 node within stih410.dtsi is identical to the
> one already written within stih407-family.dtsi and included
> within stih410.dtsi.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih410.dtsi | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
> index 6d847019c554..fe83d9a522bf 100644
> --- a/arch/arm/boot/dts/stih410.dtsi
> +++ b/arch/arm/boot/dts/stih410.dtsi
> @@ -274,16 +274,6 @@ thermal@91a0000 {
>  			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> -		delta0@0 {
> -			compatible = "st,st-delta";
> -			clock-names = "delta",
> -				      "delta-st231",
> -				      "delta-flash-promip";
> -			clocks = <&clk_s_c0_flexgen CLK_VID_DMU>,
> -				 <&clk_s_c0_flexgen CLK_ST231_DMU>,
> -				 <&clk_s_c0_flexgen CLK_FLASH_PROMIP>;
> -		};
> -
>  		sti-cec@94a087c {
>  			compatible = "st,stih-cec";
>  			reg = <0x94a087c 0x64>;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
