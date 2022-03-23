Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBC04E599D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbiCWUOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbiCWUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:14:38 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168DBD63;
        Wed, 23 Mar 2022 13:13:06 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-de3f2a19c8so2896851fac.1;
        Wed, 23 Mar 2022 13:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0dtghV1fkEXQC3eY/8QyiqW6VQirMjQBl/NSTjJ0W9I=;
        b=JGYUxljba0jZsOFk3PA5RW7Ys9FxFTVDybJpIwNc9MflcbRx08O0ZYjQcElC+gstN/
         Kc/TBsoZRjnzSpjUC8lWpZiCYqJodlIAKLT9XPRLiLupNjr9hfPyhlNtkL1vgA1t2kh0
         vh7UdjYO1EqQINxlZ+cBnrtv/Vgs0xgfrS20JTcEsbfVJYTYBJRU2f9Cm5TKLjP/p9nJ
         ggwnalH/YwVRgaumFHBG0piVq9vKn0zohUCpK5EuZW5m5npJRMFLYyJ3JGVSfB9GDhnn
         N3lvMzL3e2MJc6Ea2kUNeipNE1NNVhGaw8IWOTBiyhntP6wCw/X8hyUPXsnA2UQ2gV4Z
         stfg==
X-Gm-Message-State: AOAM532q8bjyiYZctrcJLpyaqxXixDNTvy0gjHYImlKJIsv2hAH2FfZD
        M4Y6mnwBCXeZRaVzXd256g==
X-Google-Smtp-Source: ABdhPJx08/NjwL/LKLNaYctq1rd2mdl4jiv/04ZWeiY6YBXgM0/680BNb6NQWQd/cV6Kt76ohwagPg==
X-Received: by 2002:a05:6870:c101:b0:da:b3f:2b89 with SMTP id f1-20020a056870c10100b000da0b3f2b89mr5288216oad.296.1648066385933;
        Wed, 23 Mar 2022 13:13:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c9-20020a4a8ec9000000b0032438ba79b0sm449783ool.0.2022.03.23.13.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:05 -0700 (PDT)
Received: (nullmailer pid 373336 invoked by uid 1000);
        Wed, 23 Mar 2022 20:13:04 -0000
Date:   Wed, 23 Mar 2022 15:13:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     broonie@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        ashishsingha@nvidia.com, skomatineni@nvidia.com,
        ldewangan@nvidia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: dt-bindings: Add wait state polling flag
Message-ID: <Yjt/UDlkE9ciA4Yt@robh.at.kernel.org>
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
 <20220317012006.15080-4-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317012006.15080-4-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 06:50:06AM +0530, Krishna Yarlagadda wrote:
> Add flag to enable tpm wait state polling and Tegra Grace binding.

TPM

> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  .../devicetree/bindings/spi/nvidia,tegra210-quad.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> index 0296edd1de22..88b00fcad210 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> @@ -20,6 +20,7 @@ properties:
>        - nvidia,tegra186-qspi
>        - nvidia,tegra194-qspi
>        - nvidia,tegra234-qspi
> +      - nvidia,tegra-grace-qspi
>  
>    reg:
>      maxItems: 1
> @@ -57,6 +58,11 @@ patternProperties:
>        spi-tx-bus-width:
>          enum: [1, 2, 4]
>  
> +      nvidia,wait-polling:
> +        description:
> +          Enable TPM wait state polling on supported chips.

What's TPM?

Why is this not implied by the compatible string?

Also, how child node properties are handled has changed. See 
Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml. The 
NVidia specific properties should be refactored first before adding 
more.

> +	type: boolean
> +
>        nvidia,tx-clk-tap-delay:
>          description:
>            Delays the clock going out to device with this tap value.
> -- 
> 2.17.1
> 
> 
