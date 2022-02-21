Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970DF4BD400
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbiBUCg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:36:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343927AbiBUCgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:36:51 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA77B43AF6;
        Sun, 20 Feb 2022 18:36:28 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id d7so8971414ilf.8;
        Sun, 20 Feb 2022 18:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=okTrvIdz3GnIfJtRIsWGhDUho/L1prgimJXoaYAoKg8=;
        b=YJ2Ed7Z2cEtZPcH0d19AWRpRIZfo285DWXQ7FLjylkTLKkkaTs93mgqxSxUA7wTaki
         6kN/L5UBPEfLbqpw/1lfqErvFWD80HFkachEYLmvgz1Y4qDjEuJYv0E8sxW4CDhfN6Wj
         FZ5uHpWXoKWzjuOyHk2nJdEhh5DZuqGu3trdTXDqfdnmT6w3O0guWY6Xga73PXSjSfhv
         c0Okc4g3f3zkcevoRBO+N9nLGzFSqr7T7U8N1N+hd+3meOVcucjs/+zzsM+FR3berJIx
         6O2+eKIq6nMsjGd4dYX7xBpLBugjmHw7wkGqNktUZBnHHJ6Kj5J8RR0Cpzu9HxB8I3hZ
         k+bA==
X-Gm-Message-State: AOAM530AdulUHPoRr8oyZr7/2syOFxwvnev/koxWGLhg8scfQhqsWse9
        UV3oB05EcXEftzE/D7dwzg==
X-Google-Smtp-Source: ABdhPJw7G16QW3mZskjN26qBK95JxF1Ol6vXqkdIQvYr1acM/QnGofvpQACwFsVGxIzJWu04tQPwqw==
X-Received: by 2002:a92:d3c7:0:b0:2bf:40d4:a87c with SMTP id c7-20020a92d3c7000000b002bf40d4a87cmr14307155ilh.35.1645410988222;
        Sun, 20 Feb 2022 18:36:28 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a18sm4172934ilk.65.2022.02.20.18.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:36:27 -0800 (PST)
Received: (nullmailer pid 2041547 invoked by uid 1000);
        Mon, 21 Feb 2022 02:36:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Jan Kotas <jank@cadence.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        Nishanth Menon <nm@ti.com>
In-Reply-To: <20220219184224.44339-4-krzysztof.kozlowski@canonical.com>
References: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com> <20220219184224.44339-4-krzysztof.kozlowski@canonical.com>
Subject: Re: [RFC PATCH 3/8] dt-bindings: ufs: cdns,ufshc: convert to dtschema
Date:   Sun, 20 Feb 2022 20:36:09 -0600
Message-Id: <1645410969.391228.2041546.nullmailer@robh.at.kernel.org>
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

On Sat, 19 Feb 2022 19:42:19 +0100, Krzysztof Kozlowski wrote:
> Convert the Cadence Universal Flash Storage (UFS) Controlle to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/ufs/cdns,ufshc.txt    | 32 -----------
>  .../devicetree/bindings/ufs/cdns,ufshc.yaml   | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
>  create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ufs/cdns,ufshc.example.dt.yaml: ufs@fd030000: clock-names: ['core_clk', 'phy_clk'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.example.dt.yaml: ufs@4000: clock-names: ['core_clk'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml references a file that doesn't exist: Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml: Documentation/devicetree/bindings/ufs/cdns,ufshc.txt

See https://patchwork.ozlabs.org/patch/1595072

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

