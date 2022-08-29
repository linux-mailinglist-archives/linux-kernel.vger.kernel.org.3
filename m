Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492605A4419
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiH2HpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiH2HpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:45:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD85E48;
        Mon, 29 Aug 2022 00:45:01 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27T7is2k019624;
        Mon, 29 Aug 2022 02:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661759094;
        bh=aqlO4eqxCjb6AOPSzVJvOKRmmcq5exBzCetqn0YT1G4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=CfBjkdIxg1tkyVAQDSbx81vAT+E++0uo4RAgA6K9uRAedfE651jYSV4uwCk1z10cV
         mdYPSpLPFQg1Fxh0YryI+Ha4XUMCggec3Ws1/UeTdBQJ1E42OyLNo1xuIdhkwu3Uvd
         0EnWCSzqRZgriuNRGl0gFOURvjyN3wmtNMlXq2Q4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27T7ishn083636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 02:44:54 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 29
 Aug 2022 02:44:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 29 Aug 2022 02:44:54 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27T7ipU5008798;
        Mon, 29 Aug 2022 02:44:52 -0500
Message-ID: <fe5315cb-94f9-2fc4-86f6-848953884101@ti.com>
Date:   Mon, 29 Aug 2022 13:14:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j721e-main: fix RNG node clock id
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <f29e2c65dc7310a926af8a676651592afac04b03.1659981162.git.danielrparks@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <f29e2c65dc7310a926af8a676651592afac04b03.1659981162.git.danielrparks@ti.com>
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



On 09/08/22 00:02, Daniel Parks wrote:
> The RNG node for this platform claims pka_in_clk. Change it to claim the
> correct clock x1_clk. [1]
> 
> [1]: https://downloads.ti.com/tisci/esd/latest/5_soc_doc/j721e/clocks.html#clocks-for-sa2-ul0-device
> 
> Signed-off-by: Daniel Parks <danielrparks@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 43b6cf5791ee..917c9dc99efa 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -343,7 +343,7 @@
>   			compatible = "inside-secure,safexcel-eip76";
>   			reg = <0x0 0x4e10000 0x0 0x7d>;
>   			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&k3_clks 264 1>;
> +			clocks = <&k3_clks 264 2>;
>   		};
>   	};
>   

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
