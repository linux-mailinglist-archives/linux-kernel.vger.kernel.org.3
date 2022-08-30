Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0275A5FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiH3Jyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH3Jyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:54:32 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CD0C0E6E;
        Tue, 30 Aug 2022 02:54:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27U9sG2Z104476;
        Tue, 30 Aug 2022 04:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661853256;
        bh=RmNV7HcetEbUAooGy8C1avwiLm6r1H5yjogMVC6bEww=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=sCK5iK5S6F3BV7Zc1DNRvkHJeHoFTAeuX6c2vWDzbIo5f6nH45TEV/3koF0wIriGE
         tMKUZ+mFbjON43tSp42l5NfYgJUaG1jg4N56HTLrk8kx3tzYVjaKpDgSx8QtrSn53w
         BwEKPbcn8Qv+BO4PzEbn6xvb7ejdwEzRYRuHrguY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27U9sGh5011546
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 04:54:16 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 04:54:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 04:54:15 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27U9sCA0094080;
        Tue, 30 Aug 2022 04:54:13 -0500
Message-ID: <420e481d-0c91-1f0b-ea72-3a505a04330d@ti.com>
Date:   Tue, 30 Aug 2022 15:24:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65-main: Disable RNG node
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220823001136.10944-1-afd@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20220823001136.10944-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/22 05:41, Andrew Davis wrote:
> The hardware random number generator is used by OP-TEE and is access is
> denied to other users with SoC level bus firewalls. Any access to this
> device from Linux will result in firewall errors.
> 
> We could remove this node, but it is still valid device description,
> and it is possible it could be re-enabled in the bootloader if OP-TEE
> is not used. So only disable this node for now.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> 
> Changes from v1:
>   - Added comment in DT
>   - Explained why it is only disabled in commit message
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 8919fede3cd7..b3e714e1abed 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -127,6 +127,7 @@ rng: rng@4e10000 {
>   			reg = <0x0 0x4e10000 0x0 0x7d>;
>   			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&k3_clks 136 1>;
> +			status = "disabled"; /* Used by OP-TEE */
>   		};
>   	};
>   

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

