Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673BB58EF82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiHJPiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiHJPiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:38:07 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237B528E02;
        Wed, 10 Aug 2022 08:38:06 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id s16so8478450ilp.3;
        Wed, 10 Aug 2022 08:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=d703OGIAWaJFqE2Rp42TVQVb31FLKdiwbLrmUlLlcDE=;
        b=L5i95qjc+Nm9zcx0eoQ8Za5h+H8IF/L2ssP9GwAMs8WNO1+LsrBr0IfbK6PZOYCc/H
         tM2SBhEk6t8ODqzobklRqrBYKFh3o5u08aymsTW1/Ol+XBhTazlTJP/dYAFuVA2tESGu
         cXXY8KGZv543UmtrI3fWIJoFnk05br1v8Zr66ut2vRgJIJUNEQW1VGzV9BHIgaQ1hPIT
         dDgJe8U0PEs9slu4IrlVtocp5mIPfTea39kejQuzQxL3ix7ImzTIGMFWkUYt5eY4ud5P
         GEUB5vO724bGpuYT+3eIlZQvV5nN5QY1tRswnEzMboxbshshg7RdCHU/a+mWw9Cg8kf1
         6uzg==
X-Gm-Message-State: ACgBeo3o/V0wVaI/LvXck0iIrEc046AyWt+7R+L5EQ5d/Rdu6LHdgRGa
        WKnwwcrIB7S1gZLj+txpmvs18t1Qfw==
X-Google-Smtp-Source: AA6agR7D2VESWtQ+d0hSJfH8s2E2QhlG9jzS2sKVav6VMuiuI2rzKmJsWkaPbCLm1IMZS1BYGQfocA==
X-Received: by 2002:a92:d950:0:b0:2df:afdb:3908 with SMTP id l16-20020a92d950000000b002dfafdb3908mr9158360ilq.319.1660145885264;
        Wed, 10 Aug 2022 08:38:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638110c00b003433846796esm1317158jal.5.2022.08.10.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:38:04 -0700 (PDT)
Received: (nullmailer pid 6576 invoked by uid 1000);
        Wed, 10 Aug 2022 15:38:02 -0000
Date:   Wed, 10 Aug 2022 09:38:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Message-ID: <20220810153802.GA585-robh@kernel.org>
References: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
 <20220810132822.32534-2-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810132822.32534-2-yuji2.ishikawa@toshiba.co.jp>
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

On Wed, Aug 10, 2022 at 10:28:19PM +0900, Yuji Ishikawa wrote:
> Adds the Device Tree binding documentation that allows to describe
> the Video Input Interface found in Toshiba Visconti SoCs.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> Chengelog v2:
> - no change
> 
> Changelog v3:
> - no change
> ---
>  .../bindings/media/toshiba,visconti-viif.yaml | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> new file mode 100644
> index 000000000..848ea5019
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/toshiba,visconti-viif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba Visconti5 SoC Video Input Interface Device Tree Bindings
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description: |

Don't need '|' if no formatting.

> +  Toshiba Visconti5 SoC Video Input Interface (VIIF) receives MIPI CSI2 video stream,
> +  processes the stream with embedded image signal processor (L1ISP, L2ISP), then stores pictures to main memory.

Wrap lines at 80 char.

> +
> +properties:
> +  compatible:
> +    const: toshiba,visconti-viif
> +
> +  reg:
> +    items:
> +      - description: registers for capture control
> +      - description: registers for CSI2 receiver control
> +
> +  interrupts:
> +    items:
> +      - description: Sync Interrupt
> +      - description: Status (Error) Interrupt
> +      - description: CSI2 Receiver Interrupt
> +      - description: L1ISP Interrupt
> +
> +  index:
> +    enum: [0, 1]

No, we don't do indices in DT. Why do you need this?

> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description: Input port node, single endpoint describing the CSI-2 transmitter.
> +
> +    properties:
> +      endpoint:
> +        $ref: video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            description: VIIF supports 2 or 4 data lines
> +            items:
> +              minItems: 1
> +              maxItems: 4
> +              items:
> +                - const: 1
> +                - const: 2
> +                - const: 3
> +                - const: 4

blank line

> +          clock-lanes:
> +            description: VIIF supports 1 clock line
> +            const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        viif0: viif@1c000000 {

Drop unused labels.

> +            compatible = "toshiba,visconti-viif";
> +            reg = <0 0x1c000000 0 0x6000>,
> +                  <0 0x1c008000 0 0x400>;
> +            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +            index = <0>;
> +            status = "disabled";

Why is your example disabled? Don't put 'status' in examples.

> +
> +            port {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                csi_in0: endpoint {
> +                    remote-endpoint = <&imx219_out0>;
> +                    bus-type = <4>;
> +                    data-lanes = <1 2>;
> +                    clock-lanes = <0>;
> +                    clock-noncontinuous;
> +                    link-frequencies = /bits/ 64 <456000000>;
> +                };
> +            };
> +        };
> +    };
> +
> -- 
> 2.17.1
> 
> 
> 
