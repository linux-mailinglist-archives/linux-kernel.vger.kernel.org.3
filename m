Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BAD57D238
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiGURKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGURKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:10:21 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A92DFB4;
        Thu, 21 Jul 2022 10:10:19 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id h145so1818184iof.9;
        Thu, 21 Jul 2022 10:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VkJPhvS+uSo0bY5B3qcOZxndCJqg8Ex2QXcqdMU/IXY=;
        b=MRrNyoUEUGJy1n1Vo5/LKW9v1nPTn6/BR8zuQDyeoFO2i6ZNFyqCWlKV6T2TF1slHI
         elUfgC7FEd+63sSpCsGNx5pi45DNIZDFJ5o+PvvWQjR2S1IMkjYAUziLFaQVnHPm/Exn
         e5/m2pNFF/2SXk/wmPRxK0mq6lbkAsW/1VO+M1rwSMr606MuHyjRF14L78KyUXhh7ixZ
         qbdU69HAvVcwYvFeJrCgz3JoPy+DpWVF2YECfBiOV3V4mWz3+y5nEvpGewVb/sGvk8+u
         iNDfvs61InAu7h9Y3oQZbiIkwIv4oYkOJIZ4m3sqkd5cnToAYKHgBhfey7BLuEo8p3kr
         G6zg==
X-Gm-Message-State: AJIora/aLGP78x3uNCA6t7dvNs/eZT+YnaR1899V2JtIxR4xwNc0M6wA
        7lMCxQT8dg3wpXaADUPgCU7Esew+EA==
X-Google-Smtp-Source: AGRyM1ukzDccfjVcOfIuRZcPN3cqoN09BU15NWdF8GcitKzP+XwaSu0KzvJBTRkWmZaUfKuT/6CFFA==
X-Received: by 2002:a05:6638:16cf:b0:341:4543:b354 with SMTP id g15-20020a05663816cf00b003414543b354mr19414487jat.114.1658423418378;
        Thu, 21 Jul 2022 10:10:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z9-20020a05663822a900b00339c855eb15sm1015110jas.27.2022.07.21.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:10:17 -0700 (PDT)
Received: (nullmailer pid 1577020 invoked by uid 1000);
        Thu, 21 Jul 2022 17:10:16 -0000
Date:   Thu, 21 Jul 2022 11:10:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kyle Swenson <kyle.swenson@est.tech>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: leds: fix indentation in examples
Message-ID: <20220721171016.GA1576632-robh@kernel.org>
References: <20220607075247.58048-1-krzysztof.kozlowski@linaro.org>
 <20220607075247.58048-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607075247.58048-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jun 2022 09:52:47 +0200, Krzysztof Kozlowski wrote:
> The examples were mixing 4-space with 2- and 3-space indentations, so
> correct them to use 4-space one.  No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Add Rb tag.
> 
> Changes since v1:
> 1. None
> 
> Cc: Kyle Swenson <kyle.swenson@est.tech>
> ---
>  .../devicetree/bindings/leds/leds-lp50xx.yaml | 110 ++++-----
>  .../devicetree/bindings/leds/leds-lp55xx.yaml | 222 +++++++++---------
>  .../bindings/leds/leds-pwm-multicolor.yaml    |  36 +--
>  3 files changed, 184 insertions(+), 184 deletions(-)
> 

Applied both patches, thanks!
