Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E984B47F37D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhLYOtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:49:00 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:34744 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhLYOsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:48:52 -0500
Received: by mail-qv1-f46.google.com with SMTP id ke6so10029225qvb.1;
        Sat, 25 Dec 2021 06:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Qsnbtl5TIcmZmqxLDymCjbWs59/KyNv5D5IkyU1n0AU=;
        b=vg5U+sz4rCD4/TlglSLBBXbZtUn37lQJ+R25HJwOlZq9JIJZ/7RAQgmfuSgX8/40ju
         3d4SXLKUJsIhC/OCsyFJWiDQdQniItg9AbO9jpNzW6gayI+5qChsYYpCtmyZ8cDDxv09
         aj3opHokBgM2w5xufqDBRurX1u+duKx66oaDrUy9OX1H+S5/bGmdokjSdcep4OutycOI
         dWeRod/TYu1x3xMO+xK+C4LviqWxE9wZVAhUjqQCq/8HwGs5+IConnEqRqAsmDDCa1iq
         Cy4bFP6hTevpxEfUOkaTOHOJzpMzrRz1ytNmkG81TBz+DtsDpHAdmjeTnTerURPH10VB
         u1RQ==
X-Gm-Message-State: AOAM5338AcwTePjFlZVUtKwvTb/I3DWxd8KGeQTIqSJhicQcew7U1gdz
        OrXbwEhYIlMxlYhgI0Z8pg==
X-Google-Smtp-Source: ABdhPJwJgoLi0RNO++5bjNzVyf1UGhEkAqQg5RIYL5IIYHFZV7ZTNMEU0IFW3Oh0cT2hJMlLWBJOYg==
X-Received: by 2002:a05:6214:2aa1:: with SMTP id js1mr9229788qvb.27.1640443731505;
        Sat, 25 Dec 2021 06:48:51 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id a38sm8788129qkp.80.2021.12.25.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 06:48:50 -0800 (PST)
Received: (nullmailer pid 363341 invoked by uid 1000);
        Sat, 25 Dec 2021 14:48:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht
In-Reply-To: <20211224163344.54177-2-david@ixit.cz>
References: <20211224163344.54177-1-david@ixit.cz> <20211224163344.54177-2-david@ixit.cz>
Subject: Re: [PATCH 2/2] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to yaml
Date:   Sat, 25 Dec 2021 10:48:42 -0400
Message-Id: <1640443722.898852.363340.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 17:33:44 +0100, David Heidelberg wrote:
> Convert Qualcomm PMIC SPMI binding to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> Patches for fixing dt-schema warnings for SDX55 and MSM8998 qcom,spmi
> already sent to ML.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 118 ++++++++++++++++++
>  2 files changed, 118 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.example.dts:20.14-38.11: Warning (unit_address_vs_reg): /example-0/spmi: node has a reg or ranges property, but no unit name
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.example.dt.yaml: spmi: $nodename:0: 'spmi' does not match '^spmi@.*'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.example.dt.yaml: spmi: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt references a file that doesn't exist: Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt: Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt

See https://patchwork.ozlabs.org/patch/1573075

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

