Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562F74BD04D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbiBTRd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:33:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbiBTRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:33:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5A2CC8B;
        Sun, 20 Feb 2022 09:33:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 674B160DC7;
        Sun, 20 Feb 2022 17:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0DEC340E8;
        Sun, 20 Feb 2022 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645378383;
        bh=8q7//Sk7DHFweHerADNXnSPuOBjE/leZSiwsR8HLToM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Az3mXqslYQ92lmQIlaTq/BC85BuJjjAe20UaW2/gc8oimvfyByPi6QQmuYsThENGJ
         1aiCEhYULxBNySZChcc31MIy+kzt2okGwshVYQfSsqdpSfQzZREfyYPcQsDJrWD2RV
         hSqq4KLLPh4iVzaQX+FvF1r/3r/drSr+R8rACJ00/15yQjzy+xIyo7ZD1xv1myaOkB
         5Ew7d3GB4/fmh8XmbwsvP2HtvQdW6KpKitjF3ll1r5x49vA5gIOQhtXqTvlgSOb8V0
         J6OFpVLN2pbpaGCR/Ak8dbygkyRbD9gLvzt4hS5VNnTNIRPyNuckZPPkBefYefomvR
         9fV3E6aGiZHeQ==
Date:   Sun, 20 Feb 2022 17:39:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 2/4] dt-bindings:iio:frequency: add admv1014 binding
Message-ID: <20220220173955.7e9804ae@jic23-huawei>
In-Reply-To: <c7e39902-c85a-c601-8b9c-b2292ffeb46d@canonical.com>
References: <20220215081216.67706-1-antoniu.miclaus@analog.com>
        <20220215081216.67706-2-antoniu.miclaus@analog.com>
        <c7e39902-c85a-c601-8b9c-b2292ffeb46d@canonical.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2022 13:16:41 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> On 15/02/2022 09:12, Antoniu Miclaus wrote:
> > Add device tree bindings for the ADMV1014 Upconverter.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>  
> 
> Your subject seems still wrongly formatted.
> > ---
> > changes in v8:
> >  - remove `clock-cells`
> >  - rename device node to be more generic
> >  - set 'maxItems' for clocks property
> >  .../bindings/iio/frequency/adi,admv1014.yaml  | 134 ++++++++++++++++++
> >  1 file changed, 134 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> > 
> > diff --git a/Documentation/d  
> 
> (...)
> 
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      converter@0{  
> 
> Missing space after address... I thought you will correct it while
> changing node name.
Fixed up.

> 
> 
> > +        compatible = "adi,admv1014";
> > +        reg = <0>;
> > +        spi-max-frequency = <1000000>;
> > +        clocks = <&admv1014_lo>;
> > +        clock-names = "lo_in";
> > +        vcm-supply = <&vcm>;
> > +        vcc-if-bb-supply = <&vcc_if_bb>;
> > +        vcc-vga-supply = <&vcc_vga>;
> > +        vcc-vva-supply = <&vcc_vva>;
> > +        vcc-lna-3p3-supply = <&vcc_lna_3p3>;
> > +        vcc-lna-1p5-supply = <&vcc_lna_1p5>;
> > +        vcc-bg-supply = <&vcc_bg>;
> > +        vcc-quad-supply = <&vcc_quad>;
> > +        vcc-mixer-supply = <&vcc_mixer>;
> > +        adi,quad-se-mode = "diff";
> > +        adi,detector-enable;
> > +        adi,p1db-compensation-enable;
> > +      };
> > +    };
> > +...  
> 
> 
> Best regards,
> Krzysztof

