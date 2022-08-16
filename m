Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126F65960F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiHPRU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiHPRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:20:53 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852558DE3;
        Tue, 16 Aug 2022 10:20:52 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id p9so5674692ilq.13;
        Tue, 16 Aug 2022 10:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Q4O14z9xwYqtANeX5XgH5CYQKkWWRtuCHaM8jAT6Q3g=;
        b=Q7qBMnqtSt+xJFqxMToRIPLFWPVd+fk7wB1ufVxmkSUywFNBpozz/aWjtkhxWU4fXP
         JwA2bO307jIGYDO532rCrrgvQ66Eg+DkjpcV2D29x1ew59lHiglwOErqDGVaTJ3jYizp
         AJ5hGbIg5Hc8/GC/RWgX5koMv6QQLD1s/3q0ACTTbFzUn8iANqjpfHCCKkeUZvfF9DM4
         uaBsDzxgFDG9zcf9gjSjhAL2UcSbTSYguMures2Zb0eP85yH6/cr+NMVXxUQPU6ODViN
         W8FStf/APFfgSM59rA8+OVgHgnv8nFnzYJwof2ZIYyN4Woh9zIbrnVpm9KKxX2HajuxT
         vEog==
X-Gm-Message-State: ACgBeo23vDd5CG/BpZQLc8LRWReRE0AMD1uPlmL3FOsowReBX51BevRa
        Kn7tfMbMSg7pDDbXttb2Jg==
X-Google-Smtp-Source: AA6agR5ZkcmLOLet1JuEVooD2xVihqqO7zvL7WDWAtwn65oOI8FX2j14zzLHmu4qlu5VGUHiaLdrjg==
X-Received: by 2002:a05:6e02:194d:b0:2df:8893:90bb with SMTP id x13-20020a056e02194d00b002df889390bbmr9950968ilu.242.1660670451967;
        Tue, 16 Aug 2022 10:20:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r6-20020a02c6c6000000b0034142dad202sm4009039jan.31.2022.08.16.10.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:20:51 -0700 (PDT)
Received: (nullmailer pid 2404777 invoked by uid 1000);
        Tue, 16 Aug 2022 17:20:49 -0000
Date:   Tue, 16 Aug 2022 11:20:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     nm@ti.com, j-keerthy@ti.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] Documentation: tps6594x: Add DT bindings for the
 TPS6594x PMIC
Message-ID: <20220816172049.GA2399563-robh@kernel.org>
References: <20220812032242.564026-1-mranostay@ti.com>
 <20220812032242.564026-2-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812032242.564026-2-mranostay@ti.com>
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

On Thu, Aug 11, 2022 at 08:22:37PM -0700, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@ti.com>

Commit message? Use a subject prefix appropriate for the subsystem.

> ---
>  .../devicetree/bindings/mfd/ti,tps6594x.yaml  | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
> new file mode 100644
> index 000000000000..9b5e17f63709
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,tps6594x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TPS6594x Power Management Integrated Circuit (PMIC)
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    contains:

No, this means '"foo", "ti,tps6594x", "bar"' is valid.

> +      enum:

Use 'const' if only 1 entry.

> +        - ti,tps6594x

Don't use wildcards in compatible strings.

> +
> +  reg:
> +    const: 0x48
> +    description: I2C slave address
> +
> +  ti,system-power-controller:
> +    type: boolean
> +    description: PMIC is controlling the system power.
> +
> +  rtc:

Why do you need a sub-node here? Is the RTC a separate block with its 
own resources?

> +    type: object
> +    $ref: /schemas/rtc/rtc.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      compatible:
> +        const: ti,tps6594x-rtc
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c0 {

i2c {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic: pmic@48 {
> +            compatible = "ti,tps6594x";
> +            reg = <0x48>;
> +
> +            rtc {
> +                compatible = "ti,tps6594x-rtc";
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.36.1
> 
> 
