Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A96496D1E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 18:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiAVRhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 12:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiAVRg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:36:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C5C06173B;
        Sat, 22 Jan 2022 09:36:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A232560E8E;
        Sat, 22 Jan 2022 17:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D25C004E1;
        Sat, 22 Jan 2022 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642873018;
        bh=zWGNCveV/x4+gAreqjzhVgHPiWB8GcfKFkV1vx/v+cw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kl1Jc21s0OzMShPbomHCebQuIgKPzSIEmGB0pc85n6DhtjXQD81YuUlfSxpeOvBVK
         yLs3T7dj+PX5H74gn9uPnWIWyb2J6WkiqSRX69z7Gk+QcUTR4v0jL8D+1QIhVOaH/u
         igi9QASGKSHO3b901nJ//s4UvZ758y8oqqY5DYeIxZTPXMiHHzq5+Px09sw625oELs
         hGKawdnNWH3fP3axllZHkEjNt2gQGJDxdQlTvJZYYdFtk6kqbCN9NmFtsBdOtlx2lX
         s+PCzU6nJM0SAw9r6rJkfOaveb+PK9xFMWl54T3S1AhtqAoxseNbEfAf60ZIosjHM9
         NO5XQEEij2WIg==
Date:   Sat, 22 Jan 2022 17:43:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings:iio:frequency: add admv1014 binding
Message-ID: <20220122174307.3a0115bc@jic23-huawei>
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

Hi Antoniu

These elements need to specify a default for when they are not provided
seeing as they are optional and the default is not obvious.

Thanks,

Jonathan


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

