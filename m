Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E294C6412
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiB1Huf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiB1Huc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:50:32 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79083D1EE;
        Sun, 27 Feb 2022 23:49:53 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21S7nbJh072514;
        Mon, 28 Feb 2022 01:49:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646034577;
        bh=Z18hRYXAm+IJkK76PuTXMrEXV6a7Mb+VwFaPYZ6wq+8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=haPPXk6IvKcm74N8Gj2miqOBFJr+ay0IP+5GLu7vyLxJrCGriSFUcMB2LusncLj/+
         seN6dYs89HvV/5pauPqyoKw1WXPXnBhMfMt1V1wgQxOxh3Z6RjZNavNZ9dpN3q+WX7
         +VAFpjrZGqj36aHFbsNLLNHN75nrBrTjvwfSo6Ac=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21S7nbij119009
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Feb 2022 01:49:37 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 28
 Feb 2022 01:49:36 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 28 Feb 2022 01:49:36 -0600
Received: from [10.250.233.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21S7nYJX038372;
        Mon, 28 Feb 2022 01:49:35 -0600
Message-ID: <63a95660-2ded-1087-999f-57f5c68deda6@ti.com>
Date:   Mon, 28 Feb 2022 13:19:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-am64-main: Add ELM (Error
 Location Module) node
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <nm@ti.com>
CC:     <kishon@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220204111533.10787-1-rogerq@kernel.org>
 <20220204111533.10787-3-rogerq@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220204111533.10787-3-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/22 4:45 pm, Roger Quadros wrote:
> The ELM module is used for GPMC NAND accesses for detecting
> and correcting errors during reads due to NAND bitflips errors.

[...]

> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 94ea5c304d73..b17620e999a5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -1308,4 +1308,13 @@
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  	};
> +
> +	elm0: ecc@25010000 {
> +		compatible = "ti,am3352-elm";

Sorry, this binding needs to move to YAML before patch can be applied.

> +		reg = <0x00 0x25010000 0x00 0x2000>;
> +		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 54 0>;
> +		clock-names = "fck";
> +	};
>  };
[...]


Regards
Vignesh
