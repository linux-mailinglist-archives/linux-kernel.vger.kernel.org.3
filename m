Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CCE4F1BF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382036AbiDDVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378965AbiDDQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:11:00 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F79DF52;
        Mon,  4 Apr 2022 09:09:02 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so7539862otk.8;
        Mon, 04 Apr 2022 09:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cJKsE7JJ9CtwSVyO3do4jJEmXMn0p28LOdCOaIAoMXE=;
        b=nOw+CJxlMvhPfjyQtCIpHW/XSgAJUvp6RFo2YTOWMFGnZxhs4baTcWsTajFSxjW/HR
         oyWbmznw3b8c7POgVPUoN+B/PeJ0kKwvaLWgZt2MLMVAjH4VDlSKMsHJRMERppW/deUs
         9BKJaS/gyjB3FG29AxEeeuBi78rXxbDUXblxCS0ak4N0yetJ5jyZ0GF9Vwdh0Eg4VOIl
         1XAhdHD0IhtVofhyOa2bhTRINV1v//E0szvOtej8S9hX6Z+p0p1q3gvQBYHC1VNqYFRP
         n/xhfoodkY+G/H/GvC5BhVXTFsLe0A5nmVb45oDCUaQevyI6EwVslK4Sjd8IYRAVm/4f
         p3Rg==
X-Gm-Message-State: AOAM533Dh6QNh1xgEGG4BmKVPuQUe6W//AMcPWZpQpmJoq2BGTwABBA9
        jO3ciB8zijGFpp+ILXhJ4Q==
X-Google-Smtp-Source: ABdhPJwLfX+tD9cyTfa2GD8KrJbLwA7u4qe+vnD2aFBYxhzwS3ADjJn1XIw9pR+zvQnZxZYH8flVsA==
X-Received: by 2002:a05:6830:2010:b0:5b2:38da:6c24 with SMTP id e16-20020a056830201000b005b238da6c24mr93175otp.158.1649088542261;
        Mon, 04 Apr 2022 09:09:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b000ccfbea4f23sm4633163oae.33.2022.04.04.09.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:09:01 -0700 (PDT)
Received: (nullmailer pid 1436948 invoked by uid 1000);
        Mon, 04 Apr 2022 16:08:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     devicetree@vger.kernel.org, jonathanh@nvidia.com,
        ksitaraman@nvidia.com, bbasu@nvidia.com,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        sanjayc@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rafael@kernel.org, krzk+dt@kernel.org
In-Reply-To: <20220404121713.22461-2-sumitg@nvidia.com>
References: <20220404121713.22461-1-sumitg@nvidia.com> <20220404121713.22461-2-sumitg@nvidia.com>
Subject: Re: [Patch v3 1/4] dt-bindings: Document Tegra CCPLEX Cluster
Date:   Mon, 04 Apr 2022 11:08:58 -0500
Message-Id: <1649088538.036927.1436947.nullmailer@robh.at.kernel.org>
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

On Mon, 04 Apr 2022 17:47:10 +0530, Sumit Gupta wrote:
> The Tegra CPU COMPLEX CLUSTER area contains memory-mapped
> registers that initiate CPU frequency/voltage transitions.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.example.dt.yaml: example-0: ccplex@e000000:reg:0: [0, 234881024, 0, 393215] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

