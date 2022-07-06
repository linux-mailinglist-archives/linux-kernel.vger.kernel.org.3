Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47734568C63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiGFPK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiGFPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:10:25 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7666F65D7;
        Wed,  6 Jul 2022 08:10:25 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id r133so14274237iod.3;
        Wed, 06 Jul 2022 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ti4zmV4GUapG/KcWvw/wcUeeD0JIk7jWHgtf+D9XkUc=;
        b=gcp5efh9IvLopr3Lpz1ts+1tQeSI9tYpaFLMloOaVkUtU3rR8YErYcqMVpeADjAQPH
         L/tEth+C5zSU1+Ege44JpucqvWygPXcLpLVIuMLfHQGNtPEgREPmCk4qmX8a1Dbo8cEE
         fGNSSuLI56duo+xNiJk8jM0GTqwGVh8yYM8Hqb1TUVvV1KjxEt1fEMygw+FqJpXk+Qlk
         +zQVe0K4gineQt0IvxENZz/QYVheXgPKakrnW6e32ntME4V+8Li7Qk42HLXIsjOMPiqY
         CCtt+p4KWGSjco4P64s6AWSqzO6aRStlCDesYV+4o3QsuNnw/nt9uk5pOHnNF9Cjeern
         5inQ==
X-Gm-Message-State: AJIora+xyJv8zutRzul5LWkskupPULp6RSmKYUc14lCkVFYZJnnbVR7E
        lJd5uKF3F7TLE5YVmzfHGg==
X-Google-Smtp-Source: AGRyM1u7Si3EOMaQg8tfbk3/6gmgmrta74QsCxtc71g6m2mKVZfQnkfBZeJHPq5m0IW/hXHFwWK01w==
X-Received: by 2002:a05:6638:304:b0:33e:9d12:99f5 with SMTP id w4-20020a056638030400b0033e9d1299f5mr18195671jap.45.1657120224755;
        Wed, 06 Jul 2022 08:10:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id cn27-20020a0566383a1b00b0033efc8857c0sm1475754jab.50.2022.07.06.08.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:10:24 -0700 (PDT)
Received: (nullmailer pid 52757 invoked by uid 1000);
        Wed, 06 Jul 2022 15:10:22 -0000
Date:   Wed, 6 Jul 2022 09:10:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwinfo: group Chip ID-like devices
Message-ID: <20220706151022.GA52709-robh@kernel.org>
References: <20220705154613.453096-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705154613.453096-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 05 Jul 2022 17:46:12 +0200, Krzysztof Kozlowski wrote:
> Group devices like Chip ID or SoC information under "hwinfo" directory.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Spllit renesas,prr.yaml into separate patchset.
> 
> Changes since v1:
> 1. New patch
> ---
>  .../exynos-chipid.yaml => hwinfo/samsung,exynos-chipid.yaml}    | 2 +-
>  .../{soc/ti/k3-socinfo.yaml => hwinfo/ti,k3-socinfo.yaml}       | 2 +-
>  MAINTAINERS                                                     | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{soc/samsung/exynos-chipid.yaml => hwinfo/samsung,exynos-chipid.yaml} (92%)
>  rename Documentation/devicetree/bindings/{soc/ti/k3-socinfo.yaml => hwinfo/ti,k3-socinfo.yaml} (92%)
> 

Applied, thanks!
