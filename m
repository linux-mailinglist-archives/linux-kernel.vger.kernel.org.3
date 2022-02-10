Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898824B0895
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiBJIi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:38:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiBJIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:38:28 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF5AF38;
        Thu, 10 Feb 2022 00:38:29 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A78DRL010080;
        Thu, 10 Feb 2022 09:38:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=1zfSI2qVlkd+DPa15aeCouFvWPYjc0t4KmVODobT+dw=;
 b=8NDX/79igQXb3CFGUcdjRZFOuzWrAcGI6LkD9S2v8ChBjrmOrA5fVbrYt+sQI0wfxALg
 CKg5sZ6PMwgKD8kWdcCtoMqoxulCSZjbef4snOUas13ZO6JrZH5/YGbcJkTOXPAgzoPF
 6INQei8LL3MeyPU1CxtA3IETwQwIHsZFpgc0UxL0XWYROU9DvZ+iVINkMAbijFg0jD8A
 vWuHWwiaRHnzQDDUsusMfQz0eD5PGbCw4FEdQo8RiDEaTLs1849rXAZFA4niHVA8ATaW
 4TLUD481Xl191IlbVePfFKCBhuXOSQGGCz3iEaKWfMuOK/WDPwEbYkh9Xmthd71gTCpW Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4x268h9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 09:38:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E55210002A;
        Thu, 10 Feb 2022 09:38:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 87C2C2138E0;
        Thu, 10 Feb 2022 09:38:16 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Feb
 2022 09:38:15 +0100
Message-ID: <3d49f72b-3415-ad49-fb9c-dc5a4310c9ce@foss.st.com>
Date:   Thu, 10 Feb 2022 09:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 12/12] ARM: dts: sti: move usb picophy nodes in
 stih410-b2260.dts
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, <patrice.chotard@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211202075105.195664-1-avolmat@me.com>
 <20211202075105.195664-13-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20211202075105.195664-13-avolmat@me.com>
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
> Update usb picophy nodes out of the soc section following the
> related update within the stih410.dtsi file.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih410-b2260.dts | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index c2d3b6de55d0..26d93f26f6d0 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -82,6 +82,14 @@ phy_port1: port@9b2a000 {
>  		};
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
>  		/* Low speed expansion connector */
>  		uart0: serial@9830000 {
> @@ -152,14 +160,6 @@ pwm1: pwm@9510000 {
>  			status = "okay";
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
