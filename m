Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BBF568ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiGFQQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiGFQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:16:37 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0292275D0;
        Wed,  6 Jul 2022 09:16:32 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id m14so6695463iln.10;
        Wed, 06 Jul 2022 09:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ddGuNqAPKGhs6U4GMzwzzf65/bpsRlMBqMseDmOZOrE=;
        b=hfGGHGnVvFnEcVmnhtITwCwCsDijXvkVSTNuqbSBmar+ieHlt5ayyqQFo5kW0Gjpy1
         DzdnEWkPmLGnQlYlSDZT1ClVKBgZLVBmuXRp10R+tiW9iT6i7YmlSFMtHR+HMyBazEaG
         /3EGbRGpfoZJrXXbKg51n04WC5dm8uR9D3VLQ84YA/2PXa/SEa5VXL3AQwhlnBgdqQl4
         nI8e3vIZnO5hy9kQHIgy0nHEPeyuF+adqQqf7f1Ureg/l8/u3UUVO6E3Cla81xSl+ccE
         K0+DfN7pmeMaAT5B4NjMNOXimvvkzPMKAMF7JhC4jU4TmR2DNGvQ7N12rIx0waKtd/ke
         MdOg==
X-Gm-Message-State: AJIora/s3pzb6qT4zAx3xtty18QSRlUqrI2dShJ6/YBeUkuiMkfumWuK
        BnowWJqiF++WD/44xL7HDUT2671N/g==
X-Google-Smtp-Source: AGRyM1vDxXJbiT5R1wMav0rVXx4q89oXx8N9J+tN2HjphY3dgqez462rKICk5Ls69gU9cA2/BhoKag==
X-Received: by 2002:a05:6e02:1486:b0:2da:9864:b480 with SMTP id n6-20020a056e02148600b002da9864b480mr25312239ilk.70.1657124191489;
        Wed, 06 Jul 2022 09:16:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a17-20020a056e0208b100b002d955fab9dbsm14731241ilt.23.2022.07.06.09.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:16:31 -0700 (PDT)
Received: (nullmailer pid 144988 invoked by uid 1000);
        Wed, 06 Jul 2022 16:16:29 -0000
Date:   Wed, 6 Jul 2022 10:16:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 2/3] dt-bindings: soc: samsung: exynos-pmu: use abolute
 ref paths
Message-ID: <20220706161629.GA144936-robh@kernel.org>
References: <20220706095037.78542-1-krzysztof.kozlowski@linaro.org>
 <20220706095037.78542-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706095037.78542-2-krzysztof.kozlowski@linaro.org>
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

On Wed, 06 Jul 2022 11:50:36 +0200, Krzysztof Kozlowski wrote:
> Preferred coding for referencing other schemas is to use absolute path.
> Quotes over path are also not needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
