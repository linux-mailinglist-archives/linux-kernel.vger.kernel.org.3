Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A726554E616
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377926AbiFPPa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377915AbiFPPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:30:21 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9292DAAE;
        Thu, 16 Jun 2022 08:30:20 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id q11so1823520iod.8;
        Thu, 16 Jun 2022 08:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2sf5mUaKrviwp13TGF8u3f+HZJ1MhfMWStrlSi0a7lE=;
        b=siJ8kY+phpx603+zObdKU5P9G9boFmUfXNnoEMbtp8KZMvxh4m12KF9TLfdIV7edkS
         kHfiQhoQIY3zCdFUm2DJ9oAnL6UFnh4TMYnEwWLKnGn4xurVkRP/evVHKGy9h7qHz2P4
         Pb0smF4uzGIz9u8frTtFl5u8HkEvdSwnzwTK3x7NL59dhDNMG+ZtLZbgrRJyCtBy5l5U
         pT3xLE5gYM9K48pBbIwMB8O2BXUp/ZeeajqgQeR2YiGpmQN5H+JAFPnA7LM1YsXhcdsa
         wcuhAx7OYJ4vovcVSTPM4Y3eM+SKzIQfDwt2zHw42xlBdAxZwEsF+hnS7UWz93ezTs/c
         0fpw==
X-Gm-Message-State: AJIora+DjjX2FH3tdQptumFVOK39fhcjnpSolse+E6iiX1aJ2ugQR0j0
        8/N0V+QoQR6iprR4RzIzNQ==
X-Google-Smtp-Source: AGRyM1vvg+GE8jDNHocB+G2TLYD4tIOMcVSsqFkB8s77NHYxFHcjaOt00sxR+0MRCDR0eoPwFZR11A==
X-Received: by 2002:a05:6602:13c7:b0:669:dcc5:4687 with SMTP id o7-20020a05660213c700b00669dcc54687mr2782285iov.63.1655393419921;
        Thu, 16 Jun 2022 08:30:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b8-20020a92a048000000b002cde6e35302sm1102011ilm.76.2022.06.16.08.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:30:19 -0700 (PDT)
Received: (nullmailer pid 3507680 invoked by uid 1000);
        Thu, 16 Jun 2022 15:30:17 -0000
Date:   Thu, 16 Jun 2022 09:30:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 1/2] dt-bindings: vcpu_stall_detector: Add
 qemu,vcpu-stall-detector compatible
Message-ID: <20220616153017.GA3503416-robh@kernel.org>
References: <20220616092737.1713667-1-sebastianene@google.com>
 <20220616092737.1713667-2-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616092737.1713667-2-sebastianene@google.com>
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

On Thu, Jun 16, 2022 at 09:27:38AM +0000, Sebastian Ene wrote:
> The VCPU stall detection mechanism allows to configure the expiration
> duration and the internal counter clock frequency measured in Hz.
> Add these properties in the schema.
> 
> While this is a memory mapped virtual device, it is expected to be loaded
> when the DT contains the compatible: "qemu,vcpu-stall-detector" node.
> In a protected VM we trust the generated DT nodes and we don't rely on
> the host to present the hardware peripherals.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  .../bindings/misc/vcpu_stall_detector.yaml    | 49 +++++++++++++++++++

qemu,vcpu-stall-detector.yaml

>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml b/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
> new file mode 100644
> index 000000000000..55323676194b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/vcpu_stall_detector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VCPU stall detector
> +
> +description: |

Don't need '|' if no formatting.

> +  This binding describes a CPU stall detector mechanism for virtual cpus

s/cpus/CPUs/

> +  which is accessed through MMIO.
> +
> +maintainers:
> +  - Sebastian Ene <sebastianene@google.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qemu,vcpu-stall-detector
> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The internal clock of the stall detector peripheral measure in Hz used
> +      to decrement its internal counter register on each tick.
> +      Defaults to 10 if unset.

       default: 10

> +
> +  timeout-sec:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The stall detector expiration timeout measured in seconds.
> +      Defaults to 8 if unset. Please note that it also takes into account the
> +      time spent while the VCPU is not running.

       default: 8

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    vmwdt@9030000 {
> +      compatible = "qemu,vcpu-stall-detector";
> +      clock-frequency = <10>;
> +      timeout-sec = <8>;
> +      reg = <0x0 0x9030000 0x0 0x10000>;
> +    };
> +
> +...
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
> 
