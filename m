Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626DC4D7401
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 10:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiCMJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 05:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiCMJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:35:00 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C43064E1;
        Sun, 13 Mar 2022 01:33:51 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id y22so15998006eds.2;
        Sun, 13 Mar 2022 01:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xbjpHbWCTEfu5WEpcZkMmWqJiCN3FpxdQjPcN2vcHeU=;
        b=Pa2txRWGc/z4ie9s1JWOiouXhBeE4jsrJHVt7b7qAUdkrKXweR+wuIrCwEO775Q31w
         B0GnfEbrfU/3OXFSURr0YAYmp/SfnBNjpSerc37OsWdLdVSJgho/p2BHPYDHJMuBu9Jx
         QSsmClVjtAzZ8JaNUljyT5Zgi5+OffEE5Y7ff189pDLDEpiG4ySsHO2MDTgX6uEjduif
         3ZKrfumm+Q6ret29Pby4DpMPdkeXEmOsOOuOXbYrwckr3RS+vzkQLfa5S47lS3iKk3kb
         xM3K2uYeWvD2zEBfz1tC3I69MsY7LYjjH8fNjYOMIGbBT7cJC42UwuehGp0w1uGYQCjx
         dnOg==
X-Gm-Message-State: AOAM532kZW2kgk4ZxhAVpn752Lyy7+AmOwYQHDRo2eidtSz2muZkYPi6
        i3T25thLk/v6XrsEPoWmCSU=
X-Google-Smtp-Source: ABdhPJxRaBA361McnhNx7Fw7QdiXtxA9xTKDIuMBSdufR7whFHMyXXBYlwC0bykEy6M6hPNGqfaZ7Q==
X-Received: by 2002:a05:6402:26cf:b0:416:a2bd:de1 with SMTP id x15-20020a05640226cf00b00416a2bd0de1mr16057697edd.306.1647164030026;
        Sun, 13 Mar 2022 01:33:50 -0800 (PST)
Received: from [192.168.0.150] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id n19-20020a1709067b5300b006ce36e2f6fdsm5321348ejo.159.2022.03.13.01.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 01:33:49 -0800 (PST)
Message-ID: <8eb40370-9b33-e97c-a576-18ba23266084@kernel.org>
Date:   Sun, 13 Mar 2022 10:33:48 +0100
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

Still wrong path. This would be easily spotted if you test the bindings.
Please run dt_binding_check. It's a requirement.

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
> +  - interrupts
> +  - memory-region
> +  - wakeup-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    iop: iop@9c000400 {
> +        compatible = "sunplus,sp7021-iop";
> +        reg = <0x9c000400 0x80>, <0x9c003100 0x80>, <0x9c000000 0x80>;
> +        reg-names = "iop", "iop_pmc", "moon0";
> +        clocks = <&clkc 0x14>;
> +        interrupt-parent = <&intc>;
> +        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
> +        memory-region = <&iop_reserve>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&iop_pins>;
> +        wakeup-gpios = <&pctl 1 GPIO_ACTIVE_HIGH>;
> +    };
> \ No newline at end of file

You have a patch warning here.

Best regards,
Krzysztof
