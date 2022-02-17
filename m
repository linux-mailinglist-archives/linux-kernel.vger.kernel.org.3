Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC124BA487
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiBQPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:37:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242562AbiBQPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:37:35 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E22B2B2E11;
        Thu, 17 Feb 2022 07:37:21 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21HFbC6x007434;
        Thu, 17 Feb 2022 09:37:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645112232;
        bh=MXh5Ng0xjFA6lpgTkmnOyicU8T+ED+2XZNQZN38DXlg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uNeX8Q4bVJB6Cviq8td3cYWENPBcM57rtZjgQFKXjVygHyKRpvwhZSR4Rgs8Z+hxO
         hkjWe2y0X5iQBUS1VtfUK3oBgVscCVE96RbuRPDU6bc7I5dHyJfyvEMK+UtfZHKsVn
         8Y/xBwy4sUOJ6DSKARx/jozxZnMLakfzi2EbMXRU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21HFbCl7118845
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Feb 2022 09:37:12 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 17
 Feb 2022 09:37:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 17 Feb 2022 09:37:12 -0600
Received: from [10.250.233.137] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21HFb8AH077363;
        Thu, 17 Feb 2022 09:37:09 -0600
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e-common-proc-board: Enable
 PCIe + QSGMII multilink configuration
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220202043944.11351-1-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <20ceb422-8464-4f12-0b46-ad5c4d43da3c@ti.com>
Date:   Thu, 17 Feb 2022 21:07:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220202043944.11351-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath, Swapnil,

On 02/02/22 10:09 am, Aswath Govindraju wrote:
> From: Swapnil Jakhade <sjakhade@cadence.com>
> 
> The zeroth instance of SerDes on J721E common processor board will be
> shared between PCIe and QSGMII. Therefore, add support for enabling this.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> changes since v1:
> - Fixed the commit message.
> 
>  .../boot/dts/ti/k3-j721e-common-proc-board.dts    | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 2d7596911b27..157d86dc2824 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -431,7 +431,7 @@
>  };
>  
>  &serdes_ln_ctrl {
> -	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_PCIE0_LANE1>,
> +	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_QSGMII_LANE2>,
>  		      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
>  		      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
>  		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,

This change will kick-in errata i2183
https://www.ti.com/lit/er/sprz455a/sprz455a.pdf

This will break PCIe endpoint mode. Let's get the errata workaround merged
before this.

Thanks,
Kishon

> @@ -757,8 +757,8 @@
>  };
>  
>  &serdes0 {
> -	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>;
> -	assigned-clock-parents = <&wiz0_pll1_refclk>;
> +	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>, <&serdes0 CDNS_SIERRA_PLL_CMNLC1>;
> +	assigned-clock-parents = <&wiz0_pll1_refclk>, <&wiz0_pll1_refclk>;
>  
>  	serdes0_pcie_link: phy@0 {
>  		reg = <0>;
> @@ -767,6 +767,15 @@
>  		cdns,phy-type = <PHY_TYPE_PCIE>;
>  		resets = <&serdes_wiz0 1>;
>  	};
> +
> +	serdes0_qsgmii_link: phy@1 {
> +		reg = <1>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_QSGMII>;
> +		resets = <&serdes_wiz0 2>;
> +	};
> +
>  };
>  
>  &serdes1 {
> 
