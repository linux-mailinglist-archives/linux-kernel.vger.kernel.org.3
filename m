Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C447A284
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhLSV53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:57:29 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41917 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbhLSV51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:57:27 -0500
Received: by mail-oi1-f172.google.com with SMTP id u74so13018933oie.8;
        Sun, 19 Dec 2021 13:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sttv/EA7PrsQgrOqTzB8nOb79Z+7Ua5Vx6UxIayQWdE=;
        b=Z+mlMW20InCaa62JFnLfUoCxqQ18I5xBwcQimJG9aHtbBmhqEWypRIRd7cN2ayo0mw
         a2e0PxYj0ysPDvwRlQglVWlqSUA3zUSfDPgyuaWH0QlZCRDTcJ96RV/sJ479SSvgoc7u
         zDExuT3Wi2MjCkNqs4ajXTqljQe1VIkoKO335mVCdbK6UKCpQoqYk9Er+3/zEczWPj1M
         ta20Fy1D+nER4GEr8GwVYSInPSSJ0lOOpwLJ/z7eUm03/1OSIX8eIOx2aM0CN6jSby1S
         9Lqizhy8rFneqMq+kLp1Ue1BnsGYjHUJ7X9a5Kne5vk0AO7OGDZ9njC1N1r8wOtJRpBI
         7QOA==
X-Gm-Message-State: AOAM533CsyQ94u1HOyVTh0klRzp+y/nV55KMibDKqSA0TkQyGlduTrHC
        3a2C3k/WROlQFlSxSkChug==
X-Google-Smtp-Source: ABdhPJxYlNf3l6AjSRh/ORzZfO4itsWz3W119drXINODUkiTDOKYdi0HkNgJGUpbY4BeNXui/K/RNw==
X-Received: by 2002:a54:4789:: with SMTP id o9mr15734816oic.74.1639951047023;
        Sun, 19 Dec 2021 13:57:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bc7sm2914376oob.35.2021.12.19.13.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 13:57:26 -0800 (PST)
Received: (nullmailer pid 2758872 invoked by uid 1000);
        Sun, 19 Dec 2021 21:57:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-arm-msm@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211218213556.42061-1-david@ixit.cz>
References: <20211218213556.42061-1-david@ixit.cz>
Subject: Re: [PATCH] RFC: dt-bindings: soc: qcom: convert GLINK binding to yaml
Date:   Sun, 19 Dec 2021 15:57:22 -0600
Message-Id: <1639951042.393594.2758871.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 22:35:56 +0100, David Heidelberg wrote:
> Convert Qualcomm GLINK binding to the yaml syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/soc/qcom/qcom,glink.txt          |  94 ----------------
>  .../bindings/soc/qcom/qcom,glink.yaml         | 106 ++++++++++++++++++
>  2 files changed, 106 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dt.yaml: rpm-glink: compatible: ['qcom,glink-rpm'] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dt.yaml: rpm-glink: interrupts: [[0, 168, 1]] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dt.yaml: rpm-glink: qcom,rpm-msg-ram: [[4294967295]] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dt.yaml: rpm-glink: mboxes: [[1, 0]] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dt.yaml: rpm-glink: mbox-names: ['rpm_hlos'] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dt.yaml: rpm-glink: $nodename: ['rpm-glink'] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dt.yaml: rpm-glink: 'qcom,smem' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dt.yaml: rpm-glink: 'qcom,local-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dt.yaml: rpm-glink: 'qcom,remote-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.example.dt.yaml: rpm-glink: compatible: ['qcom,glink-rpm'] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.example.dt.yaml: rpm-glink: interrupts: [[0, 168, 1]] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.example.dt.yaml: rpm-glink: qcom,rpm-msg-ram: [[4294967295]] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.example.dt.yaml: rpm-glink: mboxes: [[4294967295, 0]] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.example.dt.yaml: rpm-glink: $nodename: ['rpm-glink'] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.example.dt.yaml: rpm-glink: 'qcom,smem' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.example.dt.yaml: rpm-glink: 'qcom,local-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.example.dt.yaml: rpm-glink: 'qcom,remote-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,glink.example.dt.yaml: rpm-requests: 'qcom,glink-channels', 'qcom,intents' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1570646

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

