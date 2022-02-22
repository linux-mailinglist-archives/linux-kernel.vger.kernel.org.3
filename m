Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8584BFBE4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiBVPFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiBVPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:04:57 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B9F10E064;
        Tue, 22 Feb 2022 07:04:31 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21MF4PeM120145;
        Tue, 22 Feb 2022 09:04:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645542265;
        bh=b96Ye1D60drbW5AL+8usWN/Y2OQQxy3Gle9yf9S/rgQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JQoFydBp6T0AcfTGQ+xqVDV8YMSe7lksuOZRY1mbD/JvAfi7QnPj2+3C5ogPGyp11
         NpbdeymSQbeAX0UE/SqV+nm+O0e44Bwd4+7mJetOU6DKP2H71rSTTOWtOFnA6r1Ssd
         vORnqtYIuO2kffcfCqSiW2u0NB9NXxkzWjdC4TVI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21MF4P8L035422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 09:04:25 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 09:04:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 09:04:25 -0600
Received: from [10.250.234.33] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21MF4LnB120526;
        Tue, 22 Feb 2022 09:04:21 -0600
Message-ID: <656c6e1e-4947-4af6-bf63-dea60e9d0855@ti.com>
Date:   Tue, 22 Feb 2022 20:34:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-*: Drop address and size cells
 from flash nodes
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220217181025.1815118-1-p.yadav@ti.com>
 <20220217181025.1815118-2-p.yadav@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20220217181025.1815118-2-p.yadav@ti.com>
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


On 17/02/22 23:40, Pratyush Yadav wrote:
> Specifying partitions directly under the flash nodes is deprecated. A
> partitions node should used instead. The address and size cells are not
> needed. Remove them.
>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Apurva Nandan<a-nandan@ti.com>

> ---
>
> Only compile-tested.
>
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts               | 2 --
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts                | 2 --
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi           | 2 --
>   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 --
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts                | 2 --
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi           | 2 --
>   6 files changed, 12 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index edf80e277267..8e7893e58b03 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -509,8 +509,6 @@ flash@0 {
>   		cdns,tchsh-ns = <60>;
>   		cdns,tslch-ns = <60>;
>   		cdns,read-delay = <4>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>   	};
>   };
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 30b956276060..1d7db8bf3a5c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -380,8 +380,6 @@ flash@0 {
>   		cdns,tchsh-ns = <60>;
>   		cdns,tslch-ns = <60>;
>   		cdns,read-delay = <4>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>   	};
>   };
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index 7d819f0db8df..2d615c3e9fa1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -267,7 +267,5 @@ flash@0 {
>   		cdns,tchsh-ns = <60>;
>   		cdns,tslch-ns = <60>;
>   		cdns,read-delay = <4>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 2ecc4541f6d8..f5ca8e26ed99 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -493,8 +493,6 @@ flash@0 {
>   		cdns,tchsh-ns = <60>;
>   		cdns,tslch-ns = <60>;
>   		cdns,read-delay = <2>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>   	};
>   };
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index b726310d867c..f25d85169e0d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -475,8 +475,6 @@ flash@0 {
>   		cdns,tchsh-ns = <60>;
>   		cdns,tslch-ns = <60>;
>   		cdns,read-delay = <4>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>   	};
>   };
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> index 990dfcd61018..e36335232cf8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> @@ -182,8 +182,6 @@ flash@0 {
>   		cdns,tchsh-ns = <60>;
>   		cdns,tslch-ns = <60>;
>   		cdns,read-delay = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>   	};
>   };
>
> --
> 2.34.1
>
