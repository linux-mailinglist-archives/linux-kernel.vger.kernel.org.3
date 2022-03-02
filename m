Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C834CAD54
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbiCBSRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiCBSRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:17:18 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F905D76CD;
        Wed,  2 Mar 2022 10:16:35 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id l21-20020a056830239500b005afd2a7eaa2so2373796ots.9;
        Wed, 02 Mar 2022 10:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P3MRIK5gW2O7mrW4QZKZYfeNk1HyToDuaqXYaRPQ9IY=;
        b=6hhpudyoPcac3eexHiU/T+qO0veMgkw59VkqUX6SFont7g8+bdueN7gkqmoUmP9YpY
         CrtGX3FIoTE7InUWHd862A4SzH9/fJZvJ4OJ97IPpKv21pzdEazIA4r8EXGY5mbgqNsV
         NFFG0rdhbH9DG4GR8mxoLa2BuBzayLN4oGLqjnIgJw2XE7OAwVGpSDpAqh0Vnytx4/5K
         bmXT2c1SuFWhw8fj67TYb7sqOubTk35OWt+Gp8AdzFeXUViU6uLchWfXd6EvE74j1Zfa
         cvc6I7/AbjAX/jo/KCd7hR0VkeUVINkInOfVzWQ6eYoU7Cs/ARjX/vcUgQjCC7yLLPQD
         wJ7A==
X-Gm-Message-State: AOAM531OTw8qtkQeWQ+kz5/o7ZMu3KKIfmpT09hT9xH66mATKp5D6eXV
        ZQMxUJlqcAd0ZCIrqOVJog==
X-Google-Smtp-Source: ABdhPJw8B8/gKP1lgIHA99pQq3ABpDWurRMZW0Mj/KfZWTaN7JRlomYR8ZI7Za1D4HwaIBFKjKiLKg==
X-Received: by 2002:a05:6830:418f:b0:5a6:e75:cb7 with SMTP id r15-20020a056830418f00b005a60e750cb7mr15971120otu.66.1646244994603;
        Wed, 02 Mar 2022 10:16:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l6-20020a056870d3c600b000d75713938csm2110023oag.7.2022.03.02.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:16:33 -0800 (PST)
Received: (nullmailer pid 3992016 invoked by uid 1000);
        Wed, 02 Mar 2022 18:16:33 -0000
Date:   Wed, 2 Mar 2022 12:16:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?utf-8?B?77+9aXByYWdh?= <alsi@bang-olufsen.dk>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: usb: add TUSB320xA Type-C port
 controller
Message-ID: <Yh+0gWTmjrAJGAiG@robh.at.kernel.org>
References: <20220301132010.115258-1-alvin@pqrs.dk>
 <20220301132010.115258-2-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301132010.115258-2-alvin@pqrs.dk>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 02:20:05PM +0100, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The TUSB320xA is a non-PD Type-C port controller managed over I2C.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  .../devicetree/bindings/usb/ti,tusb320xa.yaml | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb320xa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tusb320xa.yaml b/Documentation/devicetree/bindings/usb/ti,tusb320xa.yaml
> new file mode 100644
> index 000000000000..a93d53ddd01c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,tusb320xa.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,tusb320xa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TUSB320xA Type-C port controller DT bindings
> +
> +description:
> +  The Texas Instruments TUSB320xA is a USB Type-C port controller which
> +  supports role and plug orientation detection using the CC pins. It is
> +  compatible with the USB Type-C Cable and Connector Specification v1.1.
> +
> +maintainers:
> +  - Alvin Šipraga <alsi@bang-olufsen.dk>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tusb320la
> +      - ti,tusb320ha
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    patternProperties:
> +      '^port@':

Exact port numbers need to be defined. What does port@0 represent? 
port@1?

> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          OF graph bindings modelling any "usb-role-switch" or "accessory" mux.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      tcpc@47 {
> +        compatible = "ti,tusb320la";
> +        reg = <0x47>;
> +        interrupt-parent = <&gpio5>;
> +        interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            typec1_mux: endpoint {
> +              remote-endpoint = <&usb_audio_mux1>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +            typec1_dr_sw: endpoint {
> +              remote-endpoint = <&usbotg1_drd_sw>;
> +            };
> +          };
> +        };
> +      };
> +    };
> -- 
> 2.35.1
> 
