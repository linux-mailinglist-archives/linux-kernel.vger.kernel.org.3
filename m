Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C08554BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357537AbiFVNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357493AbiFVNtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5D62AC40;
        Wed, 22 Jun 2022 06:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E7C461B4A;
        Wed, 22 Jun 2022 13:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C63C34114;
        Wed, 22 Jun 2022 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655905777;
        bh=s/BTpD1smaZjhWjSTCDLGZE1k7ODXU40+GIAkraIWEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPDad96kmLy1MwuS+kg2oxCr9Nk6F3628i7Kiy47bUuA0TS5uOATOvW6gzIk1Va+V
         caZvU+/G7izv4S4DqVGWXOA+eMtxn1fSugp21S7xU+Uuq9SdnVrTL1Zpk04VXSWDQR
         FX9S6HLtqrSHtxVeOu0mt4BB/cmGoy909NoL73S+JytR5f+fFE8q4sz8tSf7iXXn7F
         nPrWBDHDYbF9N4+tAiEDz79h9R4rVB5NchFcZ6wjzdO7k0ggS7+t4E1v6neH/O0fNL
         FPtJBA1eMIgWwk6Ajs6ednHOBHLV2e6WQWuqY8O87Co3d+VAsB4x3b2qAaWoYWjw7K
         HlstxSM6BA4Pg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o40je-0006ZX-CV; Wed, 22 Jun 2022 15:49:34 +0200
Date:   Wed, 22 Jun 2022 15:49:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad
 X13s devicetree
Message-ID: <YrMd7nX8Tu5eu6hU@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-7-bjorn.andersson@linaro.org>
 <fb234ad7-6a95-d5f2-9ebc-48ac2dd8fb8a@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb234ad7-6a95-d5f2-9ebc-48ac2dd8fb8a@somainline.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:39:43PM +0200, Konrad Dybcio wrote:
> On 22.06.2022 06:12, Bjorn Andersson wrote:
> > From: Johan Hovold <johan+linaro@kernel.org>
> > 
> > Add an initial Lenovo Thinkpad X13s devicetree.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changs since v1:
> > - New patch
> > 
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 393 ++++++++++++++++++
> >  2 files changed, 394 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index 2f416b84b71c..43053f1f6be9 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -91,6 +91,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > new file mode 100644
> > index 000000000000..58d3d8035751
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -0,0 +1,393 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2022, Linaro Limited
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> Can be moved to SoC dtsi.

Again, no, the SoC dtsi does not need that header and we include files
where they are used.

> > +&qup0_i2c4 {
> > +	clock-frequency = <400000>;
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&qup0_i2c4_default>, <&ts0_default>;
> > +
> > +	status = "okay";
> Again, the ordering of status= question from one of the previous patches.

This is the right order, but the ADP dts hasn't been updated yet.
 
> 
> > +
> > +	/* FIXME: verify, missing on some x13s */
> Won't this fail gracefully-ish if it's absent?

Sure, but that's not the point. I don't access to a X13s with a
touchscreen yet so the i2c address and hid descriptor address has not
been verified yet.

> > +	touchscreen@10 {
> > +		compatible = "hid-over-i2c";
> > +		reg = <0x10>;
> > +		hid-descr-addr = <0x1>;
> > +		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> > +		vdd-supply = <&vreg_misc_3p3>;
> > +	};
> > +};

> > +/* PINCTRL - additions to nodes defined in sc8280xp.dtsi */
> Seems redundant.

Again, no. But I've dropped the reference to sc8280xp.dtsi.

> > +	tpad_default: tpad-default-state {

> > +		int-n {
> Same comment as in the reference device dt.

I think it's better to keep the child node as documentation.

Johan
