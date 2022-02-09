Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF80C4B00DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiBIXAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:00:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiBIXAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:00:18 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68684E04FF1B;
        Wed,  9 Feb 2022 15:00:21 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so4292796oot.4;
        Wed, 09 Feb 2022 15:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fpdeZ4kmn6qEAES9MKaD0qo3YztLrmDh8hg9/+KfbMk=;
        b=QQazM7aeDlzY8nMCZrRF/0cZokDy2pwkrQ/eUwCjIPmuE0XO0jU3sq2+5eoSPFwrOT
         d+QR758xCoNWePO7ErjMvpdmr9Yfutm2qXC8F0gGsf4FounvXqMbCVEVUQsl5wtqajG8
         7o3NJehwPP8g/qwj2EmgugSol8AiJsIKKFpN/+oIzo8ICpViVTQagx05CmUhTZ2jm5NC
         E36zXlGkEOiR0bATTSs2biqXBDxvhORsU5umrRQIF8Mj9i24+ljOtjIa1GUBHqdtEk5L
         uSm0ZunEkanssIRbgoJ2UEzr3f+81kzHkZINncpitHvlUP2VWZ/QE6XZBCNt5pA+KZ6i
         Ns8Q==
X-Gm-Message-State: AOAM533x0M02ovhN4WDQ/R6ThKC3jsRjqS3EH8Bij62t3IoO3e/rhVwW
        VtBVCQrPOwEB2fT+QZN3KA==
X-Google-Smtp-Source: ABdhPJyg/5tdFrGfYkHvpfJSK0OiHLVN85JRmS8cSUjQqBh7r5T+P6F/NMofLOrJYz4+0vWdYal59Q==
X-Received: by 2002:a05:6870:d4c5:: with SMTP id l5mr1742617oai.168.1644447620747;
        Wed, 09 Feb 2022 15:00:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v26sm7168237ooq.20.2022.02.09.15.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:00:20 -0800 (PST)
Received: (nullmailer pid 1109186 invoked by uid 1000);
        Wed, 09 Feb 2022 23:00:18 -0000
Date:   Wed, 9 Feb 2022 17:00:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 10/10] dt-bindings: display: samsung,exynos-fimd: convert
 to dtschema
Message-ID: <YgRHgg6TNjBzMBY6@robh.at.kernel.org>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
 <20220208171823.226211-11-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208171823.226211-11-krzysztof.kozlowski@canonical.com>
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

On Tue, 08 Feb 2022 18:18:23 +0100, Krzysztof Kozlowski wrote:
> Convert the S3C/S5P/Exynos FIMD bindings to DT schema format.
> 
> The conversion includes also updates to the bindings, matching the
> current DTS and Linux driver: adding optional iommus and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/display/exynos/samsung-fimd.txt  | 107 ----------
>  .../display/samsung/samsung,fimd.yaml         | 198 ++++++++++++++++++
>  2 files changed, 198 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt
>  create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
> 

Applied, thanks!
