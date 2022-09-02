Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15A5ABA05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiIBV07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIBV04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:26:56 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC8E868C;
        Fri,  2 Sep 2022 14:26:54 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11eab59db71so7807774fac.11;
        Fri, 02 Sep 2022 14:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HhwAq/vDNTlBKsXcbK0uK2gU5AmQ5w3I6bZydvNkE/M=;
        b=hyqIcxlkVLipHcBJfg/YHpqG14MXqvgRFylJssYWuGjf/+KJohZp7Tx58wOWO/YYGH
         Aye9YC0zg/flbrKhTqbOqfQI+K3lsfz77yI8ha49tTapUUyobVY33uNiS4zOx16H1xtq
         ZsRcXeof+0y7nm5qHVAHuzGfsM8e/DcgoqA4OOogZdO46C6Q7qomENWxq1sb3mJ0VVa0
         jTGCvpfqW6/Pc0dMeTQVcoLctgE+Gq0r9G3uownCvY+vtZvz679SeZc6tP36NTW0kpj/
         7NWYlMvIbk9jYEsXFNaAaGzLOR2g43sCKegRxPh53fdMtotYrNc2dtvMXsDjEyD/Kf6P
         vGvQ==
X-Gm-Message-State: ACgBeo28mrYlC6mPPOF0MMf5+FdyTo44g/RLLq1NcfT7HLEpzVuuUEfP
        LM5V6B5SWZE6ijDlkEca6IotWq5AEA==
X-Google-Smtp-Source: AA6agR5HVtlfpkeSK+zUcy/7maeq38rj0Gpl9WVZUl0+U4jQo+a7nGSbVMZ4Vkh3VtNlyqr4f4XyzQ==
X-Received: by 2002:a05:6808:138d:b0:344:973a:366c with SMTP id c13-20020a056808138d00b00344973a366cmr2730727oiw.134.1662154014124;
        Fri, 02 Sep 2022 14:26:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e62-20020a9d2ac4000000b00636d4e8d480sm1538816otb.19.2022.09.02.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:26:53 -0700 (PDT)
Received: (nullmailer pid 443164 invoked by uid 1000);
        Fri, 02 Sep 2022 21:26:53 -0000
Date:   Fri, 2 Sep 2022 16:26:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: dt-bindings: dongwoon,dw9714: convert to
 dtschema
Message-ID: <20220902212653.GA443125-robh@kernel.org>
References: <20220901071437.17637-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901071437.17637-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 01 Sep 2022 10:14:37 +0300, Krzysztof Kozlowski wrote:
> Convert Dongwoon Anatech DW9714 camera voice coil lens driver to DT
> schema and extend the bindings with vcc-supply (already used by driver)
> and powerdown-gpios (based on datasheet, not used by the driver).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Update path in Maintainers
> ---
>  .../bindings/media/i2c/dongwoon,dw9714.txt    |  9 ----
>  .../bindings/media/i2c/dongwoon,dw9714.yaml   | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 48 insertions(+), 10 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.txt
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
