Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D037553D1A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347591AbiFCSgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347800AbiFCSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:36:16 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7012AD9;
        Fri,  3 Jun 2022 11:30:06 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso6094064otp.8;
        Fri, 03 Jun 2022 11:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=asnSyF8/mpAZrPq7zWDU4GFbPGrqRhvj/yeUHzRFYZ8=;
        b=JWiYpIvThoNpdAtwS4zINXtFuLI/A6hDDiqZ20AyOB1UkuX0LMP6R6bhj7RKlyv5Yn
         9PiZ9FufdMu58w0bsA2mpTZcpn2TROdikFLUEHiQqllaq3VWXL2U9oR9MvruWOMlPTCe
         DHa9kMyLzHvDbuHWqBt4agWYnsRdQdMY9Soj2HC8zQ3voyLTBpQPCL8C71RnaW8lChVJ
         eQQfpB/dau9H+GyFAMqrZqNgV19bJm0xRpwD6SbIozAtAOjM4ZQkjqlk9IoSc3UMNCP+
         Brs84uZKunxKw9A/zhKsn0bY28gKnBkk1oxehpL22BoFY5Gz7QfUNNG+V9UBI1tC/45O
         2Q1A==
X-Gm-Message-State: AOAM530S06/bKk59jUB0ENyekRVP7esssCQame+BMhpYCiJhbgkzedNZ
        G04GL/cg45ekP1lNtXngDC6khtFGcQ==
X-Google-Smtp-Source: ABdhPJwBCtWWCMBC2XiB+cXeV5iJmot0yDdbL/HPwg/J+Vl2LGxsRCbH09vUQX6uMUZZ+9aARYN5hg==
X-Received: by 2002:a05:6830:1af0:b0:60b:2242:f266 with SMTP id c16-20020a0568301af000b0060b2242f266mr4822951otd.108.1654281005253;
        Fri, 03 Jun 2022 11:30:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay31-20020a056808301f00b00328c9e63389sm4524068oib.11.2022.06.03.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:30:04 -0700 (PDT)
Received: (nullmailer pid 680138 invoked by uid 1000);
        Fri, 03 Jun 2022 18:30:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-samsung-soc@vger.kernel.org
In-Reply-To: <20220603094946.509919-4-krzysztof.kozlowski@linaro.org>
References: <20220603094946.509919-1-krzysztof.kozlowski@linaro.org> <20220603094946.509919-4-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/3] dt-bindings: mmc: samsung,exynos-dw-mshc: convert to dtschema
Date:   Fri, 03 Jun 2022 13:30:04 -0500
Message-Id: <1654281004.017781.680137.nullmailer@robh.at.kernel.org>
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

On Fri, 03 Jun 2022 11:49:46 +0200, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos SoC specific extensions to the Synopsys
> Designware Mobile Storage Host Controller to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mmc/exynos-dw-mshc.txt           |  94 ----------
>  .../bindings/mmc/samsung,exynos-dw-mshc.yaml  | 162 ++++++++++++++++++
>  2 files changed, 162 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.example.dtb:0:0: /example-0/mmc@12200000: failed to match any schema with compatible: ['samsung,exynos5420-dw-mshc-smu']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

