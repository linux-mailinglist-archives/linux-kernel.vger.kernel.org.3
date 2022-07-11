Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75812570995
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiGKRz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGKRzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:55:23 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567393245D;
        Mon, 11 Jul 2022 10:55:23 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id n68so5642900iod.3;
        Mon, 11 Jul 2022 10:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zQYfTc7ETRTCZIgWWYw80Iww1nESA3imnUOHAbZNink=;
        b=H949EHyA5fsBYfVOmEFwmzi4/D/EhgYB2F9rP3DesqKbpvmVzE6EgAd53uCK0vr4A3
         wwajR6nxBKnWx1Mq3WU+TwEca5hOOir62rkch6i/LHXrxnGSnxefxmRBpTy8PrPE8SU1
         irN8FX4sjdDH4jrbchzk2DFeMSa6xevp2ImsfF/XEPu5I5BoovzuhJOoFmFT6teYUBqX
         ZDVcdPEBvkeDVfTD057jTwiHXOv8hT8l4Syl5IP12f+0J2zNMNAy6t1fwZrpNJ9tuHO2
         yRGgVu0Mav1zSMHZvHn2bYqzc+fjEM2qtOeLGL8dyAVIpG2rUN7NYo+i1q7kf/sA1CjK
         3iLg==
X-Gm-Message-State: AJIora94nvrBDE/F4cR6j2Q21mtpAcvIuUk5YsxwQFkcvFO7EpdU8N04
        Pn2OlkdXckpSHsthStCGC+AKC39XTA==
X-Google-Smtp-Source: AGRyM1uE9R2fPsn1VUU8DOTLoa3jlkmDcdWazULz/mhKIHwM2a2Mr0Dxk1I9Ka1+ZBiBywhlw3BqfQ==
X-Received: by 2002:a05:6638:1651:b0:33c:a8d2:71a6 with SMTP id a17-20020a056638165100b0033ca8d271a6mr11256299jat.165.1657562121188;
        Mon, 11 Jul 2022 10:55:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z17-20020a056638215100b0033eda79403bsm3170853jaj.9.2022.07.11.10.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:55:20 -0700 (PDT)
Received: (nullmailer pid 4172124 invoked by uid 1000);
        Mon, 11 Jul 2022 17:55:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     zhengbin13@huawei.com, j.neuschaefer@gmx.net, yuenn@google.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        tali.perry1@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, avifishman70@gmail.com, lars@metafoo.de,
        benjaminfair@google.com, jic23@kernel.org,
        openbmc@lists.ozlabs.org, venture@google.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220711134312.234268-2-tmaimon77@gmail.com>
References: <20220711134312.234268-1-tmaimon77@gmail.com> <20220711134312.234268-2-tmaimon77@gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: npcm: Add npcm845 compatible string
Date:   Mon, 11 Jul 2022 11:55:19 -0600
Message-Id: <1657562119.172361.4172123.nullmailer@robh.at.kernel.org>
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

On Mon, 11 Jul 2022 16:43:10 +0300, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 ADC.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml     | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.example.dtb: adc@f000c000: compatible: 'oneOf' conditional failed, one must be fixed:
	['nuvoton,npcm750-adc'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

