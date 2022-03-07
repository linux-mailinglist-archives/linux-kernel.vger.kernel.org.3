Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E294CF029
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiCGDZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCGDZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:25:37 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A44C401;
        Sun,  6 Mar 2022 19:24:44 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so16233653ooi.0;
        Sun, 06 Mar 2022 19:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=d+wQHvIVygqyBwtniWZR0uvXCr9KYxfN8+WYYAjCuSc=;
        b=GHl0L8oj30HHwTuJp1juEp9o5vW89uMhXgBD/ROK5yESWSR5Q1hnVv7bAlf/IRJhO+
         qqLBHaSRYT76yM4OiIFot4nhZwkExcpvI1BaLn5PTrFOfm1X7lMmiihSwCdXY2JSPMXv
         bg+s37LKPOHv2RqDuD9Ib10rRes0ysnr2EMsxECTIDL2oUzyq9y3GEU7i5sXk5CqYrfs
         goqmJ/f/T+c8/rWcOwG7h+j6ex5PTxuOEIM6F+9+lHMAcnIzsQ8aM6+HV2maL2dFu/aJ
         +y3GBzSktWw21DF5oMLh6OdPrNCbQ19gtbUfDGrO/UW3aNfhwEuuspLEv/MBgB+GPUAS
         sSPw==
X-Gm-Message-State: AOAM530lvFeTEwirctm2SZnEF8VJcWHu6zjqlYeY+augyoo/3XZVZDBY
        tl+oCuyD/MjU+By1oF0p0w==
X-Google-Smtp-Source: ABdhPJyo+cVwfftoH3b/RmqIsCrh9wn28oxnbtJzcd9pD8qcd3HGAHqGVSVU1h18cO8sKLG5SldA8A==
X-Received: by 2002:a05:6870:6085:b0:d9:a258:df59 with SMTP id t5-20020a056870608500b000d9a258df59mr13560336oae.90.1646623483719;
        Sun, 06 Mar 2022 19:24:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f188-20020a4a58c5000000b0031ccb8272f1sm5367939oob.33.2022.03.06.19.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:24:43 -0800 (PST)
Received: (nullmailer pid 1496444 invoked by uid 1000);
        Mon, 07 Mar 2022 03:24:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>, Jan Kotas <jank@cadence.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Li Wei <liwei213@huawei.com>, linux-kernel@vger.kernel.org,
        Stanley Chu <stanley.chu@mediatek.com>
In-Reply-To: <20220306111125.116455-4-krzysztof.kozlowski@canonical.com>
References: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com> <20220306111125.116455-4-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 03/12] dt-bindings: ufs: cdns,ufshc: convert to dtschema
Date:   Sun, 06 Mar 2022 21:24:40 -0600
Message-Id: <1646623480.209864.1496443.nullmailer@robh.at.kernel.org>
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

On Sun, 06 Mar 2022 12:11:16 +0100, Krzysztof Kozlowski wrote:
> Convert the Cadence Universal Flash Storage (UFS) Controlle to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/ufs/cdns,ufshc.txt    | 32 ---------
>  .../devicetree/bindings/ufs/cdns,ufshc.yaml   | 68 +++++++++++++++++++
>  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml |  7 +-
>  3 files changed, 71 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
>  create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ufs/cdns,ufshc.example.dt.yaml: ufs@fd030000: freq-table-hz: 'anyOf' conditional failed, one must be fixed:
	[[0, 0], [0, 0]] is too long
	[0, 0] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/property-units.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1601674

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

