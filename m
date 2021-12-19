Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891C647A281
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhLSV51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:57:27 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:47071 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbhLSV50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:57:26 -0500
Received: by mail-oi1-f172.google.com with SMTP id s139so12971369oie.13;
        Sun, 19 Dec 2021 13:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=3AjklewXqdG1lkYWZ+uYneVSQQ4mjuR7rV0/WxbDbIc=;
        b=kGhlYRdt3ZxSTA9ExD7Ee/aKZE/9nmk8tRHFRJHPZjJWwlR0xodcUHBURKkQlx5h7K
         j/ZF3lbsAp4IvP7r7yy+V3fuLasGOTUf6pOx1le2c9AfgZN3eUKieD72zkbBCNlSxDha
         1F0YtwUUxMnMM42gp2Z2Fz3/Q3q7fNf+Q51gG9tPbz9mI4RKiqU1Dx9oGPM9YQREBvp4
         WfQE7vLu/5EPNI0iaGKSid3ozl4xwz0ZNckBrrm7dshOZu7O18FnY21ib6CRLSh0FEiC
         CyWgGBoJKNQV3SjxMITjkEUyikd1PCtNMRgo04pIN5Nqx8eM9/ubK9EjJZitullACRUG
         J8zw==
X-Gm-Message-State: AOAM532zchiwGLQSsrZH4uSv8+3cOmwaZIWnnvbQint94/6Ynlr8L5nd
        MJ+y6gskBejePnE6WCBQ+Q==
X-Google-Smtp-Source: ABdhPJw+WVWyfOwd110EyY0TN6edT8Ajj5a+WA4SmxByJWkQKr2y1y4aL/QJbbrjvZ0mKLkgv0L7Og==
X-Received: by 2002:a05:6808:699:: with SMTP id k25mr9880760oig.135.1639951045370;
        Sun, 19 Dec 2021 13:57:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t11sm2899395otj.24.2021.12.19.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 13:57:24 -0800 (PST)
Received: (nullmailer pid 2758870 invoked by uid 1000);
        Sun, 19 Dec 2021 21:57:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alex Elder <elder@linaro.org>, ~okias/devicetree@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211218205039.35994-1-david@ixit.cz>
References: <20211218205039.35994-1-david@ixit.cz>
Subject: Re: [PATCH] dt-binding: soc: qcom: convert QCOM SMP2P binding to yaml
Date:   Sun, 19 Dec 2021 15:57:22 -0600
Message-Id: <1639951042.384579.2758869.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 21:50:39 +0100, David Heidelberg wrote:
> Convert Qualcomm SoC SMP2P binding to the yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/soc/qcom/qcom,smp2p.txt          | 110 --------------
>  .../bindings/soc/qcom/qcom,smp2p.yaml         | 139 ++++++++++++++++++
>  2 files changed, 139 insertions(+), 110 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/qcom,ipa.example.dt.yaml: smp2p-mpss: 'qcom,smem' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/qcom,ipa.example.dt.yaml: smp2p-mpss: 'qcom,local-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/qcom,ipa.example.dt.yaml: smp2p-mpss: 'qcom,remote-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/qcom,ipa.example.dt.yaml: smp2p-mpss: 'anyOf' conditional failed, one must be fixed:
	'mboxes' is a required property
	'qcom,ipc' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom-ipcc.example.dt.yaml: smp2p-modem: 'qcom,smem' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom-ipcc.example.dt.yaml: smp2p-modem: 'qcom,local-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom-ipcc.example.dt.yaml: smp2p-modem: 'qcom,remote-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1570617

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

