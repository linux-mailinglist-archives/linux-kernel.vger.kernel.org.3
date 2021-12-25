Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0200547F386
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhLYOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:49:05 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:40841 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbhLYOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:48:59 -0500
Received: by mail-qk1-f175.google.com with SMTP id w27so4454856qkj.7;
        Sat, 25 Dec 2021 06:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WwY+LxRGYjmGy4RNrns234zbmxymS+OanKyxEXrqH0s=;
        b=j3oyBfzWHCUuMt6e9PKFVCsK8OIKYxQiy6cKojwzw5LbzygVDuH2slgwRHM3GtzSDv
         ZLDdnuzm7HSSq7g7OBhr0yivE6qG+Yjy/nh6KK3LJRFogWSl8gmTVO35GYxMdAZyd+zJ
         r0AXmzfqHpelZfIEs8aBOp8Kr65sx3Ws25RRf1Ln37lWtjJzYbdhP0ptNZQXd0yzzwzC
         OrBLPj162s/l23NPXEQO4dbLnvR/KnE5HeQou/OjjVt/dJlKwpdszSKaOVQ3AoxE4A3b
         05jdHLJyKU6/6VeFk1SDF4KkKmTIUANtYgUk/Oo2MqOze2eSNJSrj8aNwTiz7zo1qZdx
         +uKQ==
X-Gm-Message-State: AOAM533d1tW/hUyREeYyfbhbbkWQPPoT10NLUR4hyjBxEVaCXm54JdBa
        TBXmvwoMHQtrcdTOZhWS7QvBiz4BYWxY
X-Google-Smtp-Source: ABdhPJz2jdWWd9BmP30Ev0PdnQc4+holyBZlfI1eeuU3s9w4SZsAkposD7j9PHDAyPUIfts91rRKUw==
X-Received: by 2002:a05:620a:948:: with SMTP id w8mr7409911qkw.475.1640443738482;
        Sat, 25 Dec 2021 06:48:58 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id q21sm3743646qtw.26.2021.12.25.06.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 06:48:57 -0800 (PST)
Received: (nullmailer pid 363343 invoked by uid 1000);
        Sat, 25 Dec 2021 14:48:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux-foundation.org
In-Reply-To: <20211224165014.56308-1-david@ixit.cz>
References: <20211224165014.56308-1-david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Date:   Sat, 25 Dec 2021 10:48:42 -0400
Message-Id: <1640443722.906705.363342.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 17:50:14 +0100, David Heidelberg wrote:
> Convert Qualcomm IOMMU v0 implementation to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/iommu/msm,iommu-v0.txt           | 64 -------------
>  .../bindings/iommu/qcom,iommu-v0.yaml         | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iommu/qcom,iommu-v0.yaml#
Documentation/devicetree/bindings/iommu/qcom,iommu-v0.example.dts:37.26-43.11: Warning (unit_address_vs_reg): /example-0/mdp@5100000: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/iommu/qcom,iommu-v0.example.dt.yaml:0:0: /example-0/mdp@5100000: failed to match any schema with compatible: ['qcom,mdp4']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1573077

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

