Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F99456387F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGARTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGARTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:19:48 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134531DC5;
        Fri,  1 Jul 2022 10:19:47 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id r133so2896579iod.3;
        Fri, 01 Jul 2022 10:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ICeVaYUEaNVqqQDgCp0YahEpS5ttm9c51O2La87iQY=;
        b=cz6USwxA6RByyqT3nXgT5+Esl3+Y2WQDHBJ1VWJue8CKqTS2769G1fvrAgCIMvW7Tk
         FmyvNsMTg51Oi4gsLwH/Q5ibgCtm3EobKes3rYSV1OlbUsAKHGJS4nGzEJIVXIRGU6ZE
         kYwz+KM3b+ZEk0Nc2cAxNnd5p4ZyH8FZ0er/t9mp4EtLXfgzCPrc6uj5xTxYQY7y7mKV
         q3V1FBNq/XSPjMdl3RBxVd9KNKq7cD8+7ny4Bk6AcLtbsn3WnaYJkuDhdgJBK8m8H705
         /NyBAmlHGOmTmvJHZZ0O0R+FIWJW6CCvi46CDM7GZl0YT1KKTpbf9owiifLL/mI3DVfj
         anlA==
X-Gm-Message-State: AJIora/GmpwsHQyL0p2Xj8DcPSHOoxRMRNkwC9iF/0mnZouYWhpT1T1r
        E07P+6G02pOvVS7qr5Wj/A==
X-Google-Smtp-Source: AGRyM1tOPvOoBYnjXOMTWZevc6/prF/DoW7LfDDYDLJUmL3WxSHteDqogJhK4OGcpcZIvwc9wErrZw==
X-Received: by 2002:a6b:794d:0:b0:66c:ec39:7d83 with SMTP id j13-20020a6b794d000000b0066cec397d83mr8205468iop.199.1656695986259;
        Fri, 01 Jul 2022 10:19:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c21-20020a023315000000b00339e7ec8a39sm10392997jae.7.2022.07.01.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 10:19:45 -0700 (PDT)
Received: (nullmailer pid 1164541 invoked by uid 1000);
        Fri, 01 Jul 2022 17:19:44 -0000
Date:   Fri, 1 Jul 2022 11:19:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-media@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] dt-bindings: media: samsung,s5pv210-jpeg: convert to
 dtschema
Message-ID: <20220701171944.GA1164482-robh@kernel.org>
References: <20220629120803.61965-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629120803.61965-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 29 Jun 2022 14:08:03 +0200, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC JPEG codec bindings to DT schema.
> 
> The original bindings were quite old and incomplete, so change during
> conversion:
> 1. Add typical (already used) properties like iommus and power domains.
> 2. Document samsung,exynos4212-jpeg compatible (already used in DTS and
>    driver).
> 3. List clocks per each variant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/exynos-jpeg-codec.txt      |  16 ---
>  .../bindings/media/samsung,s5pv210-jpeg.yaml  | 123 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 124 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,s5pv210-jpeg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
