Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D655500098
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiDMVIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbiDMVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:08:19 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57CA8567F;
        Wed, 13 Apr 2022 14:05:45 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id e4so3408707oif.2;
        Wed, 13 Apr 2022 14:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gFOeEZI4pNvyN/LTAgs9rmC19q7UkYUYT1AJpJxfpdI=;
        b=CLMygoQkFZgsg9JIYleQ/To94LdtInmzdM0RwpZCpzVvzNCyqjeHcuZwVNW2eqGrgo
         h6XsG/emJnvdlU1e+R4GyW1vj0HUgrEJlzXoFJGiOtD+ug7MPOL1MdRV3o7O6nVEWvbH
         92Ka1+EXAp1BofddkFnvJidBQ7A/pnqUFojJtJ7Ix2j+3tME1dE5xtYvlrGECdoKivpW
         chHUfy5HIe4layMfrRk122/b45OvX8l6LBmQ4bEqUqKzsYf+0PeGw8b4QcaBcBT5ysCr
         zO9nPeDYSarqdUyr+yKsUvqrXsYWdXP46aiaNElAT4CRBfV7Wl1O0AH0JRfEquSlaRRt
         38qw==
X-Gm-Message-State: AOAM532qyjP+jGApTg6EWXS6jw174s5pWl/ZUBp91oAnNQB7L4IFzq/r
        aeGMLegu6sZkVQHzNpQZCA==
X-Google-Smtp-Source: ABdhPJx5RFeYJLnhl//6T0M97AfdmhJRF0naPw/lnbT5EgrjjTgh8f2EadEd00qJESa3eceTDi9c0w==
X-Received: by 2002:a05:6808:1a26:b0:2da:1bae:5186 with SMTP id bk38-20020a0568081a2600b002da1bae5186mr22287oib.144.1649883945133;
        Wed, 13 Apr 2022 14:05:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o7-20020a056871078700b000e29ff467dcsm44358oap.50.2022.04.13.14.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:05:44 -0700 (PDT)
Received: (nullmailer pid 3917373 invoked by uid 1000);
        Wed, 13 Apr 2022 21:05:44 -0000
Date:   Wed, 13 Apr 2022 16:05:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC
 bindings
Message-ID: <Ylc7KJBXPXNML7UM@robh.at.kernel.org>
References: <20220408224321.627126-1-bjorn.andersson@linaro.org>
 <0eb126b3-b323-9614-361a-22c2762b590a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb126b3-b323-9614-361a-22c2762b590a@linaro.org>
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

On Sat, Apr 09, 2022 at 06:41:25PM +0200, Krzysztof Kozlowski wrote:
> On 09/04/2022 00:43, Bjorn Andersson wrote:
> > Add binding for the Qualcomm SC8280XP Global Clock controller.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  .../bindings/clock/qcom,gcc-sc8280xp.yaml     | 199 +++++++
> >  include/dt-bindings/clock/qcom,gcc-sc8280xp.h | 496 ++++++++++++++++++
> >  2 files changed, 695 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> >  create mode 100644 include/dt-bindings/clock/qcom,gcc-sc8280xp.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> > new file mode 100644
> > index 000000000000..44e5f0d0a795
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> > @@ -0,0 +1,199 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,gcc-sc8280xp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Global Clock & Reset Controller Binding for SC8280xp
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +
> > +description: |
> > +  Qualcomm global clock control module which supports the clocks, resets and
> > +  power domains on SC8280xp.
> > +
> > +  See also:
> > +  - dt-bindings/clock/qcom,gcc-sc8280xp.h
> 
> include/dt-bindings/...
> 
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,gcc-sc8280xp
> > +
> 
> (...)
> 
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  protected-clocks:
> > +    description:
> > +      Protected clock specifier list as per common clock binding.
> 
> There is still no schema with protected-clocks, so you need a type,
> unless someoone is working on adding this to schema?

The 16th addition always gets caught...

I've just added one to dtschema.

Rob
