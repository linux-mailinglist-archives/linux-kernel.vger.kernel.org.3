Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92349565F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378087AbiATWcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:32:35 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38456 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378078AbiATWce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:32:34 -0500
Received: by mail-ot1-f49.google.com with SMTP id k13-20020a056830150d00b0059c6afb8627so7256552otp.5;
        Thu, 20 Jan 2022 14:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Qk+KVq+IEtQ2KJ1s+kYA1v3op5u0MiFtVTneB8j+4Gc=;
        b=pNjAjF/oSJWaFVTmIRvP0OHnaR+mRtzFsvhOjrKPsb/1aB7BD0bu/AlV9gNWOrQBpR
         7iymDu9NGG6Co2CKfF2zXdSH/pYMRtFbBKbbLwInqw9dkPmg1B+MCPX6G00KXhxnez4x
         cN1YdDDIzKmC3eHe9MYSXe7F8qn1nLLHYnySBEzPqJIznD8BCSRvO8v/XsNKZPPCl/eV
         1XEpQaLtYjgIWHDP/upurKL6uQxEG3qFIVPmryy2fEBTkPywZ3JK55SgfuH0MZntA/NL
         ImQ28f8qO6keLR6jVIXbf6nNd9z7ppYc6OLlFu6X8vMEgKAsOn+PjyGsjlGG54rXIcBU
         OKnw==
X-Gm-Message-State: AOAM533+s2Epnkn22p2ptuxyskqIFb/793ImO9x7+VITicJdUSnk8Okh
        bQNd+CyglnXRtLhG5EEP8Q==
X-Google-Smtp-Source: ABdhPJyMAA182WiefyQ1snVqf2+n/o1Y5BQiyJ6E/Mn8qFkrr457ICztjZxr28+T+/s0YjTjzzPy3A==
X-Received: by 2002:a9d:24a2:: with SMTP id z31mr755556ota.216.1642717953907;
        Thu, 20 Jan 2022 14:32:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h2sm232992otm.11.2022.01.20.14.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 14:32:32 -0800 (PST)
Received: (nullmailer pid 2059832 invoked by uid 1000);
        Thu, 20 Jan 2022 22:32:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220120202615.28076-2-ansuelsmth@gmail.com>
References: <20220120202615.28076-1-ansuelsmth@gmail.com> <20220120202615.28076-2-ansuelsmth@gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: mtd: partitions: Document new dynamic-partitions node
Date:   Thu, 20 Jan 2022 16:32:31 -0600
Message-Id: <1642717951.834828.2059831.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 21:26:14 +0100, Ansuel Smith wrote:
> Document new dynamic-partitions node used to provide an of node for
> partition registred at runtime by parsers. This is required for nvmem
> system to declare and detect nvmem-cells.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../mtd/partitions/dynamic-partitions.yaml    | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.example.dt.yaml: partitions: 'hwlocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.example.dt.yaml: partitions: 'oneOf' conditional failed, one must be fixed:
	'reg' is a required property
	'no-map' is a required property
	'memory-region' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.example.dt.yaml: partitions: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1582321

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

