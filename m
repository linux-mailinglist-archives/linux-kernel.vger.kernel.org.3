Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA1C57BFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiGTVjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGTVjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:39:03 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D11F2C5;
        Wed, 20 Jul 2022 14:39:02 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id e69so7853799iof.5;
        Wed, 20 Jul 2022 14:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDsSTKrt1WJntEl5IdmwBHh43xOnQ5S8b8hDIYAsjgM=;
        b=kk8wTJywTbgSkN+pCB1zL+n4w4RKcY4oF3LoEemnxPyHxbvopDlZcaTZSFcyfKz+Qv
         7XgwW5CmSbPAy1t6h57OVhJKXUvkeJKHOKXi3M2QUXKpETvgLUJLHL1RiUIzGsGaodSv
         JRgHHfln7BILBgK8dST6pRUlTOjhcHgSS/aA5CtuxY1EwBCcV2O2y6NNaDC6mGoY1/sw
         EqNMUvuVhSQ6S2eJokbccTBCG++jNPd2fSmW79YhK4z76jDbH017jUMkHVMG/jmXfKeL
         6hkCyn5fjD+wWrkisWp0xUTjyBFQR74Jsv47LhC83zbM2w+p6O8/GrECIvXU40Ynn/I9
         v5sw==
X-Gm-Message-State: AJIora8OwNKOW0a7HRZyt5hIjL/szNEUCckbs33rUBTQ/esX5FrTqBpB
        SkFhwbaSVgpG6ypVZkIKGA==
X-Google-Smtp-Source: AGRyM1tUUVrA5v0X6JgSDqVEadq5vl3QmcLPhbN8rvrqMABS496lU7d3HeIpFlX3wiNi7LAHT24QFA==
X-Received: by 2002:a05:6638:2595:b0:341:4683:782a with SMTP id s21-20020a056638259500b003414683782amr16646288jat.49.1658353142026;
        Wed, 20 Jul 2022 14:39:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p17-20020a92d691000000b002dbfcfa3233sm62236iln.37.2022.07.20.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:39:01 -0700 (PDT)
Received: (nullmailer pid 4027410 invoked by uid 1000);
        Wed, 20 Jul 2022 21:39:00 -0000
Date:   Wed, 20 Jul 2022 15:39:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: Re: [PATCH 1/3] dt-bindings usb: typec: rt1711h: Add binding for
 Richtek RT1711H
Message-ID: <20220720213900.GA4021129-robh@kernel.org>
References: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
 <20220715100418.155011-2-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715100418.155011-2-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:16PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add binding for Richtek RT1711H
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  .../bindings/usb/richtek,rt1711h.yaml         | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> new file mode 100644
> index 000000000000..b6daca71429b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Richtek RT1711H Type-C Port Switch and Power Delivery controller DT bindings

s/ DT bindings//

> +
> +maintainers:
> +  - Gene Chen <gene_chen@richtek.com>
> +
> +description: |

Don't need '|' if no formatting.

> +  - Richtek RT1711H TypeC PD Controller.

'-' should be dropped. Though if you can't say more than the title, you 
might as well drop entirely.

> +
> +properties:
> +  compatible:
> +    oneOf:

Don't need oneOf with only 1 entry.

> +      - enum:
> +          - richtek,rt1711h
> +          - richtek,rt1715

Perhaps 'description' should detail the differences in these parts.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  wakeup-source:
> +    description: enable IRQ remote wakeup, see power/wakeup-source.txt

Drop generic descriptions.

> +    type: boolean
> +
> +  connector:
> +    type: object
> +    $ref: ../connector/usb-connector.yaml#

full path:

/schemas/connector/...

> +    description:
> +      Properties for usb c connector.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - connector
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/usb/pd.h>
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt1711h@4e {
> +        compatible = "richtek,rt1711h";
> +        reg = <0x4e>;
> +        interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
> +        wakeup-source;
> +
> +        connector {
> +          compatible = "usb-c-connector";
> +          label = "USB-C";
> +          data-role = "dual";
> +          power-role = "dual";
> +          try-power-role = "sink";
> +          source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> +          sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> +          op-sink-microwatt = <10000000>;
> +
> +          ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +              reg = <0>;
> +              endpoint {
> +                remote-endpoint = <&usb_hs>;
> +              };
> +            };
> +            port@1 {
> +              reg = <1>;
> +              endpoint {
> +                remote-endpoint = <&usb_ss>;
> +              };
> +            };
> +            port@2 {
> +              reg = <2>;
> +              endpoint {
> +                remote-endpoint = <&dp_aux>;
> +              };
> +            };
> +          };
> +        };
> +      };
> +    };
> +...
> -- 
> 2.25.1
> 
> 
