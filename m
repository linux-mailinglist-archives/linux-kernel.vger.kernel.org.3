Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0934F9F22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiDHV0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiDHV0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:26:03 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BB631539;
        Fri,  8 Apr 2022 14:23:57 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id j83so10124037oih.6;
        Fri, 08 Apr 2022 14:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0T6S7+QP7qWOZqAmU2HeursYTQCWQoHrmh79ye1Au6A=;
        b=pJva/3tYgYHpnd2TM+FiU+CstOvIUQh0r8s/vGIVtKgy3PhYEobIOAI7GoDqwM0bGk
         lvxaopfx1E73kjj6oXb9FK1H5VQzrLoFpZlTDLMbzEeCjQtNtr2QAKk9VeqO3Ttj+4Ki
         2f8/p+Be0PgX2PWLv6AENf37gtZJrDbTxX0Mo6M0whAFyMOGT8KMOAIXI3mv3IkeN+2b
         QQBsO9B/+ZiYM4srL/BqYDgs7pMOQn/g7bxPvDLknO4WTsBlhjZKtrNphchYhixvAd8C
         tF3T99yRlxf1OPptXwIu6l7utLE5fx2/9guwxxcFcZyAh0n95wTHf2ah2Rn9PWGY5WBT
         8Zcw==
X-Gm-Message-State: AOAM532USHl1RzYgI3C6j5sbDJOzrBkrNpcgvfkKvHtVv07fXe3Ukv9s
        NqhmADg8TFjPjHjwijQXOg==
X-Google-Smtp-Source: ABdhPJzJGJC0SnhPZeOBXHawRPojHmwZQHykZy3Yf4Unn2+H1trg/FFezSEv1rfslsihDjHVXco/Qg==
X-Received: by 2002:a05:6808:1b12:b0:2da:28e1:39f7 with SMTP id bx18-20020a0568081b1200b002da28e139f7mr786027oib.289.1649453037335;
        Fri, 08 Apr 2022 14:23:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bp21-20020a056820199500b003298e6877c7sm2982402oob.29.2022.04.08.14.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:23:56 -0700 (PDT)
Received: (nullmailer pid 4094588 invoked by uid 1000);
        Fri, 08 Apr 2022 21:23:55 -0000
Date:   Fri, 8 Apr 2022 16:23:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: mtd: jedec,spi-nor: remove unneeded
 properties
Message-ID: <YlCn639koXzXcAY8@robh.at.kernel.org>
References: <20220408063720.12826-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408063720.12826-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 08 Apr 2022 08:37:20 +0200, Krzysztof Kozlowski wrote:
> After conversion the jedec,spi-nor DT schema to reference other schemas
> (SPI and MTD) and use unevaluatedProperties, few properties are
> redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes since v1:
> 1. Do not remove address/size cells (Rob).
> 2. Add Pratyush review.
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 8 --------
>  1 file changed, 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
