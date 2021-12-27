Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5948019F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhL0Q2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:28:53 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:36480 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhL0Q2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:28:52 -0500
Received: by mail-qv1-f42.google.com with SMTP id kc16so14209039qvb.3;
        Mon, 27 Dec 2021 08:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Er6OiH46JkhhpWfZTRGgyrNnzaITO7Ijpc7smf62qC0=;
        b=rHhXv++8grdn9epGea+iYb60NGcqDcheF3pq8KctTmM26m2kXHdVjG0rfF7wQTx8Gr
         nMqo5f8i3DAbqhy7M9Ldqp5tRTLP8mek63lvX3C+X80fA5SYW4tCz+eDGdIet65L/7qU
         tXrXDmS3jutJcHn05E9qnwgVKva/kFhd7OrWSaC4J1V6NoG2HuzY3R28AzHPT8E+nHm8
         ZIenn6Qrg1UL/JJPX1TPN9hmtactAtgtkOwSbTs5sqODE7rHte5gveRIRmSBolAjcr4c
         TE7Zj/3hFsWZW/N+riDplichlk+G6QbFBGUep0jYmYFurtxQfeOEY8bJTVWGDfrtMlL2
         4CCg==
X-Gm-Message-State: AOAM5331WdAGpbamPQPTnwrQ7IFdgBQ811d8UO7HQ1cwC9gwFVdLxjQS
        aDjXyHm2sgvN/lgebsqjug==
X-Google-Smtp-Source: ABdhPJzMZXq5fPS8Mfo7U17B/sb9872fPIvX1wwcl151n2VMGWOlozDlwLWBpUmpmlsgKulD36KwOA==
X-Received: by 2002:ad4:5bc3:: with SMTP id t3mr15712100qvt.47.1640622531966;
        Mon, 27 Dec 2021 08:28:51 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id bk25sm13422016qkb.13.2021.12.27.08.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 08:28:51 -0800 (PST)
Received: (nullmailer pid 605894 invoked by uid 1000);
        Mon, 27 Dec 2021 16:28:49 -0000
Date:   Mon, 27 Dec 2021 12:28:49 -0400
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht, Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to
 yaml
Message-ID: <Ycnpwa6DxMDHklp6@robh.at.kernel.org>
References: <20211225191856.64587-1-david@ixit.cz>
 <1640561647.349260.393569.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640561647.349260.393569.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 07:34:07PM -0400, Rob Herring wrote:
> On Sat, 25 Dec 2021 20:18:55 +0100, David Heidelberg wrote:
> > Convert Qualcomm PMIC SPMI binding to yaml format.
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > 
> > ---
> > v2:
> >  - add #address and #size-cells
> >  - add reg and remove spmi include from example
> > 
> >  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
> >  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 120 ++++++++++++++++++
> >  2 files changed, 120 insertions(+), 65 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> >  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.example.dt.yaml: spmi@fc4cf000: reg: [[4232900608, 4096], [4232884224, 4096], [4232880128, 4096]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/spmi.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.example.dt.yaml: spmi@fc4cf000: reg: [[4232900608, 4096], [4232884224, 4096], [4232880128, 4096]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml

This can be ignored as there's a fix in next.

> doc reference errors (make refcheckdocs):
> Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt: Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt

Need to fix this one.

Rob
