Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100F4B00D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbiBIW7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:59:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiBIW7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:59:33 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4BBE04FF0E;
        Wed,  9 Feb 2022 14:59:36 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id y23so4101847oia.13;
        Wed, 09 Feb 2022 14:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PS01IT7f00fD8ocmfo6l7+3uWA7i08pGf7Cni3oWefw=;
        b=Q/+Uu28pfN1X4NVlSr9gfhELEYo3GEuUNyO9ik7kMJb3XYsI/PzXTAwBczEIsE1o5Y
         xaj2Naj3Ci7v4wpLbs5idzXzyfrfPbmxENDcE74MEg2GtvvE83AbNspf6H7ZqfkTVsbz
         XuZoL1HO3hAhK2xEX+8inCuxcBLkUE7B4DOL9W4iiYyfGgK4iqjbugF4me6NZ9hVIMsD
         EODsO81H8iZVO8V1zgTO/+tzyZXpxPQVCguo6/1y9O4fZny6wOJbuLYnqBp4ddvvg52q
         ZZ6IJAcTfFeJPzO2cNi9y3j8ynRZLrcg0h5xmtIZn5ydTxp6gkM4BAfv9CHG6PhX6EAI
         ktqQ==
X-Gm-Message-State: AOAM533uOSsGr+iR8A18vCsaQvIm+SR7rgmygIowRPIyP4qG/UQ389jn
        Y6Lec8BM7gb71fTJ9FaBFMhqsXzaAdcu
X-Google-Smtp-Source: ABdhPJwffIJTZ9p2vpY4Y+kXCCTdGMwKen87G0RMQMlsFMD0Ah/wmDmiZu3aRdaHDHjct16QO26o8g==
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr2586558oib.18.1644447575874;
        Wed, 09 Feb 2022 14:59:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e26sm7532250oiy.16.2022.02.09.14.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:59:35 -0800 (PST)
Received: (nullmailer pid 1107859 invoked by uid 1000);
        Wed, 09 Feb 2022 22:59:34 -0000
Date:   Wed, 9 Feb 2022 16:59:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        dri-devel@lists.freedesktop.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 09/10] dt-bindings: display: samsung,exynos5433-mic:
 convert to dtschema
Message-ID: <YgRHVpZ7WNgg4QXg@robh.at.kernel.org>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
 <20220208171823.226211-10-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208171823.226211-10-krzysztof.kozlowski@canonical.com>
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

On Tue, 08 Feb 2022 18:18:22 +0100, Krzysztof Kozlowski wrote:
> Convert the Exynos5433 MIC bindings to DT schema format.
> 
> The conversion includes also updates to the bindings, matching the
> current DTS and Linux driver: adding optional power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/display/exynos/exynos-mic.txt    | 51 ----------
>  .../samsung/samsung,exynos5433-mic.yaml       | 95 +++++++++++++++++++
>  2 files changed, 95 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos-mic.txt
>  create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml
> 

Applied, thanks!
