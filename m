Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817F558574B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 01:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiG2XX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 19:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiG2XX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 19:23:56 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088E252DF0;
        Fri, 29 Jul 2022 16:23:56 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id q14so4699313iod.3;
        Fri, 29 Jul 2022 16:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4GqsI77tDw1cSxOsLM8y8566USxds3LrL7OOb2N+RPc=;
        b=52067msnZMOMUubdYfif2tg/bfcmoVBCoWC9SiFt/yy6mHHUIzBJejQzxqVNY/MQTO
         DDIqcKwEYJPAx4W6ax1koIJK+7a6aB61TlrMv3x4VrJg+ozd5FMR7Qjc0jQw6lKEnTYS
         cjWrUNlmcBg2p6LNBSzIT08rSx5ooKBKYjytdysOciVccJHH8ScRMLy0CIccFqQ1Y4yY
         yY7n1LgwYVyXBEKh85QCohxqFhorglB8zPD+Abiige/69LWE5CQO+F7FoTLxPU60CRzg
         hcG2YMSAFXIJPgym+PQ8mGWtvjxmZnKzCQF9G4z8s1mocXl95ST3/Iqrv6lAKG5bMUWq
         mU/w==
X-Gm-Message-State: AJIora8zGK8oWkP5kPagnDivb7uI4Dbfv9BeLY81yAjyyNowDmZS067o
        HUblgYb0rxwOGhPOkjHnpQ==
X-Google-Smtp-Source: AGRyM1uNC/Y1iloxYiT7ksHfHcX//0QOzvz9HVfFNI7OY9qeNjBMUCV7EoHAvdJXBIUSxN4ijCzWTA==
X-Received: by 2002:a05:6638:ecd:b0:33f:32d5:469c with SMTP id q13-20020a0566380ecd00b0033f32d5469cmr2059125jas.222.1659137035240;
        Fri, 29 Jul 2022 16:23:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d11-20020a023f0b000000b00339e669df91sm2242993jaa.153.2022.07.29.16.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:23:54 -0700 (PDT)
Received: (nullmailer pid 132555 invoked by uid 1000);
        Fri, 29 Jul 2022 23:23:52 -0000
Date:   Fri, 29 Jul 2022 17:23:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: eeprom: at25: use
 spi-peripheral-props.yaml
Message-ID: <20220729232352.GA132527-robh@kernel.org>
References: <20220727164424.386499-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164424.386499-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:44:23 +0200, Krzysztof Kozlowski wrote:
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
>  Documentation/devicetree/bindings/eeprom/at25.yaml       | 5 ++---
>  .../devicetree/bindings/misc/eeprom-93xx46.yaml          | 9 ++++-----
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 

Applied, thanks!
