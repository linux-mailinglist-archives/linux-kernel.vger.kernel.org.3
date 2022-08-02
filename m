Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC78C587EEF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiHBPZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiHBPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:25:47 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022FD6371;
        Tue,  2 Aug 2022 08:25:45 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id l24so10857060ion.13;
        Tue, 02 Aug 2022 08:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ZbgYz5Xwf6vwbfHu21Ds/i5GJdOzX5BaausoB5dIHO8=;
        b=owhVT1rnzeNA0B3s+WmKQbOLADQVv/6q2SsChTwbgYBdSUeTop9QhFmIlMmXxotKnq
         slmZfPIfm4xOIDn/3NRUhAqSAq9O/J/Bk/5EzkVg4AzhvncPcDPMlSBTUAtUd2Xxd4xF
         sa4dYCIl7hnxTz/tP6bQuTXynDCvV/eWAYuJixlSucZaqK19ia0MMajr78lAaoXn5bN4
         ceAvjecX7maqgn/UVtjvst4xajGtyrYIhjKLsRsmalG3tYk3LK+6OWIRQTl6XUVTjDOF
         L/Ej9rp0xab38jNh2X/3BnBdLxiLJ4NQhlrHFOBSJptXbX5RPZsNZ8mziRsVc6+fyYnW
         0jRw==
X-Gm-Message-State: AJIora+RXtYUjvgyNDqkvnik1xlGnUnDYUzP+L0qAX3NRqgWh5Unbk9Q
        uILH6LCCU46bLBSYl6W6Iw==
X-Google-Smtp-Source: AGRyM1tott+jWdvGogVwj9+mzc9AcUyEu+QMyogO3NhyS73SxjIdbKEwVi6KMes1kXwuU+Fbj4WY/A==
X-Received: by 2002:a05:6602:3405:b0:67c:2d26:f8b7 with SMTP id n5-20020a056602340500b0067c2d26f8b7mr7402164ioz.178.1659453944199;
        Tue, 02 Aug 2022 08:25:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b34-20020a0295a5000000b00341a215d3cesm168271jai.63.2022.08.02.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:25:43 -0700 (PDT)
Received: (nullmailer pid 145716 invoked by uid 1000);
        Tue, 02 Aug 2022 15:25:42 -0000
Date:   Tue, 2 Aug 2022 09:25:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: remoteproc: Add AVM WASP
Message-ID: <20220802152542.GA132728-robh@kernel.org>
References: <20220723074247.32523-1-kestrelseventyfour@gmail.com>
 <20220723074247.32523-3-kestrelseventyfour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723074247.32523-3-kestrelseventyfour@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 09:42:46AM +0200, Daniel Kestrel wrote:
> AVM Fritzbox router boards may contain an additional ATH79
> based SoC that has the wifi cards connected.
> This patch adds bindings for this remote processor.
> 
> Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> ---
>  .../bindings/remoteproc/avm,wasp-rproc.yaml   | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> new file mode 100644
> index 000000000000..e8618706a34f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/avm,wasp-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AVM WASP processor controller bindings
> +
> +maintainers:
> +  - Daniel Kestrel <kestrelseventyfour@gmail.com>
> +
> +description: |
> +  This document defines the bindings for the remoteproc component that loads and
> +  boots firmwares on the AVM Wireless Assistant Support Processor (WASP) SoC
> +  that is attached to some AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490).
> +
> +properties:
> +  compatible:
> +    enum:
> +      - avm,fritzbox3390-wasp
> +      - avm,fritzbox3490-wasp
> +      - avm,fritzbox5490-wasp
> +      - avm,fritzbox5491-wasp
> +      - avm,fritzbox7490-wasp
> +
> +  avm,wasp-mdio:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Lantiq GSWIP switch mdio.

"git grep 'mdio.*=.*<'" gives existing 'mdio-parent-bus', 'mdio-device', 
and 'mdio-handle'. 'mdio-parent-bus' is the only one documented, but is 
for muxes. I'd go with 'mdio-device' here.

> +
> +  avm,wasp-port:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Network port, where the WASP SoC is connected to.

Maybe something already exists here too.

> +
> +  avm,reset-gpios:
> +    description: Reset gpio of the WASP SoC.
> +    maxItems: 1

Just 'reset-gpios' is fine here as that is somewhat standard.

> +
> +  avm,startup-gpios:
> +    description: Startup gpio of the WASP SoC.

s/gpio/GPIO/

Perhaps some detail on what it does besides just 'startup'.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - avm,wasp-mdio
> +  - avm,wasp-port
> +  - avm,reset-gpios
> +  - avm,startup-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    remoteproc {
> +        compatible = "avm,fritzbox7490-wasp";
> +        avm,wasp-mdio = <&gswip_mdio>;
> +        avm,wasp-port = <&port5>;
> +        avm,reset-gpios = <&gpio 34 GPIO_ACTIVE_HIGH>;
> +        avm,startup-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +    };
> -- 
> 2.17.1
> 
> 
