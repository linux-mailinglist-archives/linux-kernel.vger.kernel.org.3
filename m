Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4D4529595
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350490AbiEPXxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 19:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbiEPXwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:52:54 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E63ED2F;
        Mon, 16 May 2022 16:52:52 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-f165bc447fso12410958fac.6;
        Mon, 16 May 2022 16:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLYjtsgGlA07Qc3dBcMPR9s7GFGmrm0AkOOuD7W1saQ=;
        b=LFl1cBxPWoUCkE1W+k1PIjY2Filc4of03ndVm3CoXLomb3jygZBVxTI8zmTIOPLSlE
         KOeX9fx8akcj3qgXSiHA4qJUGDpZGGGYuUbNUelDMPkhu/aPuJ8gLCDmxe6eTEvuoHrN
         ElnzXh9IjFNVXxOZnrnVZNOPMOUlD7VQe7rOvMLuQLWjVy79fK/sxVoCPQ/uEZg3qE77
         NWNszNq2LWXBNtgPyL/ul3x60y2btL3VAs7gZW9q6yyz+5r/FL7Sit0eL+gJTQaMsHzT
         cpyaC8Jhymt+1oaZzyEOPT/kIh03RFN+aEvqgWbcfn0mon79z8X33KEliTLiU3WB5RNd
         JUzg==
X-Gm-Message-State: AOAM530W2tUMkfLP+6BlCuPqmvi1SqUOsrWW8yo3skINma/p9fmO9jNa
        JM2js2qI7jiVCqT7EdZrVQ==
X-Google-Smtp-Source: ABdhPJzGVAd5OY/GykxaSm1uI0nwH0J0ngGxXZJsQ5IeSSSe+fV9RLKWsy4BBR/D9rZxTj9YblLnHg==
X-Received: by 2002:a05:6870:b254:b0:ec:6ca4:c89f with SMTP id b20-20020a056870b25400b000ec6ca4c89fmr17070305oam.272.1652745171572;
        Mon, 16 May 2022 16:52:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q9-20020aca5c09000000b00325cda1ffb6sm4263596oib.53.2022.05.16.16.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 16:52:50 -0700 (PDT)
Received: (nullmailer pid 3570060 invoked by uid 1000);
        Mon, 16 May 2022 23:52:49 -0000
Date:   Mon, 16 May 2022 18:52:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: rtc: stm32: add st,lsco optional
 property to select output
Message-ID: <20220516235249.GA3567294-robh@kernel.org>
References: <20220504130233.330983-1-valentin.caron@foss.st.com>
 <20220504130233.330983-2-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504130233.330983-2-valentin.caron@foss.st.com>
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

On Wed, May 04, 2022 at 03:02:28PM +0200, Valentin Caron wrote:
> From: Amelie Delaunay <amelie.delaunay@foss.st.com>
> 
> STM32 RTC has three output pins: RTC_OUT1, RTC_OUT2 or RTC_OUT2_RMP.
> 
> RTC Low-Speed Clock Output (LSCO) can be output on RTC_OUT1 or
> RTC_OUT2_RMP.
> 
> This patch adds constants for RTC output bindings and adds st,lsco
> optional property for stm32 rtc driver, to select and enable LSCO.
> A pinctrl state is also optional to reserve pin for RTC output.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>  .../devicetree/bindings/rtc/st,stm32-rtc.yaml | 20 +++++++++++++++++++
>  include/dt-bindings/rtc/rtc-stm32.h           | 14 +++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 include/dt-bindings/rtc/rtc-stm32.h
> 
> diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
> index 764717ce1873..56d46ea35c5d 100644
> --- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
> @@ -52,6 +52,13 @@ properties:
>        override default rtc_ck parent clock phandle of the new parent clock of rtc_ck
>      maxItems: 1
>  
> +  st,lsco:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: |
> +      To select and enable RTC Low Speed Clock Output.
> +      Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.
> +      Pinctrl state named "default" may be defined to reserve pin for RTC output.
> +
>  allOf:
>    - if:
>        properties:
> @@ -65,6 +72,9 @@ allOf:
>            minItems: 1
>            maxItems: 1
>  
> +        st,lsco:
> +          maxItems: 0

If disallowing the property is what you wanted, then 'st,lsco: false' is 
the way. 'maxItems: 0' is never correct.

> +
>          clock-names: false
>  
>        required:
> @@ -82,6 +92,9 @@ allOf:
>            minItems: 2
>            maxItems: 2
>  
> +        st,lsco:
> +          maxItems: 0
> +
>        required:
>          - clock-names
>          - st,syscfg
> @@ -101,6 +114,9 @@ allOf:
>          assigned-clocks: false
>          assigned-clock-parents: false
>  
> +        st,lsco:
> +          maxItems: 1
> +
>        required:
>          - clock-names
>  
> @@ -130,12 +146,16 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/rtc/rtc-stm32.h>
>      rtc@5c004000 {
>        compatible = "st,stm32mp1-rtc";
>        reg = <0x5c004000 0x400>;
>        clocks = <&rcc RTCAPB>, <&rcc RTC>;
>        clock-names = "pclk", "rtc_ck";
>        interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +      st,lsco = <RTC_OUT2_RMP>;
> +      pinctrl-0 = <&rtc_out2_rmp_pins_a>;
> +      pinctrl-names = "default";
>      };
>  
>  ...
> diff --git a/include/dt-bindings/rtc/rtc-stm32.h b/include/dt-bindings/rtc/rtc-stm32.h
> new file mode 100644
> index 000000000000..2fd78c2e62d4
> --- /dev/null
> +++ b/include/dt-bindings/rtc/rtc-stm32.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for STM32_RTC bindings.
> + */
> +
> +#ifndef _DT_BINDINGS_RTC_RTC_STM32_H
> +#define _DT_BINDINGS_RTC_RTC_STM32_H
> +
> +#define RTC_NO_OUT	0
> +#define RTC_OUT1	1
> +#define RTC_OUT2	2
> +#define RTC_OUT2_RMP	3
> +
> +#endif
> -- 
> 2.25.1
> 
> 
