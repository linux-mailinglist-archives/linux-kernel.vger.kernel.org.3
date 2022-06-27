Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F355CDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiF0ICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiF0ICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:02:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6866153
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:02:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o9so11734044edt.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BjTHbseoixUmzYUWFRt8jD61QtMOJnGOU7tJHocPH+4=;
        b=Crykg2D7L2/jYw9Zc+QOPJCotcSmhHmJ4Bd1BEkA7tw4o0rSDDPexy38nFMqt8LUve
         gRaiYejkMWWQIGubeM6taLxx8xYn+8UzT/8WEA2R8E7+6j6LsKBzbp3sAOzM2FW+4bd1
         nfp9TcXo/2J7WPs3gdHbXxNwii83+q4rWdHg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjTHbseoixUmzYUWFRt8jD61QtMOJnGOU7tJHocPH+4=;
        b=qGkAAfcfRSbcuHasOXwrl2d7N1PiUorQydHoEmi7XsQT3RHhSs36QmspBSF0eE+pLC
         osDPhA8A+I3ir9hEwA+YQ2WV6FnG/cxfmmUU2zIZqcLZCEdZkODVcIlOVJGWOOtkw6xR
         RtXcuqMmXLX/daI89K2FLlMGliQE27J9gZee05LSFYspLB3L/mN8KdipOWga6+xm3QYh
         STzTYQ2m9Cpjby0O1/l7bkBc3ZBQ6ocJctu/I6HVGxAk26BKomS31kdFdyHqVnl+5wa6
         /6U35xqZhRF4GiA/7PEZZJN8pLlo5/D1WyQifgvjvVdIQg2uuyGbz+g4Cs47zUIPeiqn
         CJTA==
X-Gm-Message-State: AJIora9mQwAVzLKmU8/Wd6blu3h0hwLScwoq5z6a44q3vSQz+t1cF+Gm
        K4CWjN8a1t+8x/ko0isnAu7oHw==
X-Google-Smtp-Source: AGRyM1tiYP8kZA9oM4ucvX9W8C/b40cQ+3pgjpkJmJ7Ja2f6ohJKIB48BzMmr1d96XYj5nuQ09HDcQ==
X-Received: by 2002:a05:6402:1f15:b0:435:8a5a:e69c with SMTP id b21-20020a0564021f1500b004358a5ae69cmr14765615edb.90.1656316923777;
        Mon, 27 Jun 2022 01:02:03 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709062cd300b006ff802baf5dsm4728152ejr.54.2022.06.27.01.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:02:03 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:02:01 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] media: dt-bindings: ov5693: document YAML binding
Message-ID: <20220627080201.GA175635@tom-ThinkPad-T14s-Gen-2i>
References: <20220624230307.3066530-1-tommaso.merciai@amarulasolutions.com>
 <20220624230307.3066530-8-tommaso.merciai@amarulasolutions.com>
 <7b138ea1-735f-03b1-720b-d3934ad83060@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b138ea1-735f-03b1-720b-d3934ad83060@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
Thanks for your review, I will fix this in v2.

Regards,
Tommaso

On Sat, Jun 25, 2022 at 10:35:50PM +0200, Krzysztof Kozlowski wrote:
> On 25/06/2022 01:03, Tommaso Merciai wrote:
> > This patch adds documentation of device tree in YAML schema for the
> > OV5693 CMOS image sensor from Omnivision
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > ---
> >  .../bindings/media/i2c/ovti,ov5693.yaml       | 123 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 124 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > new file mode 100644
> > index 000000000000..1ee70af40000
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2022 Amarulasolutions
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Omnivision OV5693 CMOS Sensor
> > +
> > +maintainers:
> > +  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/media/video-interface-devices.yaml#
> 
> This goes after description.
> 
> > +
> > +description: |
> > +  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
> > +  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
> > +  sub-sampled, and windowed 10-bit MIPI images in various formats via the
> > +  Serial Camera Control Bus (SCCB) interface.
> > +
> > +  Supports images sizes: 5 Mpixel, EIS1080p, 1080p, 720p, VGA, QVGA
> > +
> > +  OV5693 is programmable through I2C and two-wire Serial Camera Control Bus (SCCB).
> > +  The sensor output is available via CSI-2 serial data output (up to 2-lane).
> > +
> > +properties:
> > +  compatible:
> > +    const: ovti,ov5693
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      System input clock (aka XVCLK). From 6 to 27 MHz.
> > +    maxItems: 1
> > +
> > +  dovdd-supply:
> > +    description:
> > +      Digital I/O voltage supply, 1.8V.
> > +
> > +  avdd-supply:
> > +    description:
> > +      Analog voltage supply, 2.8V.
> > +
> > +  dvdd-supply:
> > +    description:
> > +      Digital core voltage supply, 1.2V.
> > +
> > +  reset-gpios:
> > +    description:
> > +      The phandle and specifier for the GPIO that controls sensor reset.
> > +      This corresponds to the hardware pin XSHUTDN which is physically
> > +      active low.
> > +    maxItems: 1
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/media/video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          data-lanes:
> > +            minItems: 1
> > +            maxItems: 2
> > +
> > +          # Supports max data transfer of 900 Mbps per lane
> > +          link-frequencies: true
> 
> This is not needed. Provided by video-interfaces.yaml.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - dovdd-supply
> > +  - avdd-supply
> > +  - dvdd-supply
> > +  - port
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/px30-cru.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/pinctrl/rockchip.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ov5693: camera@36 {
> > +            compatible = "ovti,ov5693";
> > +            reg = <0x36>;
> > +
> > +            reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&cif_clkout_m0>;
> > +
> > +            clocks = <&cru SCLK_CIF_OUT>;
> > +            assigned-clocks = <&cru SCLK_CIF_OUT>;
> > +            assigned-clock-rates = <19200000>;
> > +
> > +            avdd-supply = <&vcc_1v8>;
> > +            dvdd-supply = <&vcc_1v2>;
> > +            dovdd-supply = <&vcc_2v8>;
> > +
> > +            rotation = <90>;
> > +            orientation = <0>;
> > +
> > +            port {
> > +                ucam_out: endpoint {
> > +                    remote-endpoint = <&mipi_in_ucam>;
> > +                    data-lanes = <1 2>;
> > +                    link-frequencies = /bits/ 64 <450000000>;
> > +                };
> > +            };
> > +        };
> > +    };
> > \ No newline at end of file
> 
> ^^^ This has to be fixed.
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> Best regards,
> Krzysztof

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
