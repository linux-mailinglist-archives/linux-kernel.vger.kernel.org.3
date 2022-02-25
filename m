Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076504C4454
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbiBYMJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiBYMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:09:31 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F91E1D6C8C;
        Fri, 25 Feb 2022 04:08:59 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21PC8s7C097832;
        Fri, 25 Feb 2022 06:08:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645790934;
        bh=OCy/ZM84fGwJI7cVCfmfFkgRFSffawvtHCeMohNwSXU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=G4gdz3ZFVoWE0VuacYMF9hcJZsKrvC3Fz7mp8MmsWCSlQxoyTYvDURZKvQUf0LulP
         k9TQj6lrLoyAO5DvjDsmhNPdUSNJy+b35oOqJrVhZ29q3nBdtjhMh+BoRFyOF7MOsb
         OXkMdGUNqW6GAWxOUiXWNlLcZl57sqcHrnCSJpq8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21PC8sWq052532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Feb 2022 06:08:54 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 25
 Feb 2022 06:08:54 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 25 Feb 2022 06:08:54 -0600
Received: from [10.250.232.111] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21PC8psV024796;
        Fri, 25 Feb 2022 06:08:51 -0600
Message-ID: <5aef6ed4-7d05-3d1e-2cc1-7c49e4761c4d@ti.com>
Date:   Fri, 25 Feb 2022 17:38:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-sk: Enable WLAN connected to
 SDHCI0
Content-Language: en-US
To:     Aparna M <a-m1@ti.com>, <nm@ti.com>, <kishon@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <nikhil.nd@ti.com>
References: <20220223155754.7298-1-a-m1@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220223155754.7298-1-a-m1@ti.com>
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

Hi

On 23/02/22 9:27 pm, Aparna M wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> WL1837 module is connected to SDHCI0 in AM642 SK. Enable it here.
> This will enable the WiFi functionaliy on the board.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> Signed-off-by: Aparna M <a-m1@ti.com>
> ---
> 
> v1 -> v2: Update commit message with "From:" details
> 
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 62 ++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 6b04745147be..1178bb982f05 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -125,6 +125,31 @@
>  		vin-supply = <&vcc_3v3_sys>;
>  		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
>  	};
> +
> +	com8_ls_en: fixed-regulator-com8 {

Please use generic node names as per DT spec [1]

Something like:
	com8_ls_en: regulator-1 {
		...
	};



> +		compatible = "regulator-fixed";
> +		regulator-name = "com8_ls_en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		pinctrl-0 = <&main_com8_ls_en_pins_default>;
> +		pinctrl-names = "default";
> +		gpio = <&main_gpio0 62 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	wlan_en: fixed-regulator-wlan {

same as above

> +		/* output of SN74AVC4T245RSVR */
> +		compatible = "regulator-fixed";
> +		regulator-name = "wlan_en";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		enable-active-high;
> +		pinctrl-0 = <&main_wlan_en_pins_default>;
> +		pinctrl-names = "default";
> +		vin-supply = <&com8_ls_en>;
> +		gpio = <&main_gpio0 48 GPIO_ACTIVE_HIGH>;
> +	};
>  };
>  
>  &main_pmx0 {

[...]

[1]
https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.4-rc1


Regards
Vignesh
