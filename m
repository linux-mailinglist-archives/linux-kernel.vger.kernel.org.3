Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024814E1D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbiCTTAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 15:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiCTTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 15:00:12 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C313D74;
        Sun, 20 Mar 2022 11:58:48 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id b189so10358978qkf.11;
        Sun, 20 Mar 2022 11:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PHOF0SFFMoXRZFXDCMuTXmTntMsUKpjlTMI+kRK8fS8=;
        b=e6cS8BRbFi/a9xrsrZGitoBMkikHUIhF6ZYgX3vZZqwUNwy7g7CSC6MewLy/969Ugi
         2Rlj6VT2yAqLCM+Xdey6H6OLI5QRbCNcgbjORVwRKqTTkHSbHlqBpNYdW8PmA2zUoOit
         KVqdTNNmb+uF5Ww6AUGA0MnljHmi1JSoeTRombLfDLvbICok9A8eHbyVIa8hCGE0B7BR
         LZDmL0mC/LAo8Xz1iaHsBMr/Sochv1yovhurBqY+NjU1w9mTQTdifG50vE9JoPHjqZvW
         sevZ+9Eoa20pcMS403DQisjYGE31rU8XZwNRow4CSYgc9y++oszgdKW3tV1jXDgixKP7
         q1kQ==
X-Gm-Message-State: AOAM533YlPAE7+4oOGTmUOakAGgY2LFWYoCX9UT+suK38iWSiPIyFDIN
        i2IieKQHFs/0PIo3EcGu/41m859zSQ==
X-Google-Smtp-Source: ABdhPJxr219qZg3D/1NQSCReddXSPB7EWl/iBBU7odWpEFwoFTkCKVm2nclCIZmzF/Vx1gwp6QvodQ==
X-Received: by 2002:a05:620a:68a:b0:67b:3135:a9aa with SMTP id f10-20020a05620a068a00b0067b3135a9aamr10808569qkh.508.1647802727985;
        Sun, 20 Mar 2022 11:58:47 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c6d:21ec:c4f5:bb3:5269:3b0e])
        by smtp.gmail.com with ESMTPSA id j21-20020ac85f95000000b002e1cde99863sm10164844qta.83.2022.03.20.11.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 11:58:46 -0700 (PDT)
Received: (nullmailer pid 3213901 invoked by uid 1000);
        Sun, 20 Mar 2022 18:58:44 -0000
Date:   Sun, 20 Mar 2022 14:58:44 -0400
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5 v2] dt-bindings: gnss: Rewrite sirfstar binding in
 YAML
Message-ID: <Yjd5ZFzTHIl+NAWV@robh.at.kernel.org>
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
 <20220317225844.1262643-3-linus.walleij@linaro.org>
 <67600921-a4ea-367e-6b45-c4a1a12ae88b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67600921-a4ea-367e-6b45-c4a1a12ae88b@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:29:03AM +0100, Krzysztof Kozlowski wrote:
> On 17/03/2022 23:58, Linus Walleij wrote:
> > This rewrites the SiRFstar DT bindings in YAML.
> > 
> > Cc: devicetree@vger.kernel.org
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - Change additionalProperties: false to uneavaluatedProperties: false
> >   so new common properties get available immediately
> > - This should also make the checker robot happy about
> >   lna-supply
> > ---
> >  .../devicetree/bindings/gnss/sirfstar.txt     | 46 ------------
> >  .../devicetree/bindings/gnss/sirfstar.yaml    | 71 +++++++++++++++++++
> >  2 files changed, 71 insertions(+), 46 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt
> >  create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
> > deleted file mode 100644
> > index f4252b6b660b..000000000000
> > --- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
> > +++ /dev/null
> > @@ -1,46 +0,0 @@
> > -SiRFstar-based GNSS Receiver DT binding
> > -
> > -SiRFstar chipsets are used in GNSS-receiver modules produced by several
> > -vendors and can use UART, SPI or I2C interfaces.
> > -
> > -Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> > -properties.
> > -
> > -Required properties:
> > -
> > -- compatible	: Must be one of
> > -
> > -			"fastrax,uc430"
> > -			"linx,r4"
> > -			"wi2wi,w2sg0004"
> > -			"wi2wi,w2sg0008i"
> > -			"wi2wi,w2sg0084i"
> > -
> > -- vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)
> > -
> > -Required properties (I2C):
> > -- reg		: I2C slave address
> > -
> > -Required properties (SPI):
> > -- reg		: SPI chip select address
> > -
> > -Optional properties:
> > -
> > -- sirf,onoff-gpios	: GPIO used to power on and off device (pin name: ON_OFF)
> > -- sirf,wakeup-gpios	: GPIO used to determine device power state
> > -			  (pin name: RFPWRUP, WAKEUP)
> > -- timepulse-gpios	: Time pulse GPIO (pin name: 1PPS, TM)
> > -
> > -Example:
> > -
> > -serial@1234 {
> > -	compatible = "ns16550a";
> > -
> > -	gnss {
> > -		compatible = "wi2wi,w2sg0084i";
> > -
> > -		vcc-supply = <&gnss_reg>;
> > -		sirf,onoff-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> > -		sirf,wakeup-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> > -	};
> > -};
> > diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.yaml b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
> > new file mode 100644
> > index 000000000000..9f80add3e61b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gnss/sirfstar.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiRFstar GNSS Receiver Device Tree Bindings
> > +
> > +allOf:
> > +  - $ref: gnss-common.yaml#
> 
> The allOf should be just before "properties:" (also in patch #2).
> 
> > +
> > +maintainers:
> > +  - Johan Hovold <johan@kernel.org>
> > +
> > +description:
> > +  The SiRFstar GNSS receivers have incarnated over the years in different
> > +  chips, starting from the SiRFstarIII which was a chip that was introduced in
> > +  2004 and used in a lot of dedicated GPS devices. In 2009 SiRF was acquired
> > +  by CSR (Cambridge Silicon Radio) and in 2012 the CSR GPS business was
> > +  acquired by Samsung, while some products remained with CSR. In 2014 CSR
> > +  was acquired by Qualcomm who still sell some of the SiRF products.
> > +
> > +  SiRF chips can be used over UART, I2C or SPI buses.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fastrax,uc430
> > +      - linx,r4
> > +      - wi2wi,w2sg0004
> > +      - wi2wi,w2sg0008i
> > +      - wi2wi,w2sg0084i
> > +
> > +  reg:
> > +    description:
> > +      The I2C Address, SPI chip select address. Not required on UART buses.
> > +
> > +  vcc-supply:
> > +    description:
> > +      Main voltage regulator, pin names such as 3V3_IN, VCC, VDD.
> > +
> > +  timepulse-gpios:
> > +    description: Comes with pin names such as 1PPS or TM
> 
> You don't need this, I think. It's coming from gnss-common.yaml.

I fixed up both and applied.

Rob
