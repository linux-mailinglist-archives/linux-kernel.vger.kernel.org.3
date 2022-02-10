Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253644B096F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiBJJ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:27:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiBJJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:27:07 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A9A1039;
        Thu, 10 Feb 2022 01:27:09 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A74Wqe017289;
        Thu, 10 Feb 2022 09:36:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=h3BIBiAZxBPqsCaQuDCWXGUPrAUzursUIqsuIjIzP1c=;
 b=AIYmm9kRnOKEb3hrt8TowUTMDoPh4h0ZycwhNBOqk9VrqYh9jxF5thCkIqP4h3dZUHQW
 Z72/XnhZIHGjfZ3cAlr+vNh9Q1AnzNgOyL9+aVoP7Jh6ETLk+v+MF3p2Pebt4+c1+1sJ
 fFy6DENVfUZAE97twlFCieybW1YdlEqHLYBkSSsFEYyQ1A3xta2qjxjIX1tQIhxKX1II
 RIHBjq6P4chlSSisE/YG0W2xu4KS01QMrat7gHpyj+xeA9Xe5Chfa3oJlOr/ZVQ137/U
 CYV+F7q7yiwGKd0fbspOMO3Giyfq95fBqR9TzBilJFNAxd7IG+Gvpo7/m3/pUf4vdTLK 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4x0c0jcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 09:36:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33F8410002A;
        Thu, 10 Feb 2022 09:36:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2BEBC2138DE;
        Thu, 10 Feb 2022 09:36:57 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Feb
 2022 09:36:56 +0100
Message-ID: <d17800cd-bb7b-e59a-c8a5-afbd6e3e0c3d@foss.st.com>
Date:   Thu, 10 Feb 2022 09:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 05/12] ARM: dts: sti: update stih410-b2260 following
 stih407-family DT update
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, <patrice.chotard@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211202075105.195664-1-avolmat@me.com>
 <20211202075105.195664-6-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20211202075105.195664-6-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
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

On 12/2/21 08:50, Alain Volmat wrote:
> Put of the miphy28lp_phy node out of the soc section following similar
> update within stih407-family.dtsi file update.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih410-b2260.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index 9d579c16c295..c2d3b6de55d0 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -75,6 +75,13 @@ codec {
>  		};
>  	};
>  
> +	miphy28lp_phy: miphy28lp {
> +
> +		phy_port1: port@9b2a000 {
> +			st,osc-force-ext;
> +		};
> +	};
> +
>  	soc {
>  		/* Low speed expansion connector */
>  		uart0: serial@9830000 {
> @@ -196,13 +203,6 @@ hdmiddc: i2c@9541000 {
>  			status = "okay";
>  		};
>  
> -		miphy28lp_phy: miphy28lp@0 {
> -
> -			phy_port1: port@9b2a000 {
> -				st,osc-force-ext;
> -			};
> -		};
> -
>  		sata1: sata@9b28000 {
>  			status = "okay";
>  		};
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
