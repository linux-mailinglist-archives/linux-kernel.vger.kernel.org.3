Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE304B0900
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiBJI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:57:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiBJI5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:57:20 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5E41091;
        Thu, 10 Feb 2022 00:57:21 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A74Jtq016680;
        Thu, 10 Feb 2022 09:57:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=TlvWNHfpNPtRw0cITsExVTaGaglDP3mqI5ghOnwVXLI=;
 b=CCaGg/1+HbopP7CeJ298uUoW5ejCzUglpAH7A5xO6nLoI8fa3I/Xzn9Yc8gFThMWC88t
 9eePWeGcx5S+St4tmdaL2q3+CwowR8SNjJFeKm6FIojq1LJrv+BLpfeozdToDFSuzoEP
 r1xLB4lMy3LZse1BpiRrP0+ISP1hdn+Ykxxl4H5blxEGv/q+rLHtgyUp/odwC6O/5Zv6
 iQoeDICtCqu0aGgU2y7aKv88k2jnPx0RK7Gn3HsGJmKYqdf20SlEq7Pqy0ETGFH3ak1q
 rTl5Up7psZqhX9w8XZTbvRnItwneEhRNbRBvxXxCfp+xEDGZIqibS994mCcONf4oXT0N LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4x0c0phb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 09:57:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E34BD10002A;
        Thu, 10 Feb 2022 09:57:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC3C8214D3C;
        Thu, 10 Feb 2022 09:57:07 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Feb
 2022 09:57:06 +0100
Message-ID: <a8bef34c-e33b-b482-497c-445f5618fb7b@foss.st.com>
Date:   Thu, 10 Feb 2022 09:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 11/12] ARM: dts: sti: move usb picophy nodes in
 stih410-b2120.dts
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, <patrice.chotard@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211202075105.195664-1-avolmat@me.com>
 <20211202075105.195664-12-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20211202075105.195664-12-avolmat@me.com>
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

HI Alain

On 12/2/21 08:51, Alain Volmat wrote:
> Update usb picophy nodes out of the soc section following the
> related update within the stih410.dtsi file.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih410-b2120.dts | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
> index 9d3b118f5f0f..538ff98ca1b1 100644
> --- a/arch/arm/boot/dts/stih410-b2120.dts
> +++ b/arch/arm/boot/dts/stih410-b2120.dts
> @@ -24,6 +24,14 @@ aliases {
>  		ethernet0 = &ethernet0;
>  	};
>  
> +	usb2_picophy1: phy2 {
> +		status = "okay";
> +	};
> +
> +	usb2_picophy2: phy3 {
> +		status = "okay";
> +	};
> +
>  	soc {
>  
>  		mmc0: sdhci@9060000 {
> @@ -33,14 +41,6 @@ mmc0: sdhci@9060000 {
>  			sd-uhs-ddr50;
>  		};
>  
> -		usb2_picophy1: phy2@0 {
> -			status = "okay";
> -		};
> -
> -		usb2_picophy2: phy3@0 {
> -			status = "okay";
> -		};
> -
>  		ohci0: usb@9a03c00 {
>  			status = "okay";
>  		};
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
