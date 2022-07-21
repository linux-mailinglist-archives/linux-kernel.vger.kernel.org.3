Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40EB57CDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiGUOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiGUOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:39:07 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7698569F19;
        Thu, 21 Jul 2022 07:39:06 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id u19so886426ilk.7;
        Thu, 21 Jul 2022 07:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Sm3tlB8yJNkvcnmGZzguj4nSasaetiaq3D0mjYCkJN0=;
        b=Q+eziC9iHTKY7L9tORcfEVBuY4F4+cz9TXxFH3Ca/FpZ7c3MoS+3uYkxVzXTFpUvHF
         OR2WhE5Nk5gkuM9ipIdZAcvLMl46EfxhhP0gsQV8oeA/D9YhF6TbcyFydOu0zX3dU9jr
         nLZTWIC8O6u8cPXH6l9cZaqiLeEsNwlw3DpCObIl2DGDhAdHE2x7BlDnJeh34zR9bNyQ
         T8CszXIEze6+twnayFszqSSR4CpDXlHo7TuErrKNKC4QWiR1Ul+g8BD/5Y02AO93iWF1
         vlpxAG1Jvn0uHAHnAntUPg+kcwR6E7xxgEGT6a5byg5TNTgeOGpafibuiiWLDAn+MxhI
         vKSw==
X-Gm-Message-State: AJIora/QTLjhn5Fx/sQm7AwHUN/FF0yDhsLYkwn7CA+QGE8XPucyG+2x
        fmexFgFkKvKPz7GsgUaNrg==
X-Google-Smtp-Source: AGRyM1s3RgA4RPtEqdms0tt8gKlUtsmi8LztDesM8l1Pi2YyOtRfdM8vD2mP/jx42IXRMbzL8n5HqQ==
X-Received: by 2002:a05:6e02:1a49:b0:2dc:7230:29fd with SMTP id u9-20020a056e021a4900b002dc723029fdmr21805427ilv.82.1658414345707;
        Thu, 21 Jul 2022 07:39:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i2-20020a6bb802000000b0067bcb28e036sm911054iof.49.2022.07.21.07.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 07:39:05 -0700 (PDT)
Received: (nullmailer pid 1363458 invoked by uid 1000);
        Thu, 21 Jul 2022 14:39:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     devicetree@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        verdun@hpe.com, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        joel@jms.id.au, arnd@arndb.de
In-Reply-To: <20220720201158.78068-3-nick.hawkins@hpe.com>
References: <20220720201158.78068-1-nick.hawkins@hpe.com> <20220720201158.78068-3-nick.hawkins@hpe.com>
Subject: Re: [PATCH v1 2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
Date:   Thu, 21 Jul 2022 08:39:02 -0600
Message-Id: <1658414342.342423.1363457.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 15:11:55 -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the hpe,gxp-spifi binding to support access to
> the SPI parts
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/spi/hpe,gxp-spifi.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.example.dtb: spi@200: Unevaluated properties are not allowed ('interrupt-parrent' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

