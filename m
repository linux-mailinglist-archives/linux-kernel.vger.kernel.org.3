Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD58F5480B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiFMHkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiFMHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:39:59 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177011CB3E;
        Mon, 13 Jun 2022 00:39:57 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D1VhsU024403;
        Mon, 13 Jun 2022 09:39:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=eMD4gP7HheN2y7I0fwnJFpYAhffwgcF67MuXLN0bXkw=;
 b=IY0NAndAlu37OfYccLttpyQU5jwiVStvsTHtvOAD8LXiQfl8hPtsq1dFBwYsnqWCNuWP
 zTzU+JmI437UKEftyCrsxmdSSmVGixY3npDmnVXTA1ezMhomQsB3woa0/RxxY36h22Y7
 0IurH1WgnsjCMQnHfL4wwFMgtmNYdNSGT4WhejVz1CGwB0sha1B8iM43z8wVKVoUqFZ2
 ljdota4CZPgl1u40fIQrkacDhQU7V0plRen1Y1ByrahXj2MbeHCVF238zG2PDK0HTibz
 dvobPQUna/ttjcGLLPpTGqXj2BWGr6ER+EpuGRxCf6EA9V5Iips7D5hqXL4tUtYNtF5d cQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gmhxj1wda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 09:39:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BC4610002A;
        Mon, 13 Jun 2022 09:39:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36F25211616;
        Mon, 13 Jun 2022 09:39:48 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.116) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 13 Jun
 2022 09:39:47 +0200
Message-ID: <5b3e7b59-5853-a466-11de-22ef6e80b0d6@foss.st.com>
Date:   Mon, 13 Jun 2022 09:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] ARM: dts: stm32: remove the IPCC "wakeup" IRQ on
 stm32mp151
Content-Language: en-US
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20220503145606.525875-1-fabien.dessenne@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220503145606.525875-1-fabien.dessenne@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Fabien

On 5/3/22 16:56, Fabien Dessenne wrote:
> The stm32 ipcc mailbox driver supports only two interrupts (rx and tx), so
> remove the unsupported "wakeup" one.
> Note that the EXTI interrupt 61 has two roles : it is hierarchically linked
> to the GIC IPCC "rx" interrupt, and it acts as a wakeup source.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 7fdc324b3cf9..edc0a1641c7b 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1117,10 +1117,9 @@ ipcc: mailbox@4c001000 {
>   			reg = <0x4c001000 0x400>;
>   			st,proc-id = <0>;
>   			interrupts-extended =
> -				<&intc GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> -				<&intc GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> -				<&exti 61 1>;
> -			interrupt-names = "rx", "tx", "wakeup";
> +				<&exti 61 1>,
> +				<&intc GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "rx", "tx";
>   			clocks = <&rcc IPCC>;
>   			wakeup-source;
>   			status = "disabled";

Applied on stm32-next.

Thanks.
Alex
