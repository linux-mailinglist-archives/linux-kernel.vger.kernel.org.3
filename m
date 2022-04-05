Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280584F2306
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiDEGZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiDEGY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:24:59 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C9033E92;
        Mon,  4 Apr 2022 23:23:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2356MevN095436;
        Tue, 5 Apr 2022 01:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649139760;
        bh=rMuuntgnJKW2JVzxOaOZag9nVSmVcnb08P7QfoDrzhE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=m1ej1kteIm1Oa1/jZW3IqmUEdfEL1Z7oyLj6zQXQmC9vizLxbrYQE6jM9HxypKzT9
         0f47HhLVlwg5SlItxfHijjmmeCbhZuatAKE+Zai0+yRBOk0R/CtHceqn9jUFeve245
         3jtBsEgmGlquRJY3qPrEIEtzYLszaoLxHPy4Yon0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2356MeW6067756
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Apr 2022 01:22:40 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 01:22:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 01:22:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2356McPw019970;
        Tue, 5 Apr 2022 01:22:39 -0500
Date:   Tue, 5 Apr 2022 11:52:38 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j721e-common-proc-board: add
 DP to j7 evm
Message-ID: <20220405062237.swilick4ssnrni2l@uda0490373>
References: <20220331143035.16210-1-r-ravikumar@ti.com>
 <20220331143035.16210-3-r-ravikumar@ti.com>
 <3ae1a0b5-236c-20b0-ac2a-a93f0b4ced97@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ae1a0b5-236c-20b0-ac2a-a93f0b4ced97@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:33-20220401, Vignesh Raghavendra wrote:
> Hi Rahul,
> 
> On 31/03/22 8:00 pm, Rahul T R wrote:
> > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > Add the endpoint nodes to describe connection from
> > DSS => MHDP => DisplayPort connector.
> > Also add the phy link node and required pinmux nodes
> > for hotplug.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > ---
> >  .../dts/ti/k3-j721e-common-proc-board.dts     | 78 ++++++++++++++++++-
> >  1 file changed, 74 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> > index f5ca8e26ed99..8ddc0d3bd058 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> > @@ -148,6 +148,28 @@
> >  		pinctrl-0 = <&main_mcan2_gpio_pins_default>;
> >  		standby-gpios = <&main_gpio0 127 GPIO_ACTIVE_HIGH>;
> >  	};
> > +
> > +	dp_pwr_3v3: fixedregulator-dp-prw {
> 
> Please use standard node name: regulator-X as per DT spec [1]
> 
> 
> [1]
> https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "dp-pwr";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpio = <&exp4 0 0>;	/* P0 - DP0_PWR_SW_EN */
> 
> Please use GPIO_ACTIVE_* macros as appropriate.

Thanks Vignesh,

Will address the review comments in the respin

Regards
Rahul T R

> 
> > +		enable-active-high;
> > +	};
> > +
> [...]
