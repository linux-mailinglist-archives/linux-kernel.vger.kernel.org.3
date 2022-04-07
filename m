Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD74F889E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiDGUag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDGUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:30:25 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B37488BF1;
        Thu,  7 Apr 2022 13:14:27 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e1dcc0a327so7641417fac.1;
        Thu, 07 Apr 2022 13:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8g+U9TYp/KmmutHAdrKb6oEqOtOebbJJ9ukyAtaTjY=;
        b=XJcnhIpiYMOxhngocfK+VpucVypVNKWVH2ng3I8RijRkOd3swiqTfL8jFy0tSrDsY+
         hXaULqkx1jxW4vIVVvwqRnpjf+cYvcj541XGwtZW9cgajD6EFUQu5vRnhPwTKfBtmQMp
         WhBBjn2zzBD4hQk+JgedEVj8PpfVuGF9/tS5Pjy8Wm5ca4hTGWZFVfEV79cC4cHuAvfh
         jzqboWNJ0Vjs78e4nkD6gj1ePU3Mu0NYJqX2k6TxyPFPF/G2c9ZGxQifRtId/0wevGak
         07FL8jc9+95kzqReIO5aXZl/EBd38sVxnSR5E6n9P6vqLnQz9fj/br3IPoDzXKNKf6An
         MFEQ==
X-Gm-Message-State: AOAM53196iJTGLtwCyVm1uje7/IdiF8kFKuUTVYlbn0dr5IA/S5fL16n
        AYFZExe7TAMDPHxkVuEtC5UHkXg3KQ==
X-Google-Smtp-Source: ABdhPJzeXgT9Q5IYKIz+EYQMeOpGd8AuneYxtVUaG+rzCa3QCbyIQNYh9GDr8IdPqVbaFIKA/vvucQ==
X-Received: by 2002:a54:4792:0:b0:2ef:7562:dcd7 with SMTP id o18-20020a544792000000b002ef7562dcd7mr6434763oic.263.1649361846938;
        Thu, 07 Apr 2022 13:04:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay5-20020a056820150500b00320f8a179d0sm8193572oob.30.2022.04.07.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:04:06 -0700 (PDT)
Received: (nullmailer pid 1873984 invoked by uid 1000);
        Thu, 07 Apr 2022 20:04:05 -0000
Date:   Thu, 7 Apr 2022 15:04:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 14/14] dt-bindings: reset: Convert to yaml
Message-ID: <Yk9DtXO/yUIO45gN@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-14-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-14-p.zabel@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 05:43:38PM +0200, Philipp Zabel wrote:
> Convert the common reset controller and reset consumer device tree
> bindings to YAML schema.

In general, common bindings should go in DT schema repo:

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reset/reset.yaml


Though part of the issue is dtschema is dual licensed and all the 
exsting text is GPL2, so permission to relicense is needed. That's why 
the schemas are just the schema and little description ATM. Shouldn't 
be too hard here with Stephen/NVIDIA being the only copyright holder.

> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Stephen Warren <swarren@nvidia.com>
> ---
>  .../bindings/reset/reset-consumer.yaml        | 72 ++++++++++++++++++
>  .../bindings/reset/reset-controller.yaml      | 50 +++++++++++++
>  .../devicetree/bindings/reset/reset.txt       | 75 -------------------
>  3 files changed, 122 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/reset-consumer.yaml
>  create mode 100644 Documentation/devicetree/bindings/reset/reset-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/reset/reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/reset-consumer.yaml b/Documentation/devicetree/bindings/reset/reset-consumer.yaml
> new file mode 100644
> index 000000000000..e17229eb49c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/reset-consumer.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2012 Stephen Warren <swarren@nvidia.com>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/reset-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common reset signal consumer bindings
> +
> +maintainers:
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description: |
> +  Hardware blocks typically receive a reset signal. This signal is generated by
> +  a reset provider (e.g. power management or clock module) and received by a
> +  reset consumer (the module being reset, or a module managing when a sub-
> +  ordinate module is reset). This binding exists to represent the consumers of
> +  reset signals provided by reset controllers.
> +
> +  A reset signal is represented by the phandle of the provider, plus a reset
> +  specifier - a list of DT cells that represents the reset signal within the
> +  provider. The length (number of cells) and semantics of the reset specifier
> +  are dictated by the binding of the reset provider, although common schemes
> +  are described below.
> +
> +  A word on where to place reset signal consumers in device tree: It is possible
> +  in hardware for a reset signal to affect multiple logically separate HW blocks
> +  at once. In this case, it would be unwise to represent this reset signal in
> +  the DT node of each affected HW block, since if activated, an unrelated block
> +  may be reset. Instead, reset signals should be represented in the DT node
> +  where it makes most sense to control it; this may be a bus node if all
> +  children of the bus are affected by the reset signal, or an individual HW
> +  block node for dedicated reset signals. The intent of this binding is to give
> +  appropriate software access to the reset signals in order to manage the HW,
> +  rather than to slavishly enumerate the reset signal that affects each HW
> +  block.
> +
> +select: true
> +
> +properties:
> +  resets:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      List of phandle and reset specifier pairs, one pair for each reset signal
> +      that affects the device, or that the device manages.
> +      Note: if the reset provider specifies '0' for "#reset-cells", then only
> +      the phandle portion of the pair will appear.
> +
> +  reset-names:
> +    description: |
> +      List of reset signal name strings sorted in the same order as the resets
> +      property. Consumers drivers will use "reset-names" to match reset signal
> +      names with reset specifiers.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    // A device with a single reset signal named "reset".
> +    device {
> +        resets = <&rst 20>;
> +        reset-names = "reset";
> +    };
> +  - |
> +    // A bus that controls the reset signal of each of four subordinate
> +    // devices. Consider for example a bus that fails to operate unless no
> +    // child device has reset asserted.
> +    bus {
> +        resets = <&rst 10>, <&rst 11>, <&rst 12>, <&rst 11>;
> +        reset-names = "i2s1", "i2s2", "dma", "mixer";
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/reset/reset-controller.yaml b/Documentation/devicetree/bindings/reset/reset-controller.yaml
> new file mode 100644
> index 000000000000..33468f94f4c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/reset-controller.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2021 Stephen Warren <swarren@nvidia.com>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/reset-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common reset controller provider bindings
> +
> +maintainers:
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description: |
> +  This binding is intended to represent the hardware reset signals present
> +  internally in most IC (SoC, FPGA, ...) designs. Reset signals for whole
> +  standalone chips are most likely better represented as GPIOs, although there
> +  are likely to be exceptions to this rule.
> +
> +  Hardware blocks typically receive a reset signal. This signal is generated by
> +  a reset provider (e.g. power management or clock module) and received by a
> +  reset consumer (the module being reset, or a module managing when a sub-
> +  ordinate module is reset). This binding exists to represent the provider of
> +  one or more reset signals.
> +
> +select:
> +  anyOf:
> +    - properties:
> +        $nodename:
> +          pattern: '^reset-controller'

This actually serves no purpose unless you made #reset-cells required. 
If the node name matches, the schema will be applied and be true whether 
#reset-cells is present or not.

We were trying to define the node name for providers, but that breaks in 
cases of nodes that are multiple providers which as you know is common 
in this case. So we need to come up with another way of encouraging 
standard node names.

> +    - required:
> +        - '#reset-cells'
> +
> +properties:
> +  '#reset-cells':
> +    $ref: /schemas/types.yaml#/definitions/uint32

'#.*-cells' has a type already. The only thing you can really put here 
would be some constraint on the range of number of cells allowed and a 
description.

> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    // A reset controller providing multiple reset controls
> +    rst: reset-controller {
> +        #reset-cells = <1>;
> +    };
> +
> +    // A reset consumer receiving a single reset signal with index 0
> +    peripheral {
> +        resets = <&rst 0>;
> +    };
> +...
