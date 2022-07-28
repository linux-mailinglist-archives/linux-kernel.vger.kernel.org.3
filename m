Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1189F5842EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiG1PUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiG1PUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:20:02 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A55E320;
        Thu, 28 Jul 2022 08:20:01 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id l24so1586297ion.13;
        Thu, 28 Jul 2022 08:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KWOengPptGhZ9S8qL7ZzEUH7DLDwnQDNQKZ2ATVoS5Q=;
        b=kY6l1Vu3u50vfGVupV/oinHTmd/rb6FnaIOuW65jNPH2mudFjVam6oUAqJm4Ygq/9f
         sqgVCZi22zR8h99xxuwnktbwHfFeFocs6RmADY0J/LTh19hFKpOSPRm7omgpnGxasTVX
         q3yoTiV+l22YItQIlvcQyIP+an7Wb4xOTfEkYriODpp5Fq58essZGdsdUMzgAoyPbIL+
         aHg7MLjEyQQsAn1oS/NUWDTlg8B5Bl2BDINbjVvvhUnyYMIczJKi9SA1Ytt46t4c0wl7
         hp+pKaop36A0vaer3qcN5gLQJzucVkPiH/1r32JGSGnogJGBr1HnmHKDpDaLP8gN8xXq
         LGAw==
X-Gm-Message-State: AJIora9ZERZbA3fRWkE+puI7PzY88o4V8PNsVzyGvFYKFlrNTZtlQHQK
        r1BlpUNpt/DhKvkGQbz7Sg==
X-Google-Smtp-Source: AGRyM1uWbkYKJ0bww325LRxaT+umz8L1HWiApfqdJVuZlVaHnoKH1VSBl6ij4Cba80UtKJSsbqp+tA==
X-Received: by 2002:a05:6638:1b09:b0:33f:6d9e:89d0 with SMTP id cb9-20020a0566381b0900b0033f6d9e89d0mr11018979jab.113.1659021601036;
        Thu, 28 Jul 2022 08:20:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n22-20020a056638265600b00335c0e07abdsm491013jat.14.2022.07.28.08.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:20:00 -0700 (PDT)
Received: (nullmailer pid 903899 invoked by uid 1000);
        Thu, 28 Jul 2022 15:19:59 -0000
Date:   Thu, 28 Jul 2022 09:19:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: gpio: fairchild,74hc595: use
 spi-peripheral-props.yaml
Message-ID: <20220728151959.GA903846-robh@kernel.org>
References: <20220727164251.385683-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164251.385683-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:42:51 +0200, Krzysztof Kozlowski wrote:
> Instead of listing directly properties typical for SPI peripherals,
> reference the spi-peripheral-props.yaml schema.  This allows using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
> 
> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> schema, except for the cases when device schema adds some constraints
> like maximum frequency.
> 
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Technically, this depends on [1] merged to SPI tree, if we want to
> preserve existing behavior of not allowing SPI CPHA and CPOL in each of
> schemas in this patch.
> 
> If this patch comes independently via different tree, the SPI CPHA and
> CPOL will be allowed for brief period of time, before [1] is merged.
> This will not have negative impact, just DT schema checks will be
> loosened for that period.
> 
> [1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/
> ---
>  .../devicetree/bindings/gpio/fairchild,74hc595.yaml        | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
