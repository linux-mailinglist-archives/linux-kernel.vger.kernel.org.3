Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051184CE023
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiCDWPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCDWPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:15:44 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D15E61F3;
        Fri,  4 Mar 2022 14:14:56 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id ay7so9248368oib.8;
        Fri, 04 Mar 2022 14:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IF4uwZ2Wt/aHg+83dvg/o/2ECkCwnq/lAioga7Vlr3w=;
        b=jmGy4loJFjJqCySbOrbXHLgeRkc1wy84w0tWi/ucvgIASmpgLsLLAE7FMXHoJwKhW5
         fi7YKhOTXH1fBAeCzN6SMVLwEmCVoKSUMC5WBosD3MDef49CfWnd7U8E1NXGZHMppE/Z
         2zu/YNOw+JV3bg4rorCWuMv04AVqocNSpoL1m5Yu6mlhXwa403utyGRiXy4Nrzqnm9Jc
         yrxp3qRB2Lk998IhK7FFruY/4YhhQClFXFO6OXWnF3lUiPDEkYuKdbpOPlLzYKO35OkO
         9z1UVWqCXjhCFE+d9LR+76az4+0XkQDbfNwFcigtnaSMtAF6Rn4usqm1Bj9vMMWK+1a+
         6Y/w==
X-Gm-Message-State: AOAM533PRIIxvYpOGr4YqlnV7E9W4FN/TGXs32Rxg87KjQV7pkZXC37s
        /1PWr0M8iOLLpRCsGKIGzQ==
X-Google-Smtp-Source: ABdhPJwSeDbwhQKWruWDXmLve/lD7Xfuz2Qycvq28+Vh7DfyWCbdXrBzsKFGnQtDK72Tbr4dmFQDGA==
X-Received: by 2002:a05:6808:14ca:b0:2d9:a01a:48b5 with SMTP id f10-20020a05680814ca00b002d9a01a48b5mr813325oiw.256.1646432095905;
        Fri, 04 Mar 2022 14:14:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bq3-20020a05680823c300b002d4f8fe4881sm3240213oib.39.2022.03.04.14.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:14:55 -0800 (PST)
Received: (nullmailer pid 527296 invoked by uid 1000);
        Fri, 04 Mar 2022 22:14:54 -0000
Date:   Fri, 4 Mar 2022 16:14:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        krzysztof.kozlowski@canonical.com, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Message-ID: <YiKPXmf4L6aLGM5a@robh.at.kernel.org>
References: <20220304161159.147784-1-sergiu.moga@microchip.com>
 <20220304161159.147784-4-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304161159.147784-4-sergiu.moga@microchip.com>
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

On Fri, Mar 04, 2022 at 06:11:58PM +0200, Sergiu Moga wrote:
> Convert RTC binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 -------
>  .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
