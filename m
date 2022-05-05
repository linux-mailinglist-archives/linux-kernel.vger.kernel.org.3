Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAA51C240
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380540AbiEEOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiEEOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:23:16 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76155A58F;
        Thu,  5 May 2022 07:19:32 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id s131so4482646oie.1;
        Thu, 05 May 2022 07:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAYaOtPPbiHUybmB7ECbYM6eAkDRJOEMsqqS3ybjkQQ=;
        b=G9nGEnS1fueEVxdoAaDNBPje0FXuzI5XvaCEBoTmHeeyH2sHT3jdVoQFFyNK7XxOOr
         z/0Sot5BArxV6jaDg8FPZjwxD93XYcvce+tV9BSdrfeGpwk+mw9hi/vhVE2KfhgAYzJu
         OPB/o+mmykinmWI/ccGSqEFXSdsQNZtq/QnjtPjnFiUtaocpPDqrDT59RgskU7hn4XkF
         Rtfk7IxM/C7exzT9u++3WL4JthpyLpekYOd8asCpR9KzqRmC2BhNS2G5IdOvBAsdgNH8
         KB5exF6JefFEZEs4EElPxNfZCSX1jcMaw+QeivdL9zcVZMWPQ1piTBQ8tBhmySYUSQkn
         gbwg==
X-Gm-Message-State: AOAM530smVaxP+UELWd3xD6vwVmWhwIoTHrn4h/aTSLFd5mqCWtD8fIc
        40IReCXrucYPnWML0ecWQw==
X-Google-Smtp-Source: ABdhPJwzj1x/MsCJLVyAu9Nd+++VQJgMcMB80x9zI4S6ZvGYcmKumkCZtUjcj0Pana/B8hDQli9+Qw==
X-Received: by 2002:aca:d9c3:0:b0:2fa:6f51:7bfe with SMTP id q186-20020acad9c3000000b002fa6f517bfemr2552470oig.59.1651760371705;
        Thu, 05 May 2022 07:19:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z8-20020a05687041c800b000e686d1386csm517724oac.6.2022.05.05.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:19:31 -0700 (PDT)
Received: (nullmailer pid 3821732 invoked by uid 1000);
        Thu, 05 May 2022 14:19:30 -0000
Date:   Thu, 5 May 2022 09:19:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, - <patches@opensource.cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: wlf,arizona: Add spi-max-frequency
Message-ID: <YnPc8jIzRfQ/nMAP@robh.at.kernel.org>
References: <20220504084304.46173-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504084304.46173-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 04 May 2022 10:43:04 +0200, Krzysztof Kozlowski wrote:
> The Wolfson Microelectronics Arizona audio can be connected via SPI bus
> (e.g. WM5110 on Exynos5433 TM2 board), so allow SPI peripheral
> properties.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Allow all SPI properties, not only max-frequency.
> ---
>  Documentation/devicetree/bindings/mfd/wlf,arizona.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
