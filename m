Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DEC57895A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiGRSL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGRSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:11:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6F11C2F;
        Mon, 18 Jul 2022 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658167864;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=mLmCHUMDe2eKeho/Ub+SVB6CDq8jI3pnYj0VyKsFHZM=;
    b=i7zLoAHkveqfnKa0wvA6q30HCHeBEhdzxj1m2vySmGcqVVlB2KD9TG+Pz20UmfFIUG
    1uJhvd5UxMHxMJjkbQSSk61wX3x1ATqouqDUpWplhPgjxmGw60DzFvUTmUUnA77YNlyg
    2gjFqvT+oHRbztDoFV64Qd9Ki76umxysAwoyMomwS2z7BEUpiPi8bBIPTjcmig0QwMQV
    b8hosPMw3wBD+2PX5EPxKei00ZU0lApxeBOl1+qLK0Rw8reh/uvzbgCNeGgVQ332dTEs
    iCYKLswCYstEmX7xEWPFenYNyfUQDs52QfkI8tt7sNI0dg/IlG8WzzHDIiFpZAUS4PP3
    2TeA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK86+6Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id he04d0y6IIB4HZR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 18 Jul 2022 20:11:04 +0200 (CEST)
Date:   Mon, 18 Jul 2022 20:10:56 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4
 10.1 (SM-T530)
Message-ID: <YtWiMP2O9BymNG7/@gerhold.net>
References: <20220717213432.134486-1-matti.lehtimaki@gmail.com>
 <20220717213432.134486-4-matti.lehtimaki@gmail.com>
 <dc19c084-633d-9777-6dfd-b9633ac9c4ae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc19c084-633d-9777-6dfd-b9633ac9c4ae@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 03:51:54PM +0200, Krzysztof Kozlowski wrote:
> On 17/07/2022 23:34, Matti Lehtimäki wrote:
> > Add a device tree for the Samsung Galaxy Tab 4 10.1 (SM-T530) wifi tablet
> > based on the apq8026 platform.
> > 
> > Currently supported are accelerometer sensor, hall sensor, internal storage, physical
> > buttons (power & volume), screen (based on simple-framebuffer set up by
> > the bootloader) sdcard, touchscreen and USB.
> > 
> > Signed-off-by: Matti LehtimÃ¤ki <matti.lehtimaki@gmail.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > ---
> >  arch/arm/boot/dts/Makefile                    |   1 +
> >  .../dts/qcom-apq8026-samsung-matissewifi.dts  | 475 ++++++++++++++++++
> >  2 files changed, 476 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matissewifi.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 5112f493f494..4d02a1740079 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1010,6 +1010,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
> >  	qcom-apq8016-sbc.dtb \
> >  	qcom-apq8026-asus-sparrow.dtb \
> >  	qcom-apq8026-lg-lenok.dtb \
> > +	qcom-apq8026-samsung-matissewifi.dtb \
> >  	qcom-apq8060-dragonboard.dtb \
> >  	qcom-apq8064-cm-qs600.dtb \
> >  	qcom-apq8064-ifc6410.dtb \
> > diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matissewifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matissewifi.dts
> > new file mode 100644
> > index 000000000000..f4c5eb9db11c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matissewifi.dts
> > @@ -0,0 +1,475 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2022, Matti LehtimÃ¤ki <matti.lehtimaki@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "qcom-msm8226.dtsi"
> > +#include "qcom-pm8226.dtsi"
> > +#include <dt-bindings/input/input.h>
> > +
> > +/delete-node/ &smem_region;
> > +
> > +/ {
> > +	model = "Samsung Galaxy Tab 4 10.1";
> > +	compatible = "samsung,matissewifi", "qcom,apq8026";
> > +	chassis-type = "tablet";
> > +
> > +	qcom,msm-id = <0xC708FF01 0 0x20000>,
> > +		      <0xC708FF01 1 0x20000>,
> > +		      <0xC708FF01 2 0x20000>,
> > +		      <0xC708FF01 3 0x20000>;
> 
> Lower case hex and does not match bindings.
> https://lore.kernel.org/all/20220705130300.100882-2-krzysztof.kozlowski@linaro.org/
> 
> This would need detailed explanation because it really does not look
> correct.
> 

Just to give the explanation for reference: In general, qcom,msm-id with
three elements is something Qualcomm used for some old platforms before
introducing qcom,board-id.

qcom,msm-id = <X Y Z> should be equivalent to:
  qcom,msm-id = <X Z>;
  qcom,board-id = <Y 0>;

e.g. for apq8026-v2-mtp.dts Qualcomm used:
   qcom,msm-id = <199 8 0x20000>;
 = qcom,msm-id = <QCOM_ID_MSM8026 QCOM_BOARD_ID_MTP 0x20000>;
 = qcom,msm-id = <QCOM_ID_MSM8026 0x20000>;
   qcom,board-id = <QCOM_BOARD_ID_MTP 0>;

I guess old bootloaders may or may not accept the new form, depending on
the age of their code base.

Then Samsung took this and made it a lot worse, by replacing the SoC ID
with some random magic number (the 0xC708FF01). And what's even worse is
that all devices with the same SoC from Samsung use the same magic number
there. It is completely useless for dynamically matching the device.

In this case, I suggest just dropping the property because the device is
supported by lk2nd [1] which can be loaded as intermediary bootloader to
have a more standard boot process for mainline Linux. When booting
through lk2nd no qcom,msm-id/qcom,board-id is required, and it also adds
MAC addresses for WiFi/Bluetooth etc etc. :-)

[1]: https://github.com/msm8916-mainline/lk2nd

> [...]
> > +	reserved-memory {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		framebuffer@3200000 {
> 
> Generic node names, so memory@
> 

Rob specifically mentioned at some point that memory@ should not be used
in reserved-memory [1]. The device tree specification actually recommends
doing it like it is done here (at least for "framebuffer"):

> 3.5.2 /reserved-memory/ child nodes
> Following the generic-names recommended practice, node names should
> reflect the purpose of the node (ie. “framebuffer” or “dma-pool”).

[1]: https://lore.kernel.org/linux-arm-msm/CAL_Jsq+66j8Y5y+PQ+mezkaxN1pfHFKz524YUF4Lz_OU5E-mZQ@mail.gmail.com/

Thanks,
Stephan
