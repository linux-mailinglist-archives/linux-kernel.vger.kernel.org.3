Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E248C51A45D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352633AbiEDPqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352784AbiEDPqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:46:32 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409AD46643;
        Wed,  4 May 2022 08:42:45 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-e2fa360f6dso1569039fac.2;
        Wed, 04 May 2022 08:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tnMRJsbiS8QiP9lDD2I4JzMT/wd9etKoP6P9ura1i48=;
        b=oCz0VUEXIj3jIuPey1IVqcOAy6vhH24ER0yQnDh7laEqHv0QtcNP23RmSXBJvEMraV
         0c5UHR+PB+UYkhyXKKFDu8kvG4GraHgY1u7s4CJTP7/x+tHWkDueQ6eVg0G1GQoLBUTt
         6OCO9zmvTD7Yr6q+XNm5c2k3zJOxm+MQOocnE756wtrCXwphd17dE5wqRsiRWrizf9Os
         N4TshiCucCCRgotUoINwmoiT81mBiSb/HLFYz3xpvx1ILYqShV0+c38L5rBzjSDOck6I
         JHpL9SZlPy+sS/knztc/SPwMo7erCd3PTOzsJSqhl0mVsfI+yx9BHu4HRsM5j026OSgY
         Jqdw==
X-Gm-Message-State: AOAM5309sUlYqSCAlSEE0zLsHlYgV70CKvJBPg3NZuP9s0I78PZz4jOS
        IQgNQm7ccjpEc9ZwP2xN+Q==
X-Google-Smtp-Source: ABdhPJzNz108HgppQ2njmjK7spVH8oSX47FuDf8S/DyT2/BrJzu23fF4n28T9OGduSEoDRg/Cc5k1w==
X-Received: by 2002:a05:6870:e412:b0:ed:a30a:2248 with SMTP id n18-20020a056870e41200b000eda30a2248mr39162oag.138.1651678964563;
        Wed, 04 May 2022 08:42:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v4-20020a9d4e84000000b006060322124bsm5279580otk.27.2022.05.04.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:42:44 -0700 (PDT)
Received: (nullmailer pid 1762666 invoked by uid 1000);
        Wed, 04 May 2022 15:42:40 -0000
Date:   Wed, 4 May 2022 10:42:40 -0500
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
Subject: Re: [PATCH 2/6] dt-bindings: rtc: stm32: add alarm A out property to
 select output
Message-ID: <YnKe8K3FjoaUO2ml@robh.at.kernel.org>
References: <20220504130233.330983-1-valentin.caron@foss.st.com>
 <20220504130617.331290-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504130617.331290-1-valentin.caron@foss.st.com>
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

On Wed, May 04, 2022 at 03:06:13PM +0200, Valentin Caron wrote:
> STM32 RTC can pulse some SOC pins when an alarm of RTC expires.
> 
> This patch adds property to activate alarm A output. The pulse can
> output on three pins RTC_OUT1, RTC_OUT2, RTC_OUT2_RMP
> (PC13, PB2, PI8 on stm32mp15) (PC13, PB2, PI1 on stm32mp13).
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>  .../devicetree/bindings/rtc/st,stm32-rtc.yaml | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
> index 56d46ea35c5d..71e02604e8de 100644
> --- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
> @@ -59,6 +59,13 @@ properties:
>        Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.
>        Pinctrl state named "default" may be defined to reserve pin for RTC output.
>  
> +  st,alarm:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: |
> +      To select and enable RTC Alarm A output.
> +      Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.

No, sorry, you need to define the allowed values as a schema here.

> +      Pinctrl state named "default" may be defined to reserve pin for RTC output.
> +
>  allOf:
>    - if:
>        properties:
> @@ -75,6 +82,9 @@ allOf:
>          st,lsco:
>            maxItems: 0
>  
> +        st,alarm:
> +          maxItems: 0

st,alarm: false

or:

not:
  required: [ st,alarm ]

is how you disallow a property.

This should cause a warning, but this patch didn't apply for me.

> +
>          clock-names: false
>  
>        required:
> @@ -95,6 +105,9 @@ allOf:
>          st,lsco:
>            maxItems: 0
>  
> +        st,alarm:
> +          maxItems: 0
> +
>        required:
>          - clock-names
>          - st,syscfg
> @@ -117,6 +130,9 @@ allOf:
>          st,lsco:
>            maxItems: 1
>  
> +        st,alarm:
> +          maxItems: 1

maxItems applies to arrays, but this is a scalar value. I don't think 
you need this hunk.

> +
>        required:
>          - clock-names
>  
> @@ -153,8 +169,9 @@ examples:
>        clocks = <&rcc RTCAPB>, <&rcc RTC>;
>        clock-names = "pclk", "rtc_ck";
>        interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +      st,alarm = <RTC_OUT1>;
>        st,lsco = <RTC_OUT2_RMP>;
> -      pinctrl-0 = <&rtc_out2_rmp_pins_a>;
> +      pinctrl-0 = <&rtc_out1_pins_a &rtc_out2_rmp_pins_a>;
>        pinctrl-names = "default";
>      };
>  
> -- 
> 2.25.1
> 
> 
