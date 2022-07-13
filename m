Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D515738CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiGMO1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiGMO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:26:57 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63933E33;
        Wed, 13 Jul 2022 07:26:57 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id n9so6757099ilq.12;
        Wed, 13 Jul 2022 07:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QKgI9ZpnX7ox+lTRdDiK7O4AjR5dZXb8A4bq5EkelDc=;
        b=QxJRsMT84Kh06eDzim99tGoS++WCq0BVYs7kqkiZFpMDPIx1IHeTs7fZrkTuGD4qTg
         +LuhnQ4NpU4yrMeJ+Znm2FuiN8XF3QRPPvfxJCAQ5H2j1bRN481HZ0XbgDl3PJgl40YV
         WWr7cUr835TruulK5y5ezGvxPOr5qAM7iiYZNiDaKcKgJ4hN1xWSbLyVYVOoBuT/c5NQ
         eLIrmsO4+edqB3201TYkWLpxSL7h5Ga9r6PgMM/ZXN6uV0v8gmMDm+c2EHgqDQ8aR87N
         i8/F9dhDJJphb+YhdKXPW8Ym0vpNJ65tF9AiHsW+DYL101N9UUNMWHXwuDYxGPyp9Fg8
         h7FQ==
X-Gm-Message-State: AJIora/v60P/m7JoNhtLKib1wpuNqdHaZxBqtbH6WzHCDdoCESF89nyr
        7iN+rxkMKW3HvsOPmzehqA==
X-Google-Smtp-Source: AGRyM1vBg90EZr6PLBg3MqzFgvAbq8xWowl++SsqRRwnw8yerxpLhSKPtrsOIet+Y/fUOMaMYj56vQ==
X-Received: by 2002:a05:6e02:2163:b0:2dc:3d9f:7723 with SMTP id s3-20020a056e02216300b002dc3d9f7723mr1951134ilv.1.1657722416042;
        Wed, 13 Jul 2022 07:26:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y4-20020a920904000000b002cc20b48163sm616953ilg.3.2022.07.13.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:26:55 -0700 (PDT)
Received: (nullmailer pid 3904431 invoked by uid 1000);
        Wed, 13 Jul 2022 14:26:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dongjin Yang <dj76.yang@samsung.com>
Cc:     "lars.persson@axis.com" <lars.persson@axis.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wangseok Lee <wangseok.lee@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "javierm@redhat.com" <javierm@redhat.com>
In-Reply-To: <20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p3>
References: <CGME20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p3> <20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p3>
Subject: Re: [PATCH 3/4] dt-bindings: mfd: Add bindings for Samsung SysMgr
Date:   Wed, 13 Jul 2022 08:26:54 -0600
Message-Id: <1657722414.259495.3904430.nullmailer@robh.at.kernel.org>
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

On Wed, 13 Jul 2022 13:56:28 +0900, Dongjin Yang wrote:
> Add an devicetree binding for Samsung system manager.
> This driver is used for SoCs produced by Samsung Foundry to provide
> Samsung sysmgr API. The read/write request of sysmgr is delivered to
> Samsung secure monitor call.
> 
> Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
> ---
>  .../devicetree/bindings/mfd/samsung,sys-mgr.yaml   | 42 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/mfd/samsung,sys-mgr.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.example.dtb: syscon_imem@10020000: reg: [[0, 268566528], [0, 4096]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.example.dtb: syscon@16c20000: reg: [[0, 381812736], [0, 4096]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

