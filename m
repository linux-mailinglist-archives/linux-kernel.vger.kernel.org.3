Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5388D585746
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 01:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiG2XWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 19:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiG2XWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 19:22:52 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4364E50065;
        Fri, 29 Jul 2022 16:22:51 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id o2so4671349iof.8;
        Fri, 29 Jul 2022 16:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0AOLCG1NTy8Zh8NrZUMZYBr5WD2rLOm1rI0WWJyHoXE=;
        b=2JC6e3J/gI3Nn9Ft1Qn7l5/j9h/AjljbqFiLykYW0rnRS43oICQNe494OZv19iENYn
         uh8FLHN9fPlAvb6IKRRkCoNrg0X4R6OYDkepNg7BA9/qPTW1M8s6Txa4wWtJu8jGMIj/
         tshvcxEl01Hg6WqvZhKCo5IX7TWdofs3koilWxTxEg4PUmJTnYhNHB/Af+N+a3yrdQW8
         NiwAuaop5mPYLtyOjN8usjuethVNMwL1/QwzMG5NB4dDODuocySVglyETYK/4sDZiq+q
         6LXGZikPMN/1D7Y77biocPx+MxalLExV+AmHvsdoMwy1oO32vxZMh9WYUPZw0ysAHNKD
         oo/w==
X-Gm-Message-State: AJIora+A5Ym+fwdqp9BcGqd5bxThXHlppCU4kRmkea+ItH2arhFvmoXc
        Wo7LXtaIvhT/qedlr6UnKUJJ8sTFzg==
X-Google-Smtp-Source: AGRyM1tB97C6ctbit302MqTEFIpjr4tyMng5IykEoSCRqP5gd+519HFVQRNIMVQhX575tVHqrqLmig==
X-Received: by 2002:a05:6638:dcb:b0:33f:8242:4131 with SMTP id m11-20020a0566380dcb00b0033f82424131mr2137232jaj.80.1659136970510;
        Fri, 29 Jul 2022 16:22:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w15-20020a02b0cf000000b00339f1d1c090sm2213808jah.113.2022.07.29.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:22:49 -0700 (PDT)
Received: (nullmailer pid 130433 invoked by uid 1000);
        Fri, 29 Jul 2022 23:22:47 -0000
Date:   Fri, 29 Jul 2022 17:22:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Heiko Schocher <hs@denx.de>,
        David Lechner <david@lechnology.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] dt-bindings: display: use spi-peripheral-props.yaml
Message-ID: <20220729232247.GA130318-robh@kernel.org>
References: <20220727164312.385836-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164312.385836-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:43:12 +0200, Krzysztof Kozlowski wrote:
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
> The sitronix,st7735r references also panel-common.yaml and lists
> explicitly allowed properties, thus here reference only
> spi-peripheral-props.yaml for purpose of documenting the SPI slave
> device and bringing spi-max-frequency type validation.
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
>  .../devicetree/bindings/display/panel/lg,lg4573.yaml       | 2 +-
>  .../devicetree/bindings/display/sitronix,st7735r.yaml      | 1 +
>  .../devicetree/bindings/display/solomon,ssd1307fb.yaml     | 7 +++----
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks!
