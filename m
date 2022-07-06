Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6283568EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiGFQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiGFQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:11:37 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4197826AE8;
        Wed,  6 Jul 2022 09:11:36 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id p128so14455408iof.1;
        Wed, 06 Jul 2022 09:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yn8tR4/75agkFJENZOIVD2SZjKFyA+a7PHsFMtDwO+Y=;
        b=t9EcJXTL8xgt+krH71KFPcfQeQBs6vQjesu+nYe4QmxlWVhSHFQEip2ZGiWbD6uW6o
         Cr3IG4BcKrDE+/YwaCB7/588c+af25G84SF3uUmtHP3Y8YQp5FK3GpCZFyu7TMDNRyJR
         grEf4HCyCo6K/hIqdMNPrr2qaMRHRRfHLE3ric3iJPReGAQLChL/JMDesmPg/CqQlMmV
         yH7ZlnViWB/safbl7V2/71dXDM56XeBAi31AftvwbgP8YVKn7rPy6K6xASln6MVVtaMo
         rjQh8kbuaWnJk/oTZpKpt0YsYBdOteCk7XZReg8+7lr/VOws0WxmhjNdIqhsHBsf4fSs
         +b6Q==
X-Gm-Message-State: AJIora8PqllGTf+fIuxG6e+isMjVhv86QOVehEmwYqqSXdW9bxRnAVDD
        j/hOmOeZqh7ob8mA8wh8s5nhpa0jRQ==
X-Google-Smtp-Source: AGRyM1uwBDjxglmKGpZwt97wz+OegWG99R+2nYnYk0T8Ikwk585QkGnuzVr7ZeezMJ7kaTmArLk7DQ==
X-Received: by 2002:a05:6638:40a4:b0:33e:2862:4ecf with SMTP id m36-20020a05663840a400b0033e28624ecfmr21115909jam.107.1657123895503;
        Wed, 06 Jul 2022 09:11:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n3-20020a056638120300b003317fc4aa87sm16010355jas.150.2022.07.06.09.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:11:35 -0700 (PDT)
Received: (nullmailer pid 137394 invoked by uid 1000);
        Wed, 06 Jul 2022 16:11:33 -0000
Date:   Wed, 6 Jul 2022 10:11:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: hwinfo: renesas,prr: move from soc directory
Message-ID: <20220706161133.GA137360-robh@kernel.org>
References: <20220705155038.454251-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705155038.454251-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 05 Jul 2022 17:50:38 +0200, Krzysztof Kozlowski wrote:
> Group devices like Chip ID or SoC information under "hwinfo" directory.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This should go via Renesas tree because of changes around soc/renesas/renesas,prr.yaml.
> 
> Changes since v1:
> 1. Split from https://lore.kernel.org/all/20220705154613.453096-1-krzysztof.kozlowski@linaro.org/
> ---
>  .../bindings/{soc/renesas => hwinfo}/renesas,prr.yaml           | 2 +-
>  MAINTAINERS                                                     | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{soc/renesas => hwinfo}/renesas,prr.yaml (92%)
> 

Acked-by: Rob Herring <robh@kernel.org>
