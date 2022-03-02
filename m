Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765DE4CAC6B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbiCBRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbiCBRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:47:59 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C86D4C8D;
        Wed,  2 Mar 2022 09:47:16 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so2791141ooi.0;
        Wed, 02 Mar 2022 09:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e4Ynsr1KRV81mh/v7NFfZK09/uSAr9hKDyQJT4xohZg=;
        b=F9JgVhJBvYb49StGk//PtPYAEJK5jf2Ohl62xcKR4nsyszVnXRL4AgYAlo45815HMd
         jZdaUJAsR66IhBcVioSTvVAvAxVY4XTAYOURPCXBDULkQmkZhNbz17dXWMpXXDv37T2O
         bopM88yJ64BCMxGrWzDveeV4LIEmm1JsfcbO556zWdvPDUjyKrq2hopQ7tfSLJQ3lTwz
         /vQlH59B1724/Sip3Dwzidb98fvkS6exsLG+EBzCmNVXY3CfFoywhU5aIsBkOnCwRQzO
         ECltmghxaNv5bH0bPzi5h4lTfDbOf7PT4+wYbkWgKynULJuWaqJsCyCHMriT+KMAOhjU
         0Cqg==
X-Gm-Message-State: AOAM530aOFHjeudPWokfPbNP2vkcWtguDFZcWVF4hqEi1DJW/82hxx3Y
        S1RQWMHuqLEJUNT1ZavFrw==
X-Google-Smtp-Source: ABdhPJzg5JoFk1NbMDL+DRO0m47cfdlGNhs1NOFAqhUNaPHs7ws2+aCvpQ+SNBK/slfH92ZxDB2vzQ==
X-Received: by 2002:a4a:e216:0:b0:320:5471:3284 with SMTP id b22-20020a4ae216000000b0032054713284mr2599557oot.70.1646243235602;
        Wed, 02 Mar 2022 09:47:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bd14-20020a056808220e00b002d53f900b9csm10199789oib.30.2022.03.02.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:47:14 -0800 (PST)
Received: (nullmailer pid 3948765 invoked by uid 1000);
        Wed, 02 Mar 2022 17:47:13 -0000
Date:   Wed, 2 Mar 2022 11:47:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dt_bindings: snps-dw-apb-uart: Add RS485
Message-ID: <Yh+tofzEMXSWr60c@robh.at.kernel.org>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302095606.14818-5-ilpo.jarvinen@linux.intel.com>
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

On Wed, Mar 02, 2022 at 11:56:03AM +0200, Ilpo Järvinen wrote:
> Add RS485 enable & line polarity properties.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  .../bindings/serial/snps-dw-apb-uart.yaml       | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 12137fe80acf..8d440afabb1f 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -103,6 +103,23 @@ properties:
>        register. Define this if your serial port does not use this pin.
>      type: boolean
>  
> +  snps,rs485-interface-en:
> +    description: Use true RS-485 DE and RE signals (in contrast to RS-485
> +      emulation using RTS). Requires IP version 4 or above.
> +    type: boolean
> +

> +  snps,de-active-high:
> +    description: Defines the polarity of driver enable (DE_EN) signal.
> +      Meaningful only with snps,rs485-interface-en. True indicates active
> +      high.
> +    type: boolean
> +
> +  snps,re-active-high:
> +    description: Defines the polarity of receiver enable (RE_EN) signal.
> +      Meaningful only with snps,rs485-interface-en. True indicates active
> +      high.
> +    type: boolean

Seems plausible that other rs485 implementations could have varying 
polarities too. IOW, should be common properties.

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.30.2
> 
