Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C505115FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiD0LLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiD0LJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:09:50 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D23D1E9;
        Wed, 27 Apr 2022 04:06:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23RB6SUA125247;
        Wed, 27 Apr 2022 06:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651057588;
        bh=/5rpqQNFDpFINVoe6R7+hHiVY2rPdjoXzl/fQ4O7koc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=YmAOq9ohlolk0x+C0sQ3ZGqhE38o3xRIr3Nh+3AwM9sEFfY4WpWeRgU6gH72q1b+d
         teHny0ktILhgnt7zF8Wb1YvVVrcT8tZVBV5xlkfjqyMU3SVMTG2Iv2BijSrctDeJ1y
         tTqAHKoqFarEAuO8jwFjBOWqhBKuhv6J7ge/IDeA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23RB6S5c095328
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 06:06:28 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 06:06:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 06:06:27 -0500
Received: from [172.24.145.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23RB6O71122417;
        Wed, 27 Apr 2022 06:06:24 -0500
Message-ID: <919c9e7c-3c7b-23e9-758e-8ace5affe369@ti.com>
Date:   Wed, 27 Apr 2022 16:36:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-sk: Add ECAP APWM nodes
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20220419062902.196526-1-vigneshr@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <20220419062902.196526-1-vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/22 11:59, Vignesh Raghavendra wrote:
> AM62 has 3 ECAP instances with 1 APWM each. Add DT nodes for the same.
> Keep them disabled in am625-sk dts as these pins can be repurposed in
> user exp connector.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---

Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>

Thanks,
Aswath

>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 27 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 12 +++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 4b6ba98dd0a2..dd972fcdaedb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -530,4 +530,31 @@ mailbox0_cluster0: mailbox@29000000 {
>  		ti,mbox-num-users = <4>;
>  		ti,mbox-num-fifos = <16>;
>  	};
> +
> +	ecap0: pwm@23100000 {
> +		compatible = "ti,am3352-ecap";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x23100000 0x00 0x100>;
> +		power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 51 0>;
> +		clock-names = "fck";
> +	};
> +
> +	ecap1: pwm@23110000 {
> +		compatible = "ti,am3352-ecap";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x23110000 0x00 0x100>;
> +		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 52 0>;
> +		clock-names = "fck";
> +	};
> +
> +	ecap2: pwm@23120000 {
> +		compatible = "ti,am3352-ecap";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x23120000 0x00 0x100>;
> +		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 53 0>;
> +		clock-names = "fck";
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index 5fc35898a1e2..2c5e0e5b826b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -477,3 +477,15 @@ partition@3fc0000 {
>  		};
>  	};
>  };
> +
> +&ecap0 {
> +	status = "disabled";
> +};
> +
> +&ecap1 {
> +	status = "disabled";
> +};
> +
> +&ecap2 {
> +	status = "disabled";
> +};
