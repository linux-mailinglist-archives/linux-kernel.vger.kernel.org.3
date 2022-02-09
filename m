Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F334B0072
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiBIWiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:38:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiBIWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:38:44 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E92E00D112;
        Wed,  9 Feb 2022 14:38:47 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r27so4100749oiw.4;
        Wed, 09 Feb 2022 14:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o7EbDM3Sg4dJqZKRFYlRADRzkTEFhskqXnPZDWtN3zo=;
        b=LWwev9MDGGhUZsaWkTLKYHToBT81+VMV4YJ55VGDwBQadH41OJnGgzhJSaAfQ+iHJn
         c4+qOwp+SyfwJ5I0DOg9Cq9qJudUbdofJ+SGJLZpomgEqGhO+grY31T0oxWkX834qgwp
         bEnHYhMcUpeRiEnSlvVfHVGoMhOMNl+f80QQ64YLutGg4KuFO4ncNiOnnZ87yhLvzT1X
         uRCuNIbLpJf6T9a8wfCLMy6DB6IR/m+sZCpsH2BbeIbZ04JKiabOfhQ1Uu3kwSRIW8zf
         1zaqfNnoZ9gVsuhVlk4NYlgpIN9zNcGYoRSquumaVleMRA90jjfx1MIaWP13ltC+Az28
         cYIw==
X-Gm-Message-State: AOAM5317eGogLu4j/n8c+n/KHTw9F91BkwyPhu8e/6DizKXx9NEVXZVL
        Q00l3Cb987sM1tjzqHiTIAtNDiEszb1R
X-Google-Smtp-Source: ABdhPJyC00fwTEI84ZbvpKeVOvCbdh3+1qBMumfSSXhULHlVqUVf+3trh4gQ4rQ7UzAVMaA66zNkDw==
X-Received: by 2002:a05:6808:2011:: with SMTP id q17mr2512976oiw.199.1644446326809;
        Wed, 09 Feb 2022 14:38:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a10sm6994619otb.58.2022.02.09.14.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:38:46 -0800 (PST)
Received: (nullmailer pid 1072549 invoked by uid 1000);
        Wed, 09 Feb 2022 22:38:45 -0000
Date:   Wed, 9 Feb 2022 16:38:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 04/10] dt-bindings: display: samsung,exynos5433-decon:
 convert to dtschema
Message-ID: <YgRCdVy5RJr7acnI@robh.at.kernel.org>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
 <20220208171823.226211-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208171823.226211-5-krzysztof.kozlowski@canonical.com>
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

On Tue, 08 Feb 2022 18:18:17 +0100, Krzysztof Kozlowski wrote:
> Convert the Exynos5433 DECON display controller bindings to DT schema
> format.
> 
> The conversion includes also updates to the bindings, matching the
> current DTS and Linux driver:
> 1. Require "fifo" interrupt.
> 2. Add "dsd" as a last clock.
> 3. Document "power-domains" and "iommus" properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../display/exynos/exynos5433-decon.txt       |  60 -------
>  .../samsung/samsung,exynos5433-decon.yaml     | 148 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 149 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos5433-decon.txt
>  create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-decon.yaml
> 

Applied, thanks!
