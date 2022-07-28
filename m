Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099595842E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiG1PTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiG1PTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:19:47 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4A654AEC;
        Thu, 28 Jul 2022 08:19:47 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id y197so1588815iof.12;
        Thu, 28 Jul 2022 08:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0z/h9XBmB5jyPdPiW47nkL54BYrItNNHG2DA/iFVm6k=;
        b=k5aZUG+oBLL7zJq/+YB6TmziUuuGyy8zOm7UUlIHb9TsnDb51wvNPqlHErlxWL5Q4/
         SwGj+NXxBC8T38lt6twLiidU6K1nOhvCInIJU/MP36eMI29KZ/x6GEG8jbo6YsmQN98M
         mLmTOxUK3/WVDFEp+E3X1b3l+5GFbbUOE/CfND29RVsc1QRnxlK52GaU+ebYJ59aFnni
         mGglkpcJ5FUdAfF1GtRhpk7TxbesczPnzPdDD4taFRuoocXuvjpOS0vAPhoGmxzc1kLb
         UGRCkVG1e6k6lm/6YSZLVoQ2Wn8a5aNajZSuXRp3TfxRPm0GQDiP8yJTj9AMDc4Sgi+s
         0tAQ==
X-Gm-Message-State: AJIora+DBLe/j+dPvIlOZULIwXOiocNtiCYm+U4ZJi6UIziTM7lQMGKV
        f16wmJehcbizRwF2YcpjhA==
X-Google-Smtp-Source: AGRyM1ugjEwL5OtivvGtWO4E5B1nNCf/kf7E4cZlfHIETS/ruoOPYRf5H0G1w3QKJWthkeh6i/xKDQ==
X-Received: by 2002:a05:6602:168d:b0:67c:44c3:9ba5 with SMTP id s13-20020a056602168d00b0067c44c39ba5mr9745834iow.190.1659021584187;
        Thu, 28 Jul 2022 08:19:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d4-20020a6bb404000000b00678e1d1b2c7sm511200iof.0.2022.07.28.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:19:43 -0700 (PDT)
Received: (nullmailer pid 903417 invoked by uid 1000);
        Thu, 28 Jul 2022 15:19:42 -0000
Date:   Thu, 28 Jul 2022 09:19:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: ariel-pwrbutton: use
 spi-peripheral-props.yaml
Message-ID: <20220728151942.GA903363-robh@kernel.org>
References: <20220727164230.385614-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164230.385614-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:42:30 +0200, Krzysztof Kozlowski wrote:
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
> typical place, just before example DTS.a
> 
> The binding references also input.yaml and lists explicitly allowed
> properties, thus here reference only spi-peripheral-props.yaml for
> purpose of documenting the SPI slave device and bringing
> spi-max-frequency type validation.
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
>  Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
