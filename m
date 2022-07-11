Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75870570DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiGKXFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGKXFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:05:32 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F18050C;
        Mon, 11 Jul 2022 16:05:32 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id r76so6334382iod.10;
        Mon, 11 Jul 2022 16:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Y2pixsUn54eay0iSkhajUR21sTD4CQfrtcGskG3AjM=;
        b=acvR40Pi7nln+BoOjNXHkwCgTN1lM5kqBF+9+qWym/91IrzFYbnWlFfU3ZRL/EytEG
         N23bITL2SNzEelTd2LZp17icS1QROxiKjOGPuMetuFswONlODaCt/I3lKhr9lT04uqpY
         TuHUIFzKde6BE/0yT1tplGBquBT8UlIjLxjXbp36qr4YkTPEQP5kBEBRTH3a2+rzQ6ph
         NRMwrm1u/lCZzk8RgGx4x91vVJ2Ni/wilflMiDYJ+d85Pf5NdpcpRBcoqrHexbGVsBUX
         G3VQ+jyMbTzCnmCgIgR7favBEFvHnFewHPd8bNm80MLO5zzU/S77bCLTxMZgSvoFi3WL
         6FsA==
X-Gm-Message-State: AJIora+ni/NfrhQtbDqThI7vA9CT/QbVcRU9Kb5WGMXRtKDzl5URsbL+
        X9D683p8MMW+ocw4CH85lA==
X-Google-Smtp-Source: AGRyM1sh9PvCj46mftGP+Wt7IafcqqmAndX8dkCr0d8snrcsyi9Gkkrf520sbAgPz9fqYCuU0UrMkg==
X-Received: by 2002:a05:6638:3802:b0:32e:3d9a:9817 with SMTP id i2-20020a056638380200b0032e3d9a9817mr12201962jav.206.1657580731375;
        Mon, 11 Jul 2022 16:05:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id cq2-20020a056638478200b0033f5c35704esm1323848jab.54.2022.07.11.16.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:05:30 -0700 (PDT)
Received: (nullmailer pid 436740 invoked by uid 1000);
        Mon, 11 Jul 2022 23:05:29 -0000
Date:   Mon, 11 Jul 2022 17:05:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        claudiu.beznea@microchip.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Message-ID: <20220711230529.GA436676-robh@kernel.org>
References: <20220708115619.254073-1-kavyasree.kotagiri@microchip.com>
 <20220708115619.254073-2-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708115619.254073-2-kavyasree.kotagiri@microchip.com>
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

On Fri, 08 Jul 2022 09:56:17 -0200, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v7 -> v8:
>  - Added back patternProperties for child nodes.
> 
> v6 -> v7:
>  - Change filename to atmel,sama5d2-flexcom.yaml
>  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
> 
> v5 -> v6:
>  - Removed spi node from example as suggested by Rob and
>    also pattern properties(spi dt-bindings conversion to yaml patch is under review).
>    Once that is accepted, I will add back spi example through new patch.
> 
> v4 -> v5:
>  - Fixed indentations.
> 
> v3 -> v4:
>  - Corrected format of enum used for compatible string.
> 
> v2 -> v3:
>  - used enum for compatible string.
>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>  - fixed dtschema errors.
> 
> v1 -> v2:
>  - Fix title.
> 
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 92 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -------------
>  2 files changed, 92 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
