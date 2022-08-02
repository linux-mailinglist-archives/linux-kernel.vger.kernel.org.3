Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3FE5880B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiHBRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHBRDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:03:04 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF1255BA;
        Tue,  2 Aug 2022 10:03:04 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id l24so11073043ion.13;
        Tue, 02 Aug 2022 10:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2FklMCvsf+IFL6IdQs89s38JLwJsvCdwCA9uElrwbhs=;
        b=b1VaronuxnKO/TQ9sTHzoNKDc6/PCEYqFlMvqbHIVAn09H/TxvV9KemyHSFoQbFjM3
         Cua1EXE/pmqySy66SOFTzPKBpGJyikmP/EzgUxLomn5stWFFZ08j0sWIqPcRLK4NhgcF
         OfryW3UxFeEnq+ydS3MrYncXirQvL/ORM+VmpX37MK+YAx+gtReRnEKPmlBZgSE42qc+
         Ldxzy7iazBWbHLbBM4Sj+5wNMM35XnKgcX0OsViRg5LZorybcJ1XVC4FPnK8Ee70v3sb
         ppnwlRdU7QTqkFA1FfPpQj9Lcm0orkrwhPHQbi8ziBu+DWRDddrudSLQf/99rt+B4o5r
         pGPA==
X-Gm-Message-State: AJIora8DhLkjUWTsXtYvnutPtynWhZlkSdbtylzkMfIpjC54O3+1Sx6w
        +7v5ARox0hHEPwKRdLUZYA==
X-Google-Smtp-Source: AGRyM1tbaN1sLhdrNh2TVrQLtic1f6Uc7wVbQREu84ol+jGbAI7KqCctkaE8hw2JA3Air2u+MzttgA==
X-Received: by 2002:a05:6638:d54:b0:33f:8e41:a3b3 with SMTP id d20-20020a0566380d5400b0033f8e41a3b3mr8841580jak.251.1659459783371;
        Tue, 02 Aug 2022 10:03:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z7-20020a926507000000b002de08fef8c5sm5721525ilb.43.2022.08.02.10.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:03:02 -0700 (PDT)
Received: (nullmailer pid 297736 invoked by uid 1000);
        Tue, 02 Aug 2022 17:03:01 -0000
Date:   Tue, 2 Aug 2022 11:03:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Schocher <hs@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: microchip,mchp48l640: use
 spi-peripheral-props.yaml
Message-ID: <20220802170301.GA297672-robh@kernel.org>
References: <20220727164148.385476-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164148.385476-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:41:48 +0200, Krzysztof Kozlowski wrote:
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
>  .../devicetree/bindings/mtd/microchip,mchp48l640.yaml      | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Applied, thanks!
