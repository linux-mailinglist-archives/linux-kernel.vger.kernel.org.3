Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325935691FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiGFSgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbiGFSgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:36:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF772BB35;
        Wed,  6 Jul 2022 11:35:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 266IZQh7060426;
        Wed, 6 Jul 2022 13:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657132526;
        bh=UWa+6eGg53WL0pKFldMfSM8zfLumeeG5smNx9eICN3A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JKzIc3/aZ8q1ohJv6rELYfcMxOFqk6PTcGQAArhlZOJyPSRNmJ2be6PGD/MvT7Uuf
         SNzG2tgKmz2prKuGJpKHW2MPwMxaRl/qsM7FR1mohDQWremCh30I+P7HrhbOtPD0We
         ZCCy4k348emi60V5PbPxZzWxuQNJwGRaPcugKFmE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 266IZQmW099203
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 13:35:26 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 13:35:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 13:35:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 266IZQLP120017;
        Wed, 6 Jul 2022 13:35:26 -0500
Date:   Wed, 6 Jul 2022 13:35:26 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: ti: k3-j7200-mcu-wakeup: Add SA2UL node
Message-ID: <20220706183526.i6ysrsjgevz3w3ei@masculine>
References: <20220705170340.26719-1-afd@ti.com>
 <20220705170340.26719-6-afd@ti.com>
 <20220706180446.cyzujuasovjvsofk@lively>
 <16319b56-4b14-6f51-23c6-6b78b87119d7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16319b56-4b14-6f51-23c6-6b78b87119d7@ti.com>
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

On 13:10-20220706, Andrew Davis wrote:
> > > +	mcu_crypto: crypto@40900000 {
> > > +		compatible = "ti,j721e-sa2ul";
> > > +		reg = <0x00 0x40900000 0x00 0x1200>;
> > > +		power-domains = <&k3_pds 265 TI_SCI_PD_SHARED>;
> > > +		#address-cells = <2>;
> > > +		#size-cells = <2>;
> > > +		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
> > > +		dmas = <&mcu_udmap 0xf501>, <&mcu_udmap 0x7502>,
> > > +		       <&mcu_udmap 0x7503>;
> > > +		dma-names = "tx", "rx1", "rx2";
> > > +		dma-coherent;
> > > +
> > > +		rng: rng@40910000 {
> > > +			compatible = "inside-secure,safexcel-eip76";
> > > +			reg = <0x00 0x40910000 0x00 0x7d>;
> > > +			interrupts = <GIC_SPI 945 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > Please document why disabled.
> > 
> 
> Sure thing, will add background info to the commit message.

I'd suggest to document in dts as well. See thread [1]


[1] https://lore.kernel.org/linux-arm-kernel/YiizsYnKB0X9bDY2@atomide.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
