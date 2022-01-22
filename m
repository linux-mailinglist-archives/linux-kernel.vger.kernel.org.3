Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09F9496D16
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 18:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiAVR0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 12:26:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54506 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiAVR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:26:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D75660E07;
        Sat, 22 Jan 2022 17:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F4FC004E1;
        Sat, 22 Jan 2022 17:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642872396;
        bh=JKOyBIBEtQl1RLmxtU+7ibAOozBWhlW6qQd4TiIiKmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rswjyo00WTr/Ld1rwCHlo3T5fv9BLKGkkba++/cHPBXvUC5IA7XhdXlcWRZVbx1Hz
         YndgiozDqKoRiLXiugZ4YA1DdONVMbzqOhDd0RBX3r1wtLuFEJSHqrqaSyF1RRa9Jg
         TWi6bsG+IQpAMPbhG3envozCFYKq91tpaBVFqERcHlz/rpTkocgwi9p2ou9lRTSGte
         lcNkbvLJ6I+r+m0T1+IUU3vvjXflCOJs0jc07ebJ1Yi/Nw37KtMdZjTNvBGMYHd184
         GRjcaSdP6ar8Me0cH2TBnkwQP+ZsfxjAJrCQ+OjZ/wkPUZndRvHz51Du+uZpiYcMLB
         f2rs3ojtlcvmA==
Date:   Sat, 22 Jan 2022 17:32:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings:iio:frequency: add admv1014 binding
Message-ID: <20220122173246.48f52792@jic23-huawei>
In-Reply-To: <20220119081838.70210-2-antoniu.miclaus@analog.com>
References: <20220119081838.70210-1-antoniu.miclaus@analog.com>
        <20220119081838.70210-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 10:18:36 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the ADMV1014 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> changes in v3:
>  - change clock description as suggested
> ---

Change log below the --- 

We don't want it in the permanent git history.  There will
be a link tag to this thread to allow anyone who happens to 
want to known more to find the version change log.

Given you got it right in the other 3 patches, I'm guessing you
just missed here.

If that is all that turns up in review, I can fix it whilst applying.

Thanks,

Jonathan


>  .../bindings/iio/frequency/adi,admv1014.yaml  | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> new file mode 100644
> index 000000000000..864093f6a29a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv1014.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV1014 Microwave Downconverter
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Wideband, microwave downconverter optimized for point to point microwave
> +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> +
> +   https://www.analog.com/en/products/admv1014.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv1014
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  clocks:
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lo_in
> +    description:
> +      External clock that provides the Local Oscilator input.
> +
> +  vcm-supply:
> +    description:
> +      Common-mode voltage regulator.
> +
> +  vcc-if-bb-supply:
> +    description:
> +      BB and IF supply voltage regulator.
> +
> +  vcc-vga-supply:
> +    description:
> +      RF Amplifier supply voltage regulator.
> +
> +  vcc-vva-supply:
> +    description:
> +      VVA Control Circuit supply voltage regulator.
> +
> +  vcc-lna-3p3-supply:
> +    description:
> +      Low Noise Amplifier 3.3V supply voltage regulator.
> +
> +  vcc-lna-1p5-supply:
> +    description:
> +      Low Noise Amplifier 1.5V supply voltage regulator.
> +
> +  vcc-bg-supply:
> +    description:
> +      Band Gap Circuit supply voltage regulator.
> +
> +  vcc-quad-supply:
> +    description:
> +      Quadruple supply voltage regulator.
> +
> +  vcc-mixer-supply:
> +    description:
> +      Mixer supply voltage regulator.
> +
> +  adi,input-mode:
> +    description:
> +      Select the input mode.
> +      iq - in-phase quadrature (I/Q) input
> +      if - complex intermediate frequency (IF) input
> +    enum: [iq, if]
> +
> +  adi,detector-enable:
> +    description:
> +      Digital Rx Detector Enable. The Square Law Detector output is
> +      available at output pin VDET.
> +    type: boolean
> +
> +  adi,p1db-compensation-enable:
> +    description:
> +      Turn on bits to optimize P1dB.
> +    type: boolean
> +
> +  adi,quad-se-mode:
> +    description:
> +      Switch the LO path from differential to single-ended operation.
> +      se-neg - Single-Ended Mode, Negative Side Disabled.
> +      se-pos - Single-Ended Mode, Positive Side Disabled.
> +      diff - Differential Mode.
> +    enum: [se-neg, se-pos, diff]
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - vcm-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv1014@0{
> +        compatible = "adi,admv1014";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        clocks = <&admv1014_lo>;
> +        clock-names = "lo_in";
> +        vcm-supply = <&vcm>;
> +        adi,quad-se-mode = "diff";
> +        adi,detector-enable;
> +        adi,p1db-compensation-enable;
> +      };
> +    };
> +...

