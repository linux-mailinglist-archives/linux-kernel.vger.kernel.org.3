Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD94D64CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347785AbiCKPlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiCKPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:41:09 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C761C1EE2;
        Fri, 11 Mar 2022 07:40:06 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso10931931ooi.3;
        Fri, 11 Mar 2022 07:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkEp0QvSB94NbzjFVWM1JYsBpw2WIxFvuwExLgZ9OL0=;
        b=Foo2A62Z32SHWog2/Uj1JsAbnu8kGciv2zJd7gdAk6EEf+UzPVoasEP6dRLDLAoLd3
         4Zllx0JoXQ4By6T46IpxOgm8joXTmbsGDNWvzxeWpt9eo8E8EEG/r6QjuOwjOA8Rny8p
         lvLv8xjnBiiN0687KJ9x8KAsSMk6Kb0KFhmUDZNWlPhWya1Pv0EkEnm1ZBKUrTbB0m3J
         s8Pkwnq2PKR0VcsaV0kZ6AIBynB+cgNDjgJC8ZjJtTVr1qWu/vTIktxsNNLw+zZm/BH5
         f/OuEUgx3cvEQn+8A/1gOP0hAVpXAXavA6jWF448TEpabgbkje0k0jxf+VGLLUItyVhm
         2RwA==
X-Gm-Message-State: AOAM532zUBwVCX2Gk7LuB1ub2w8IgrTHMFWp5ji5dU78Hws1K1ypbZSP
        /+Ktcx8k1OcKm+Nwo/IxMMQWhr0R9g==
X-Google-Smtp-Source: ABdhPJyVsLV1oaj3oJdeNZwtNqGG3S4hvd6WkIwcwXyDJfXcEIcFMKhIyP7e2w8T9LDnpk0XESGvxw==
X-Received: by 2002:a05:6870:a986:b0:da:b3f:3279 with SMTP id ep6-20020a056870a98600b000da0b3f3279mr5640539oab.297.1647013205688;
        Fri, 11 Mar 2022 07:40:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w20-20020a056870339400b000d75f1d9b83sm3524647oae.48.2022.03.11.07.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:40:04 -0800 (PST)
Received: (nullmailer pid 3849774 invoked by uid 1000);
        Fri, 11 Mar 2022 15:40:03 -0000
Date:   Fri, 11 Mar 2022 09:40:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 05/10] dt-bindings: timer: Add HPE GXP Timer Binding
Message-ID: <YittU9MfIFye9e2p@robh.at.kernel.org>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-5-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310195229.109477-5-nick.hawkins@hpe.com>
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

On Thu, Mar 10, 2022 at 01:52:24PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Creating binding for gxp timer in device tree hpe,gxp-timer
> Although there are multiple times on the SoC we are only
> enabling one at this time.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ----
> 
> v2:
>  *Removed maintainer change from patch
>  *Verified there was no compilation errors
>  *Added reference code in separate patch of patchset
> ---
>  .../bindings/timer/hpe,gxp-timer.yaml         | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> new file mode 100644
> index 000000000000..1f4e345c5fb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/hpe,gxp-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP TIMER
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-timer
> +
> +  reg:
> +    items:
> +      - description: T0CNT register
> +      - description: T0CS register
> +      - description: TIMELO register

Is the spec public to know what T0CNT, T0CS, and TIMELO are?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: The frequency of the clock that drives the counter, in Hz.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    timer@10003000 {
> +        compatible = "hpe,gxp-timer";
> +        reg = <0xc0000080 0x1>, <0xc0000094 0x01>, <0xc0000088 0x08>;

Based on the driver these are 4 bytes, 1 byte, 4 bytes in size.

Are there other registers in 0x80-0x95 range or do these offsets change 
in other chips? If not, just 1 entry covering the whole thing would be 
better.

> +        interrupts = <0>;
> +        interrupt-parent = <&vic0>;
> +        clock-frequency = <400000000>;
> +    };
> -- 
> 2.17.1
> 
> 
