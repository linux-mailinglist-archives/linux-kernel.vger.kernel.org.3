Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D534C14D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbiBWN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiBWN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:56:09 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0BEB0A6E;
        Wed, 23 Feb 2022 05:55:40 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NDtZ1b026972;
        Wed, 23 Feb 2022 07:55:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645624535;
        bh=S7C/NqOakX7UbNk41LHpz1uj1i2eJAfjzGfWkUQqzhw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LSta1V0AMWkVKye2BKyuO6aQ3615OtOoEXSGlXiowG0NonB/PWCMoOhLXa3hzrScc
         5u4uIOc5fE/deD9KDWmW2qvxR2Ry4rWk8I2nUvBOBJimnNdK+doOycKbJZyMoQeMiD
         IwfV/fEK4w0j3wEm3Q9aWYk1ge+nIDfChTUm6gbY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NDtYHs116763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 07:55:34 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 07:55:34 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 07:55:34 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NDtYiN063612;
        Wed, 23 Feb 2022 07:55:34 -0600
Date:   Wed, 23 Feb 2022 07:55:34 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aparna M <a-m1@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <grygorii.strashko@ti.com>, <nikhil.nd@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-sk: Add DT entry for onboard
 LEDs
Message-ID: <20220223135534.jbmbdvc4zye7udmc@grafting>
References: <20220223083229.8044-1-a-m1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220223083229.8044-1-a-m1@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:02-20220223, Aparna M wrote:
> AM642 SK has 8 leds connected to tpic2810 onboard. Add support for these
> gpio leds.
> 
> Signed-off-by: Aparna M <a-m1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 70 ++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 6b04745147be..31e45bafa49e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
[...]

> +
> +	exp2: gpio@60 {
> +		compatible = "ti,tpic2810";

Sorry, but no.
please convert
	Documentation/devicetree/bindings/gpio/gpio-tpic2810.txt to yaml

prior to any patches that enable it. (dtbs_check should have already
warned you about this).

> +		reg = <0x60>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "LED1","LED2","LED3","LED4","LED5","LED6","LED7","LED8";
> +	};
>  };
>  
>  &main_i2c3 {
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
