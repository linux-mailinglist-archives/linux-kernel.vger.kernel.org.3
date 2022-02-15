Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92334B79E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbiBOVEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:04:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiBOVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:04:05 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630CC27FFA;
        Tue, 15 Feb 2022 13:03:55 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id c188so25504404iof.6;
        Tue, 15 Feb 2022 13:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ABrhc5X4t6fuOcuDaQZbLnAECbyh/WwN9lD2vRsVEaI=;
        b=CHBkZSUd6mNPaMK3KyF1uxQYGNvfWEtHttSW695EkBLjLL2fU69zWxc+BK5yuINq0S
         39KSgfoJ2jnAq9WQSF+2OaYie1wc7S/f/ftRatgvWKXq62y5FrUv4cupb6QUPwLyw8Ax
         U+ydQ5z2fuuXZdForHT1L3tnq8dEkw+1m693GuLZXDP6PvyOlEf7G153Hq4iE3z987Hs
         JYlj5e7gR9Nztn6nEp3+MyHjs6dQMOrSpEfoZe3qaVngrY8o/fI/3diEANKyj92a9XkD
         uyeabJ8eo9UTqOdXyW2a6VfQZVlcAER4GHXbl6y/hB5OM+HtoxGeMIe4R9F4Avlr6ply
         CFvw==
X-Gm-Message-State: AOAM532cC98+7Hc5GYvr7N/mN8THqiWU6LbbBXkfbi9vTO49KovP/SYi
        SvMn3NVdh0ZAHxs+flSV/w==
X-Google-Smtp-Source: ABdhPJz1L9wTn9oP95nr4RBAQPtGhnz/mtfBdBHouAwIXfSY6CGaW/doAWSL2qS52le6wpjOs557VQ==
X-Received: by 2002:a05:6638:2584:: with SMTP id s4mr449890jat.289.1644959034612;
        Tue, 15 Feb 2022 13:03:54 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d3sm13122624ilg.23.2022.02.15.13.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:03:53 -0800 (PST)
Received: (nullmailer pid 3917584 invoked by uid 1000);
        Tue, 15 Feb 2022 21:03:52 -0000
Date:   Tue, 15 Feb 2022 15:03:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/8] dt-bindings: firmware: arm,scmi: Add
 atomic-threshold-us optional property
Message-ID: <YgwVOMyjHrToGUR4@robh.at.kernel.org>
References: <20220213195832.27932-1-cristian.marussi@arm.com>
 <20220213195832.27932-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213195832.27932-5-cristian.marussi@arm.com>
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

On Sun, Feb 13, 2022 at 07:58:28PM +0000, Cristian Marussi wrote:
> SCMI protocols in the platform can optionally signal to the OSPM agent
> the expected execution latency for a specific resource/operation pair.
> 
> Introduce an SCMI system wide optional property to describe a global time
> threshold which can be configured on a per-platform base to determine the
> opportunity, or not, for an SCMI command advertised to have a higher
> latency than the threshold, to be considered for atomic operations:
> high-latency SCMI synchronous commands should be preferably issued in the
> usual non-atomic mode.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> v4
> - renamed property to atomic-threshold-us
> v1 --> v2
> - rephrased the property description
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index eae15df36eef..3ffa669b91af 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -81,6 +81,15 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  atomic-threshold-us:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      An optional time value, expressed in microseconds, representing, on this
> +      platform, the threshold above which any SCMI command, advertised to have
> +      an higher-than-threshold execution latency, should not be considered for
> +      atomic mode of operation, even if requested.

> +      If left unconfigured defaults to zero.

This can be expressed as 'default: 0'.

> +
>    arm,smc-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> @@ -264,6 +273,8 @@ examples:
>              #address-cells = <1>;
>              #size-cells = <0>;
>  
> +            atomic_threshold = <10000>;
> +
>              scmi_devpd: protocol@11 {
>                  reg = <0x11>;
>                  #power-domain-cells = <1>;
> -- 
> 2.17.1
> 
> 
