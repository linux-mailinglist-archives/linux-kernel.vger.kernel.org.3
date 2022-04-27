Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03490511AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiD0Obp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbiD0Obo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:31:44 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54013D28;
        Wed, 27 Apr 2022 07:28:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23RESJrn036102;
        Wed, 27 Apr 2022 09:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651069700;
        bh=mP/yWc581QChcTn+6JQhy5aJqoQd07YWtOKH5vWKUCc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=a5/mRTk2MoJSxRIjnbaN5FQqT2NReX9tNtfflFcH+94Tm0X4A2uXivRBuouZ3qmVQ
         nvGrfmEtnQ2qYP5e/elovb5EUFYgNfbRDqwk2I2tKwKLXcM66RsP7ONeWs8ldRXVoH
         ckn3DgGlyUmr1Z2KBJcSCnejC/TS+qd11HDC6hQo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23RESJ6F075916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 09:28:19 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 09:28:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 09:28:19 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23RESIXX086823;
        Wed, 27 Apr 2022 09:28:19 -0500
Date:   Wed, 27 Apr 2022 19:58:17 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: k3-j721e-common-proc-board: add
 DP to j7 evm
Message-ID: <20220427142817.3dndojgqrwbrnsze@uda0490373>
References: <20220426153553.18474-1-r-ravikumar@ti.com>
 <20220426153553.18474-3-r-ravikumar@ti.com>
 <20220426181301.z7jojik7zh7flh3h@gummy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220426181301.z7jojik7zh7flh3h@gummy>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:13-20220426, Nishanth Menon wrote:
> On 21:05-20220426, Rahul T R wrote:
> > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> 
> [...]
> 
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> > index 2f119e94e783..4b9e3f671781 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> > @@ -148,6 +148,28 @@
> >  		pinctrl-0 = <&main_mcan2_gpio_pins_default>;
> >  		standby-gpios = <&main_gpio0 127 GPIO_ACTIVE_HIGH>;
> >  	};
> > +
> > +	dp_pwr_3v3: regulator-dp-prw {
> 
> See feedback in https://lore.kernel.org/all/c50819cb-8234-670f-c7c0-0507af2f96df@linaro.org/

Hi Nishanth,

As per the feedback in the above thread
the name matches with below convention
"regulator-foo-bar" or "foo-bar-regulator"

Are you referring to the typo here?
regulator-dp-prw => regulator-dp-pwr
will fix this in the respin

Can you please clarify if you there is
any issue other than the typo

Regards
Rahul T R

> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "dp-pwr";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpio = <&exp4 0 GPIO_ACTIVE_HIGH>; /* P0 - DP0_PWR_SW_EN */
> > +		enable-active-high;
> > +	};
> > +
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
