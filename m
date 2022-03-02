Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A04CAD67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiCBSW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiCBSWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:22:23 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46A35244;
        Wed,  2 Mar 2022 10:21:40 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id j9-20020a9d7d89000000b005ad5525ba09so2382938otn.10;
        Wed, 02 Mar 2022 10:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kEmc4vSJMmgmR2K1Zq+xyigIUozonuP2ZIoWp9eF2IM=;
        b=abgaX0GtsoyfnoTkw8iK5fdNXAUuVyztU/aBrSO8R1p/gDeH3lkPMaDUYwH93ldayS
         JmXv/SdoE5ou+ySsePXpCmgUanAsOYoWnCV6n9tdJkfLdYI9jJH1OD/ARI+Tl+uXtzdF
         Vb6yIFJbdxeLXyFnj2peP5nBy8K0EmXaFDIxSp8iMca66oGgfj90ivHPN2hv7B/sX1eW
         pGOeRVJcmljOj0W5G8eiAU+vcDOtxy8AF3vmnVLcwyfTCHjfCfBQfe9DLMtH8k4zQgbv
         OnnHtvoqaYReToU7bK7dOLPmE/JlcbzL8xrySO1eVMsXgK/O54GdU5/kj1AemrXTVxS7
         /V3g==
X-Gm-Message-State: AOAM533limPfKbB1FFAberBwg29LoJxYkmHjJl4KL/TMiQLXF7B2Mf/u
        4JlyFBcL1B6EmxM8wE7Fnw==
X-Google-Smtp-Source: ABdhPJx5vlUqvuCRqY+jOdWjalJ3e3Gt0iZVCh1kT9hUjpkpHnoZG9lKYEoJTzSMm49d/wgRawPdIg==
X-Received: by 2002:a05:6830:43a0:b0:5af:e328:6bc7 with SMTP id s32-20020a05683043a000b005afe3286bc7mr13446805otv.62.1646245299583;
        Wed, 02 Mar 2022 10:21:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m7-20020a9d6447000000b005acf7e4c507sm8054981otl.20.2022.03.02.10.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:21:38 -0800 (PST)
Received: (nullmailer pid 3999619 invoked by uid 1000);
        Wed, 02 Mar 2022 18:21:37 -0000
Date:   Wed, 2 Mar 2022 12:21:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?utf-8?B?77+9aXByYWdh?= <alsi@bang-olufsen.dk>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: usb: add TS5USBA224 USB/Audio switch mux
Message-ID: <Yh+1sQ8rVh9HZZzm@robh.at.kernel.org>
References: <20220301132010.115258-1-alvin@pqrs.dk>
 <20220301132010.115258-3-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301132010.115258-3-alvin@pqrs.dk>
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

On Tue, Mar 01, 2022 at 02:20:06PM +0100, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The TS5USBA224 is a USB High Speed/Audio switch mux IC controlled via
> GPIO. It is typically composed with a Type-C port controller with Audio
> Accessory mode detection.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  .../bindings/usb/ti,ts5usba224.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,ts5usba224.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,ts5usba224.yaml b/Documentation/devicetree/bindings/usb/ti,ts5usba224.yaml
> new file mode 100644
> index 000000000000..0a488b961906
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,ts5usba224.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,ts5usba224.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TS5USBA224 USB 2.0 High Speed and Audio mux DT bindings
> +
> +description:
> +  The Texas Instruments TS5USBA224 is a double-pole, double throw
> +  (DPDT) multiplexer that includes a low-distortion audio switch and a
> +  USB 2.0 High Speed switch in the same package.
> +
> +maintainers:
> +  - Alvin Šipraga <alsi@bang-olufsen.dk>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ts5usba224
> +
> +  asel-gpio:
> +    description: Output GPIO for A_SEL signal
> +    maxItems: 1
> +
> +  accessory:
> +    type: boolean
> +    description:
> +      Indicates that this is an Accessory Mode mux.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      OF graph bindings modelling a Type-C port controller.

What does that mean?

There's a couple of Type-C bindings on the list ATM. Without block 
diagrams of all the relevant components and the corresponding graph, I 
can't say whether any of this graph usage makes sense.

> +
> +required:
> +  - compatible
> +  - asel-gpio
> +  - accessory
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usbaudiomux@0 {
> +      compatible = "ti,ts5usba224";
> +      asel-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +      accessory;
> +
> +      port {
> +        usb_audio_mux1: endpoint {
> +          remote-endpoint = <&typec1_mux>;
> +        };
> +      };
> +    };
> -- 
> 2.35.1
> 
