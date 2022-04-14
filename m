Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEBD5018A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiDNQZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245730AbiDNQOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:14:17 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC3C31F2;
        Thu, 14 Apr 2022 08:57:25 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-dacc470e03so5686062fac.5;
        Thu, 14 Apr 2022 08:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/HgJFU5eyBdqThPB7Gif/3NbbgBxIgCKOJJWS03GxI=;
        b=h4zUXu3avlhZ8qSHZhOr5ForkeDLpTq09ixAxVLBvIGtEpJqxmnuLoKGZ8VGBOkbxg
         tijkkAhzgo/tFPqWvDv0KzhJX/+ov/95v5zRQm9Nio+xtH+gG1RacpY2Yi5chJ0l9PED
         Kno78itgn7apNHbcV8pCUWmwEFTteLTN8KxQPoTynFgEZucnlM7D1wEKhK5NCd/zSU4n
         AaA/NHgH+LSGsbiXcJf2vKADrjB9r+HVaAq7uZ9E0G9YYbaSb9/naso5G4ixMFrHVr8m
         nIHH9H1ChBAtdP7HiP8LFEsLX769vc5cn1UdInAJZ7Qgf+SVB4r2yvW9M7QTYonZgAUN
         uqcA==
X-Gm-Message-State: AOAM530YId9DWhiijYjRa8y97cyDo9JWR6oxUb7B5KPf/1HJJahlnc1m
        69SZvjc0c96itAPtXDlBwg==
X-Google-Smtp-Source: ABdhPJyQchtfSX/mwpYjIzUd1rTj7rtUPQjMM1F1iQB/k7vCs37gybUojwv5hvsA8UyY6S1hVlutSg==
X-Received: by 2002:a05:6870:f2a9:b0:e5:8106:4486 with SMTP id u41-20020a056870f2a900b000e581064486mr1102887oap.109.1649951843522;
        Thu, 14 Apr 2022 08:57:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c19-20020a9d7853000000b005cdbc0f02ccsm144090otm.68.2022.04.14.08.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:57:23 -0700 (PDT)
Received: (nullmailer pid 2129759 invoked by uid 1000);
        Thu, 14 Apr 2022 15:57:22 -0000
Date:   Thu, 14 Apr 2022 10:57:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     "J, KEERTHY" <j-keerthy@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org, linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Message-ID: <YlhEYq8pGsuoA2mv@robh.at.kernel.org>
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-2-j-keerthy@ti.com>
 <17474b72-d823-e1ff-9831-c5f9f887fccd@linaro.org>
 <54d597e9-5cad-fc44-954d-7de45018fdcf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d597e9-5cad-fc44-954d-7de45018fdcf@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 05:34:20PM +0530, J, KEERTHY wrote:
> 
> 
> On 4/13/2022 3:43 PM, Krzysztof Kozlowski wrote:
> > On 12/04/2022 12:14, Keerthy wrote:
> > > Add VTM bindings documentation. In the Voltage Thermal
> > > Management Module(VTM), K3 J72XX supplies a voltage
> > > reference and a temperature sensor feature that are gathered in the band
> > > gap voltage and temperature sensor (VBGAPTS) module. The band
> > > gap provides current and voltage reference for its internal
> > > circuits and other analog IP blocks. The analog-to-digital
> > > converter (ADC) produces an output value that is proportional
> > > to the silicon temperature.
> > > 
> > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > > ---
> > >   .../bindings/thermal/ti,j72xx-thermal.yaml    | 62 +++++++++++++++++++
> > >   1 file changed, 62 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > > new file mode 100644
> > > index 000000000000..8483c495cb9a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > > @@ -0,0 +1,62 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/thermal/ti,j72xx-thermal.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Texas Instruments J72XX VTM (DTS) binding
> > > +
> > > +maintainers:
> > > +  - Keerthy <j-keerthy@ti.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ti,j721e-vtm
> > > +    oneOf:
> > > +      - enum:
> > > +          - ti,j721e-vtm
> > > +          - ti,j7200-vtm
> > 
> > It seems you resent this ignoring all of Rob's comments. In changelog of
> > cover letter you wrote "Fixed all the comments on v4" but it's not true.
> > Maybe you sent us old patch?
> > 
> > Anyway, you need to follow Rob's comments.
> 
> Krzysztof,
> 
> Apologies. Some issues with my mailbox. Rob's response didn't reach me for
> some reason.

Maybe because I'm still banned by TI. Just had another bounce a few days 
ago.

Rob
