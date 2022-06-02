Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EED053BA3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiFBN5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiFBN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:57:38 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0240378EC8;
        Thu,  2 Jun 2022 06:57:36 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id w19-20020a9d6393000000b0060aeb359ca8so3454013otk.6;
        Thu, 02 Jun 2022 06:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmzaWPni36LTWrL68JDxVCICKAzdgnrKhvK4tMCxkNQ=;
        b=vf9EoScgVYReHhG/3zdd3PLLsSGg/k5gCYHO0n8TAasx90Q7WpHUxeaEHdZzeKD5rF
         48VBezWK3HZuXt4ebmOyO4CcQwHIBdnskQ4P4bkDF8xzoEVgnqbm8RKO2txuaFslFqA6
         apnCVXzR7Iamr93FZIBVTWGpLkYCR2Lah6brnpTx59PWxgTrzMr48r9hnIX7ehdNJldc
         JmxiMSp6ds9wQXz+fc6EqS2zn158FZoVnBttRSZ/5NLrs59eIrq1lY0lt9sS5kFIzyVh
         dVno0wtBm8yRAoHN04dEFms0AnfmBbW1aZTtwsn/CE0ThkrVstRqGuw0WJIziyGlrQQl
         Lg7Q==
X-Gm-Message-State: AOAM53399417eD4FsRf7T+1id8ZMiL3PNk3X/mTmrqw3E90TQbIgLlKU
        z3oP/gXVIYd2olKvL8zikQ==
X-Google-Smtp-Source: ABdhPJzx7xBx/olEPIrFDCkTc/pBdbrFue3iMMVdMAx5aXnHNxj2NxgDJOCNkqa35jOsOnNfktnEcg==
X-Received: by 2002:a9d:7245:0:b0:60b:8843:3c7f with SMTP id a5-20020a9d7245000000b0060b88433c7fmr1985816otk.363.1654178255246;
        Thu, 02 Jun 2022 06:57:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a54470d000000b0032603df9d24sm2192550oik.47.2022.06.02.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:57:34 -0700 (PDT)
Received: (nullmailer pid 2200075 invoked by uid 1000);
        Thu, 02 Jun 2022 13:57:34 -0000
Date:   Thu, 2 Jun 2022 08:57:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: Re: [PATCH V5 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l
 bindings
Message-ID: <20220602135734.GA2198822-robh@kernel.org>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220526133359.2261928-7-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526133359.2261928-7-Qing-wu.Li@leica-geosystems.com.cn>
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

On Thu, May 26, 2022 at 01:33:59PM +0000, LI Qingwu wrote:
> Adds the device-tree bindings for the Bosch
> BMI085 and BMI090L IMU, the accelerometer part.
> 
> Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi085-ds001.pdf
> Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BST-BMI090L-DS000-00.pdf

blank line here. These aren't part of the tags.

With that,

Acked-by: Rob Herring <robh@kernel.org>

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> index 911a1ae9c83f..272eb48eef5a 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> @@ -17,7 +17,9 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - bosch,bmi085-accel
>        - bosch,bmi088-accel
> +      - bosch,bmi090l-accel
>  
>    reg:
>      maxItems: 1
> -- 
> 2.25.1
> 
> 
