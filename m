Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55865A602A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiH3KEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiH3KDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:03:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2284B499;
        Tue, 30 Aug 2022 03:01:45 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UA1P1n072699;
        Tue, 30 Aug 2022 05:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661853685;
        bh=rA0l0kMxcWsrdBCeVjS7sz/SB9EJAgl9ijOnOgpt8IM=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=cjlEMu5KXVIhDxBUD+Sjna5+nc+4G8L5ivvJzO/jbd2hYZJpHo6U8lohN7JtSv0yu
         W9BTeMcVvqi6X3YR+KQgkAhqu3zkgzE906aBEsqi64oD8OWYYDzAVbo2a1zN4YrV/u
         ejCnKap4nUCvHLzosSwzrsLs5ZWXCJyfPH/AJzbU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UA1Poj115432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 05:01:25 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 05:01:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 05:01:24 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UA1L0G020617;
        Tue, 30 Aug 2022 05:01:22 -0500
Message-ID: <c6285157-480d-d8f6-f11f-25604455ece0@ti.com>
Date:   Tue, 30 Aug 2022 15:31:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] arm64: dts: ti: k3-am65-main: Do not exclusively
 claim SA2UL
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220823001136.10944-1-afd@ti.com>
 <20220823001136.10944-3-afd@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20220823001136.10944-3-afd@ti.com>
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
> The SA2UL hardware is also used by SYSFW and OP-TEE. It should be
> requested using the shared TI-SCI flags instead of the exclusive
> flags or the request will fail.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 165f53bd058b..4005a73cfea9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -112,7 +112,7 @@ main_uart2: serial@2820000 {
>   	crypto: crypto@4e00000 {
>   		compatible = "ti,am654-sa2ul";
>   		reg = <0x0 0x4e00000 0x0 0x1200>;
> -		power-domains = <&k3_pds 136 TI_SCI_PD_EXCLUSIVE>;
> +		power-domains = <&k3_pds 136 TI_SCI_PD_SHARED>;
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges = <0x0 0x04e00000 0x00 0x04e00000 0x0 0x30000>;

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

