Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455254D7403
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 10:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiCMJl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiCMJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:41:25 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3697941F8C;
        Sun, 13 Mar 2022 01:40:16 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id qa43so27813522ejc.12;
        Sun, 13 Mar 2022 01:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uw3lq7vLPxX+iH0m7HFnAo21FTEbg+aY/u5LJQ61UbU=;
        b=ez+wfinzEQq6ZQgi6TBC3785UJsMprsaguvwk8xCslZSjIb9zWry9XXjsYtwDdc63p
         iZt3J0dUs5bQ8fAvGCZyTdI/kP9eQUq77KHSe0SgYe3Rr78L9nI5TttAPpKhsUZhv+2I
         Ydcx8yzQ8Cfm9IhAXyIEASnjh/IRmdtKM/eizCvqgJCKBgmQWEDLx67LIX6hVPdqnqA3
         bV71owmZxIiAYekH5iXle+l3aNVcCAFzbBkFCe4xBNIQxk1qfzvvwWTME8Ikkssmwx37
         unYLS8S2LXxUh5Rj5P5jUA2YUHXqk53Peps79Ls2auiocf9f7OfGJ7B98kXvL0FZLxvz
         v3Sg==
X-Gm-Message-State: AOAM530soGe7AM/V5SQu2Vdpka0PGzNtYAkSUuqIJsPPLbacPdAmHbjC
        laemfEKfkm/7CV1a3G6/Sq9H5TkcBMc=
X-Google-Smtp-Source: ABdhPJxI7CMJ09gJVJiCp7o20L0dz9C5EVkVKl7mxe1+8+1aTf2O7zi++aQJw2BujxPCNSCzCrRphg==
X-Received: by 2002:a17:907:1c95:b0:6db:6b05:549c with SMTP id nb21-20020a1709071c9500b006db6b05549cmr14466612ejc.651.1647164414570;
        Sun, 13 Mar 2022 01:40:14 -0800 (PST)
Received: from [192.168.0.150] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id f26-20020a50ee9a000000b004160c295356sm5928639edr.5.2022.03.13.01.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 01:40:14 -0800 (PST)
Message-ID: <45c40613-fe0a-1a5e-408c-493f4d012aa6@kernel.org>
Date:   Sun, 13 Mar 2022 10:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 1/2] dt-bindings: misc: Add iop yaml file for Sunplus
 SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com
References: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
 <c0ef91adc0af9fedca2791e4006009fabfdfef2c.1647095774.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <c0ef91adc0af9fedca2791e4006009fabfdfef2c.1647095774.git.tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 17:16, Tony Huang wrote:
> Add iop yaml file for Sunplus SP7021
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v11:
>  - Addressed comments from krzysztof.
> 
>  .../devicetree/bindings/misc/sunplus,iop.yaml      | 78 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/sunplus,iop.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/sunplus,iop.yaml b/Documentation/devicetree/bindings/misc/sunplus,iop.yaml
> new file mode 100644
> index 0000000..ad1c4be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/sunplus,iop.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/sunplus-iop.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus IOP(8051) controller
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +
> +description: |
> +  Processor for I/O control, RTC wake-up procedure management,
> +  and cooperation with CPU&PMC in power management.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-iop
> +
> +  reg:
> +    items:
> +      - description: IOP registers regions
> +      - description: PMC registers regions
> +      - description: MOON0 registers regions
> +
> +  reg-names:
> +    items:
> +      - const: iop
> +      - const: iop_pmc
> +      - const: moon0
> +
> +  interrupts:
> +    items:
> +      - description: IOP_INT0. IOP to system Interrupt 0.
> +                     Sent by IOP to system RISC.
> +      - description: IOP_INT1. IOP to System Interrupt 1.
> +                     Sent by IOP to system RISC.
> +
> +  memory-region:
> +    maxItems: 1
> +
> +  wakeup-gpios:
> +    description: When the linux kernel system is powered off.
> +      8051 is always powered. 8051 cand receive external signals
> +      according to this gpio pin. 8051 receives external signal
> +      through gpio pin. 8051 can power on linux kernel system.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks

Why do you have clocks here but not in properties?

Best regards,
Krzysztof
