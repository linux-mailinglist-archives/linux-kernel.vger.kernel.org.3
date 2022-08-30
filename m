Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5997F5A6009
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiH3KAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiH3J75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:59:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6A4E114F;
        Tue, 30 Aug 2022 02:58:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27U9vtBW095771;
        Tue, 30 Aug 2022 04:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661853475;
        bh=6Q7ULugHo37nln8nzyLFaaxX9W7rkL2u1jeBIGNhYso=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=sEqpaMWAnIfCX1u2Oy3hJDalwxz5prIGOJTiW5bGfzq1eo3F7d6buhC0luHoBpgv3
         PNjLxdQ+J1Q7YQcdffljGgNjrN0NDnHU0l3BjZv0Wu0kp8+qy31gT9HeUjNi1ytu6G
         Ija0FbjpNWiRaakwxbbFGaUvNaTVC76HtrTppSno=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27U9vtFV001580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 04:57:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 04:57:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 04:57:54 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27U9vpMD128617;
        Tue, 30 Aug 2022 04:57:52 -0500
Message-ID: <04ea4219-d28b-9b91-5d7f-7da777e5c08f@ti.com>
Date:   Tue, 30 Aug 2022 15:27:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3-am65-main: Move SA2UL to unused
 PSI-L thread ID
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220823001136.10944-1-afd@ti.com>
 <20220823001136.10944-2-afd@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20220823001136.10944-2-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/22 05:41, Andrew Davis wrote:
> The first TX and first two RX PSI-L threads for SA2UL are used
> by SYSFW on High Security(HS) devices. Use the next available
> threads to prevent resource allocation conflicts.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index b3e714e1abed..165f53bd058b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -117,8 +117,8 @@ crypto: crypto@4e00000 {
>   		#size-cells = <2>;
>   		ranges = <0x0 0x04e00000 0x00 0x04e00000 0x0 0x30000>;
>   
> -		dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
> -				<&main_udmap 0x4001>;
> +		dmas = <&main_udmap 0xc001>, <&main_udmap 0x4002>,
> +				<&main_udmap 0x4003>;
>   		dma-names = "tx", "rx1", "rx2";
>   		dma-coherent;
>   

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

