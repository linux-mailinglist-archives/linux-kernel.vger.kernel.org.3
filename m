Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706924D26C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiCICCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiCICB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:01:57 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12747484D;
        Tue,  8 Mar 2022 18:00:59 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id q189so1222441oia.9;
        Tue, 08 Mar 2022 18:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mWEHy9bniNne88jJU8uXaag3F19iRbd78liIzCE7PTs=;
        b=ddi9ispAXoGWt9SPQpJVk8H3SOBi4t1euf2iB68q2gk6vED9c/ql+wSH1lwAt5cxwa
         sd7bpfB/Cp1rYqHqS9kMaRRNjaA1c4klatCuPl5wtZvJMraYGzIDW+KkfPtyZ1Gnlq8v
         Gfe7KW8hvPvafVecVxDTJASlT6YvJl7TJIpJEQyV4ZLFSJ5e5eYbW2dAvbi27IyxbUli
         cekVQ7GmnlsSzBkGHLrXwgg1rzFah3KIRQBCjIbDzSmZAJztjexE3mD5XhzBYDtcRjch
         6DCUbawECJNz8LJUBY1AFdOEjE/Pcw0gfr5SVr8tLejtR9iIH8hYsqKg5t56RmjQxpNK
         EcYg==
X-Gm-Message-State: AOAM533ONdah7Ii15az6JnAjw2zUBXqYU9QOheiFSQxOZJvdiLqQPlad
        Pm1vTVKmRhkjh+Eir/jqHA==
X-Google-Smtp-Source: ABdhPJyP4NIvcuJfaHjGGoZ6i+F9U7s3CMH3FV08j2d4EMWj+LpBXTOaiaseboj4DN2mhj42qVnlzQ==
X-Received: by 2002:a05:6808:1201:b0:2d9:a01a:48b8 with SMTP id a1-20020a056808120100b002d9a01a48b8mr4473119oil.259.1646791258942;
        Tue, 08 Mar 2022 18:00:58 -0800 (PST)
Received: from rob (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v37-20020a056830092500b005b1f7daf40asm241123ott.75.2022.03.08.18.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 18:00:58 -0800 (PST)
Received: (nullmailer pid 1765443 invoked by uid 1000);
        Wed, 09 Mar 2022 02:00:56 -0000
Date:   Tue, 8 Mar 2022 19:00:56 -0700
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 00/12] dt-bindings: ufs: add common platform bindings
 + fixes
Message-ID: <20220309020056.GA1764427@robh.at.kernel.org>
References: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
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

On Sun, Mar 06, 2022 at 12:11:13PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> Not tested on hardware, so please kindly test.
> Bindings maintainers might need checking - taken from git log.
> 
> Changes since v2
> ================
> 1. Do not deprecate freq-table-hz, but instead update dtschema to accept
>    uint32-matrix. See:
>    https://github.com/devicetree-org/dt-schema/pull/69
> 2. Drop patches and changes related to freq-table-hz -> freq-table conversion.
> 3. Add tags.
> 4. Change maintainer of qcom,ufs.
> 
> Changes since v1
> ================
> 1. Make freq-table as matrix of tuples (Nishanth).
> 2. New patches: convert all bindings and fix up DTS files.
> 3. Several minor fixes in UFS bindings.
> 
> Dependencies
> ============
> None dependencies. The DTS patches can go independently via respective
> maintainers. The dt-bindings patches could go via UFS tree.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (12):
>   dt-bindings: ufs: add common platform bindings
>   dt-bindings: ufs: samsung,exynos-ufs: use common bindings
>   dt-bindings: ufs: cdns,ufshc: convert to dtschema
>   dt-bindings: ufs: drop unused/old ufs-qcom PHY bindings
>   dt-bindings: ufs: qcom,ufs: convert to dtschema
>   dt-bindings: ufs: hisilicon,ufs: convert to dtschema
>   dt-bindings: ufs: mediatek,ufs: convert to dtschema
>   dt-bindings: ufs: snps,tc-dwc-g210: convert to dtschema

Patches 1-8 applied.

Rob

>   arm64: dts: hisilicon: align 'freq-table-hz' with dtschema in UFS
>   arm64: dts: qcom: msm8996: drop unsupported UFS
>     vddp-ref-clk-max-microamp
>   arm64: dts: qcom: msm8996: correct UFS compatible
>   arm64: dts: qcom: sm8350: drop duplicated ref_clk in UFS
> 
>  .../devicetree/bindings/ufs/cdns,ufshc.txt    |  32 ---
>  .../devicetree/bindings/ufs/cdns,ufshc.yaml   |  68 +++++
>  .../bindings/ufs/hisilicon,ufs.yaml           |  90 +++++++
>  .../devicetree/bindings/ufs/mediatek,ufs.yaml |  67 +++++
>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 242 ++++++++++++++++++
>  .../bindings/ufs/samsung,exynos-ufs.yaml      |  13 +-
>  .../bindings/ufs/snps,tc-dwc-g210.yaml        |  51 ++++
>  .../bindings/ufs/tc-dwc-g210-pltfrm.txt       |  26 --
>  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml |   7 +-
>  .../devicetree/bindings/ufs/ufs-common.yaml   |  82 ++++++
>  .../devicetree/bindings/ufs/ufs-hisi.txt      |  42 ---
>  .../devicetree/bindings/ufs/ufs-mediatek.txt  |  45 ----
>  .../devicetree/bindings/ufs/ufs-qcom.txt      |  63 -----
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  90 -------
>  MAINTAINERS                                   |   1 +
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |   4 +-
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   4 +-
>  .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |   1 -
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |   3 +-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi          |   3 -
>  20 files changed, 614 insertions(+), 320 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
>  create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
>  create mode 100644 Documentation/devicetree/bindings/ufs/hisilicon,ufs.yaml
>  create mode 100644 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>  create mode 100644 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>  create mode 100644 Documentation/devicetree/bindings/ufs/snps,tc-dwc-g210.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ufs/tc-dwc-g210-pltfrm.txt
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>  delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-mediatek.txt
>  delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-qcom.txt
>  delete mode 100644 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> 
> -- 
> 2.32.0
> 
> 
