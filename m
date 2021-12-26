Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2A47F97F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 00:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhLZXeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 18:34:12 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:35465 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbhLZXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 18:34:11 -0500
Received: by mail-qv1-f48.google.com with SMTP id kj16so12598370qvb.2;
        Sun, 26 Dec 2021 15:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8OhGi6EGIeTbm2FKcIqH7Qd4g6ZrEXd1zPKC9lCtv0M=;
        b=TFpb60hhOZMoof54hkXBfiSp6UthCrFd5cfsxhjG1HsXoRB6XhTSB5NHshy12Ss6wD
         Jil/JoZA3lQt1U6LUkZ8wPyI3HxmcjwR7MPj4XXE59LERLwUFM3R+GL8q2xFd37mubGe
         LSoawx8+IDsHInhCDEBE98SEMqWsIOeKMgZI0Umeij07mlMWBv9oZSQh7F9saiHAbWjc
         znHVWy5c3rfD2fJlSE6EcY5NuBVOZVi0gw1xJBngDdKoAPfsW6ryTLO2h3x9DvWJO3lp
         o4PO8gqfspATxZBi4KI2TcGuSwLiSehYuuKxBq3KoDib16OV8mOJezZ6lIYt9kf9XyMo
         GkQQ==
X-Gm-Message-State: AOAM530ywmrFyCVLMwip8A3uDDilF5yGhoIMYnCscHM124VAUPaWas9n
        J+s9eN4JlHnSbsreI6gYdw==
X-Google-Smtp-Source: ABdhPJxcSpSE43CPWv5wSNJRAv4nGCBAoUgZFhPXwuP6AUqXs71Km3TG65zjjNeIPIvsEdKjZxRUMA==
X-Received: by 2002:a0c:fec6:: with SMTP id z6mr13591955qvs.40.1640561650426;
        Sun, 26 Dec 2021 15:34:10 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id 137sm10434630qkm.69.2021.12.26.15.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 15:34:09 -0800 (PST)
Received: (nullmailer pid 393570 invoked by uid 1000);
        Sun, 26 Dec 2021 23:34:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht, Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20211225191856.64587-1-david@ixit.cz>
References: <20211225191856.64587-1-david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to yaml
Date:   Sun, 26 Dec 2021 19:34:07 -0400
Message-Id: <1640561647.349260.393569.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2021 20:18:55 +0100, David Heidelberg wrote:
> Convert Qualcomm PMIC SPMI binding to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> v2:
>  - add #address and #size-cells
>  - add reg and remove spmi include from example
> 
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 120 ++++++++++++++++++
>  2 files changed, 120 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.example.dt.yaml: spmi@fc4cf000: reg: [[4232900608, 4096], [4232884224, 4096], [4232880128, 4096]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/spmi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.example.dt.yaml: spmi@fc4cf000: reg: [[4232900608, 4096], [4232884224, 4096], [4232880128, 4096]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt: Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt

See https://patchwork.ozlabs.org/patch/1573180

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

