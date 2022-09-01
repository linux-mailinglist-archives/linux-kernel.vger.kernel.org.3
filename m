Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0915A9A57
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiIAOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiIAOas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:30:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF95D0C8;
        Thu,  1 Sep 2022 07:30:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 281EUcQf018430;
        Thu, 1 Sep 2022 09:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662042638;
        bh=KYdHbEnyxMM66nrg4RaqhIx0Xvm/moQdRY3+IxpilL4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=k/j9DvkhowjIl8KLU3muWV+eJyrReSa+Q+ewIK51HupXVD2uSeKdI8ea9Oa9Xcv6M
         e8HsvB+Q2K4kNnqRVu0SWpYeAS2VarlWKl+LnFpyUqkYlhWedVt1IMLaMJytW7ymDs
         0QfF5JpRWx9IlaLty7dDhHAQktPL6maXQuulb36o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 281EUcfq031708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 09:30:38 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 09:30:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 09:30:38 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 281EUZVe119406;
        Thu, 1 Sep 2022 09:30:36 -0500
Message-ID: <08364d72-891f-4e21-25ac-2e77f1873374@ti.com>
Date:   Thu, 1 Sep 2022 20:00:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am64-main: fix RNG node clock id
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <f29e2c65dc7310a926af8a676651592afac04b03.1659981162.git.danielrparks@ti.com>
 <7961aebd737de637fa98bc6a8478380be8449b46.1659981162.git.danielrparks@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <7961aebd737de637fa98bc6a8478380be8449b46.1659981162.git.danielrparks@ti.com>
Content-Type: text/plain; charset="UTF-8"
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
> This patch depends on "[PATCH v2 0/2] Enable SA2UL support on AM64X" [2]
> 
> [1]: https://downloads.ti.com/tisci/esd/latest/5_soc_doc/am64x/clocks.html#clocks-for-sa2-ul0-device
> [2]: https://lore.kernel.org/linux-arm-kernel/20220711085743.10128-1-j-choudhary@ti.com/

I folded below patch into [2] when applying.

> 
> Signed-off-by: Daniel Parks <danielrparks@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 293b6b8e8fb2..aa3b43c515d2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -1324,7 +1324,7 @@
>  			compatible = "inside-secure,safexcel-eip76";
>  			reg = <0x00 0x40910000 0x00 0x7d>;
>  			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&k3_clks 133 0>;
> +			clocks = <&k3_clks 133 1>;
>  			status = "disabled"; /* Used by OP-TEE */
>  		};
>  	};

-- 
Regards
Vignesh
