Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C568C4AF322
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiBINm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiBINmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:42:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F2C0613C9;
        Wed,  9 Feb 2022 05:42:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n8so1499197wmk.3;
        Wed, 09 Feb 2022 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YSwObgToM4kQkShxGRlE4JLVRXyN035rThcxif13VzA=;
        b=OkHRuDgQwVHDaFa2UWL1r8LK6cbtlGI+crQyAALWgl0h2f9TP3qdmzNn3QsY+MfgGN
         0b/rGu9nMf2WpGk78FU38nqihLnjuaokRaDAUZ6fN93AQuGwn4WLM6PcZVf2gGeHq8zG
         rgmJ2NlUi1OCwtuDIrtLsjlSKuPGpHGRdbTPH4dATJY6hO4cmnqwxoNvACJ53K6evnv2
         /UQn0Ivd8H0jo/A9g0UyQr8csk1Q9QsEb7pPKjQVmBKQa18TfKVXEZ5pxHQr2PRZIrqL
         ORMHQfLK/PIDbkyoP3Nsro1UDM20wR4Bml7dIg+glp3kXJifR6awDXd4VK1refIrhXaR
         fxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YSwObgToM4kQkShxGRlE4JLVRXyN035rThcxif13VzA=;
        b=7P28akfqfXTrYnCiwWpmocEiNrejRYlJTx3P/qF98403g6NkCvII8Rf6lJzIawPICX
         48T/pDMomwiTiidUynM3Utnygfm2DesLMg84H58IplSglHD6pYXTbF7FFEHJhboRpAfk
         51DXt/X9x9bYvMY7CnQ+alfMTw2XZsecT+VBRPv3+XEUroTi6oQPWAT27S3RMYvp88KO
         iqCkahpAk89eRItugbm7bini0wcRzVec5grM6Xy8lF/4rCdTGRMpDDIw+O0sPlBWwSQU
         uUtLQSEZGIPggyVxYaClqrbU3ZtBT4MWJY/LQSjWfGaIZTR7FzJzWDtgbtAF/PYAh9yl
         Zotw==
X-Gm-Message-State: AOAM531DffLjQXuC/TbqlslY151g/WIVDDUUtkya4XjtaJbq2NhDk93e
        FmRLRA9T/agyf0O73fMe6c4=
X-Google-Smtp-Source: ABdhPJypFm6cL4U5dgqLRpJn5YYRjPRSd1zny+ieSxBrCf0f+XCVBug/Gc9F5C2zLYeoumwUbtAW4g==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr2084721wmk.149.1644414173043;
        Wed, 09 Feb 2022 05:42:53 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id o10sm3483320wrc.98.2022.02.09.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 05:42:52 -0800 (PST)
Date:   Wed, 9 Feb 2022 14:42:50 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: crypto: convert rockchip-crypto to yaml
Message-ID: <YgPE2qdHccJQm4mR@Red>
References: <20220209124725.2080986-1-clabbe@baylibre.com>
 <2571349.qrhAyUUNuM@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2571349.qrhAyUUNuM@diego>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Feb 09, 2022 at 01:52:45PM +0100, Heiko Stübner a écrit :
> Am Mittwoch, 9. Februar 2022, 13:47:25 CET schrieb Corentin Labbe:
> > Convert rockchip-crypto to yaml.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
> >  .../bindings/crypto/rockchip-crypto.yaml      | 64 +++++++++++++++++++
> >  2 files changed, 64 insertions(+), 28 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> >  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt b/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> > deleted file mode 100644
> > index 5e2ba385b8c9..000000000000
> > --- a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> > +++ /dev/null
> > @@ -1,28 +0,0 @@
> > -Rockchip Electronics And Security Accelerator
> > -
> > -Required properties:
> > -- compatible: Should be "rockchip,rk3288-crypto"
> > -- reg: Base physical address of the engine and length of memory mapped
> > -       region
> > -- interrupts: Interrupt number
> > -- clocks: Reference to the clocks about crypto
> > -- clock-names: "aclk" used to clock data
> > -	       "hclk" used to clock data
> > -	       "sclk" used to clock crypto accelerator
> > -	       "apb_pclk" used to clock dma
> > -- resets: Must contain an entry for each entry in reset-names.
> > -	  See ../reset/reset.txt for details.
> > -- reset-names: Must include the name "crypto-rst".
> > -
> > -Examples:
> > -
> > -	crypto: cypto-controller@ff8a0000 {
> > -		compatible = "rockchip,rk3288-crypto";
> > -		reg = <0xff8a0000 0x4000>;
> > -		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> > -		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
> > -			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
> > -		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
> > -		resets = <&cru SRST_CRYPTO>;
> > -		reset-names = "crypto-rst";
> > -	};
> > diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
> > new file mode 100644
> > index 000000000000..392d89055398
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/crypto/rockchip-crypto.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip Electronics And Security Accelerator
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> > +    const: rockchip,rk3288-crypto
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: clock data
> > +      - description: clock data
> > +      - description: clock crypto accelerator
> > +      - description: clock dma
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aclk
> > +      - const: hclk
> > +      - const: sclk
> > +      - const: apb_pclk
> > +
> > +  resets:
> > +    minItems: 1
> > +
> > +  reset-names:
> > +    const: crypto-rst
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +  - reset-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> 
> Binding itself looks good.
> 
> But the constants below will probably trigger a compiler-error and
> therefore Rob's bot.
> 
> You will need something like 
> 
>     #include <dt-bindings/clock/rk3399-cru.h>
>     #include <dt-bindings/interrupt-controller/arm-gic.h>
> 
> here.
> 
> A "make ..... dt_binding_check" should show the issue and also
> it going away with the right includes ;-)
> 
> Heiko
> 

Right, I forgot to add this file in my "dt to check" via dt_binding_check, but the following make dtbs_check made me believe it was tested.

I will send a v2 soon.

Regards
