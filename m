Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D039D4C4B17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiBYQnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiBYQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:43:17 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D1F16F944;
        Fri, 25 Feb 2022 08:42:44 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so6826276oop.13;
        Fri, 25 Feb 2022 08:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZSX/mmN9jmdskm3j4TwmWh8AlFLR/YvOjRrOST7+5es=;
        b=NrAtjAfwNjD1bNdaxweE9S9dh9S+qanqxxOm33njdiQKIO79SNQjIhAbiWbZG+S057
         DFUjBgkSsvD3TRT46rfzXmJOREkPIYPfqC5JWLFCnSWWL6OBDs03fJEps1PX/MN9ML83
         7BqFk+AQNtO08cZ1PlMUe3R4LlqIu/dDkGYAb6BnMxhi7K7KXWEn6uWzKHnCpzVNGevm
         rUYWTmI6DhyWy2NPZymwJCJZ9r1mkpAFwF0uRKkV95bwM5h4hioxAAesYojmvhwjVs5A
         E5mwIM0ZGWUdTAL1pBt77O7jrWXMTETcUi6DaCuIp6B/VVNSRtFC5Cix1kS3xelxkhvq
         3xhg==
X-Gm-Message-State: AOAM531AuNCyvbZqv0FrKiFnD1hltKV6U0Hn5M29j2NAlDCf33nRZgEX
        qYU3eM1prRbNgP1mLGhagmZhk1sBYw==
X-Google-Smtp-Source: ABdhPJwwhEUJZdpe4mMbjxVuFAy+Hz/bbfJEL+S3kPYGCL3TRqpYJkBhIs9KD2NMfnnHOVVa22Kv5Q==
X-Received: by 2002:a4a:3b04:0:b0:31b:7524:ce2d with SMTP id s4-20020a4a3b04000000b0031b7524ce2dmr3049766oos.54.1645807363590;
        Fri, 25 Feb 2022 08:42:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e12-20020a056870c0cc00b000d6bf3c0613sm1376697oad.43.2022.02.25.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:42:42 -0800 (PST)
Received: (nullmailer pid 1063115 invoked by uid 1000);
        Fri, 25 Feb 2022 16:42:41 -0000
Date:   Fri, 25 Feb 2022 10:42:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Tom Rini <trini@konsulko.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2] dt-bindings: nvmem: add U-Boot environment variables
 binding
Message-ID: <YhkHAQclxNHqmBwO@robh.at.kernel.org>
References: <20220217130235.7450-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220217130235.7450-1-zajec5@gmail.com>
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

On Thu, Feb 17, 2022 at 02:02:35PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot uses environment variables for storing device setup data. It
> usually needs to be accessed by a bootloader, kernel and often
> user-space.

How much of this is already in use vs. proposed? I know I've seen 
something, but that may have been a u-boot env string in 'label' and 
that's it.

> This binding allows describing environment data located in a raw flash
> partition. It's treated as NVMEM device and can be reused later for
> other storage devices.
> 
> Using DT should be cleaner than hardcoding & duplicating such info in
> multiple places. Bootloader & kernel can share DTS and user-space can
> try reading it too or just have correct data exposed by a kernel.
> 
> A custom "compatible" string allows system to automatically load
> relevant NVMEM driver but phandle can be also used for reading raw
> location.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Update descriptions to don't make this binding MTD (flash partition)
>     specific. Mention multiple possible storage ways.
> ---
>  .../devicetree/bindings/nvmem/u-boot,env.yaml | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> new file mode 100644
> index 000000000000..a53e34152c97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: U-Boot environment variables
> +
> +description: |
> +  U-Boot uses environment variables to store device parameters and
> +  configuration. They may be used for booting process, setup or keeping end user
> +  info.
> +
> +  Data is stored using U-Boot specific formats (variant specific header and NUL
> +  separated key-value pairs).
> +
> +  Environment data can be stored on various storage entities, e.g.:
> +  1. Raw flash partition
> +  2. UBI volume
> +
> +  This binding allows marking storage device (as containing env data) and
> +  specifying used format.
> +
> +  Right now only flash partition case is covered but it may be extended to e.g.
> +  UBI volumes in the future.
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: nvmem.yaml#

What exactly is used from nvmem.yaml? Based on the example, nothing.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: A standalone env data block
> +        const: u-boot,env

> +      - description: Two redundant blocks with active one flagged
> +        const: u-boot,env-redundant-bool
> +      - description: Two redundant blocks with active having higher counter
> +        const: u-boot,env-redundant-count

Aren't these 2 discoverable based on a flag or count property?

> +
> +  reg:
> +    maxItems: 1
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            reg = <0x0 0x40000>;
> +            label = "u-boot";
> +            read-only;
> +        };
> +
> +        env: partition@40000 {
> +            compatible = "u-boot,env";
> +            reg = <0x40000 0x10000>;
> +            label = "u-boot-env";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66aa3a589f6a..55c56ce82856 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19905,6 +19905,11 @@ W:	http://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/pci/tw686x/
>  
> +U-BOOT ENVIRONMENT VARIABLES
> +M:	Rafał Miłecki <rafal@milecki.pl>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> +
>  UACCE ACCELERATOR FRAMEWORK
>  M:	Zhangfei Gao <zhangfei.gao@linaro.org>
>  M:	Zhou Wang <wangzhou1@hisilicon.com>
> -- 
> 2.34.1
> 
> 
