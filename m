Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF43569666
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiGFXkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiGFXkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:40:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DBA2CDE8;
        Wed,  6 Jul 2022 16:40:18 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 266Ndvlx124475;
        Wed, 6 Jul 2022 18:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657150797;
        bh=ltnBzyI2RtId+bp0LQu/TBW77O/RnyLARnLDQrRtLjU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=L4hrXUSXnMyHK3s5SLjfWD0UbEZ5j/ZmIAWibK+vNG5jXc4q2k9yectzQOnJSqeQT
         Hkj928fg275YsCB+jGZQavNuD8fqVMRmMp+t5xvVhnUfNoM1bsLYQeByhcHkHlYQhs
         Hfk5q8tSEOmo3buvyCMoNiprpZU0O59CO23jQlpk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 266NdvLu103943
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 18:39:57 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 18:39:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 18:39:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 266Ndubw026725;
        Wed, 6 Jul 2022 18:39:56 -0500
Date:   Wed, 6 Jul 2022 18:39:56 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <khasim@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <ada@thorsis.com>,
        <pavel@ucw.cz>, <praneeth@ti.com>, <robh+dt@kernel.org>,
        <devarsht@ti.com>, <s-adivi@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-sk: Add DT entry for onboard
 LEDs
Message-ID: <20220706233918.dct7emagduy3r22t@preoccupy>
References: <20220629075859.6939-1-a-m1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629075859.6939-1-a-m1@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:28-20220629, Aparna M wrote:
[...]
>  &main_pmx0 {
> @@ -316,6 +377,14 @@
>  				  "VPP_LDO_EN", "RPI_PS_3V3_En",
>  				  "RPI_PS_5V0_En", "RPI_HAT_DETECT";
>  	};
> +
> +        exp2: gpio@60 {
> +                compatible = "ti,tpic2810";
> +                reg = <0x60>;
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                gpio-line-names = "LED1","LED2","LED3","LED4","LED5","LED6","LED7","LED8";
> +        };

https://lore.kernel.org/all/CACRpkdbj2B90-RE2XKQJ5qEj1hZQA-u=vUu2vpXwNqQLf_kaPg@mail.gmail.com/

I see Rob and Linus has acked it, but it does'nt belong to TI device
tree queue. and I cannot pick up dts node without the compatible in
master branch in rc1, so I have to skip.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
