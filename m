Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E877647BEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhLULLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:11:09 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:42934 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhLULLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:11:08 -0500
Received: by mail-qk1-f171.google.com with SMTP id g28so12126937qkk.9;
        Tue, 21 Dec 2021 03:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dMnbDwf4sXFp7HzoaGN0uRyr/AI/cM6kGyxBdxavTk4=;
        b=5DfxIseQ7vAtihN3t80Wpoqbhbz6hhDl1/FpOgdxQCyZGRGeDCKnbwXgTLI6UcQqQs
         anoYuI2uF86P4/Td5O27M2c9w6mPqPEdWjaSGYMXDQz0x0nh58Br3LiFFAx9mj+HRwaa
         qwDVFYVeeRL3E1RGYYsLx5pkXPAhBcnMY9gwcPRScDpuGx7jAj6pLAq8OSytFHb56L0x
         nT5L0uwb6WYAYdKKVg2YzcV9uWmDsYZB7vhkl5aNdFH4+YYRxk0GSJ1hMIxo35ErKBxS
         IlCFC43evBdfS3v5/ym2+ECbAXKOdoNUs6fblBXhxwd63g5xk4D0xqrxUMtyIH5yZm04
         W9yQ==
X-Gm-Message-State: AOAM5326Fexp7inWBpaseJlhAHUnbv+LpGqKQ47J5B9k6NpT4K3p/B/T
        9AlAT23OHSOfvrYTLk9NLQ==
X-Google-Smtp-Source: ABdhPJxA8C/GSCVRnCiRvg+dZAXBp3kgfa/ReU/ssjAKRnOCwFW4LT1kVwcJfx+iN4khwTml61ZIXw==
X-Received: by 2002:a37:c404:: with SMTP id d4mr1540251qki.120.1640085067253;
        Tue, 21 Dec 2021 03:11:07 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id c7sm17543272qtc.32.2021.12.21.03.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 03:11:06 -0800 (PST)
Received: (nullmailer pid 1014105 invoked by uid 1000);
        Tue, 21 Dec 2021 11:11:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     devicetree@vger.kernel.org, collinsd@codeaurora.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        subbaram@codeaurora.org, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1640071211-31462-12-git-send-email-quic_fenglinw@quicinc.com>
References: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com> <1640071211-31462-12-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [PATCH v4 11/11] dt-bindings: convert qcom,spmi-pmic-arb binding to YAML format
Date:   Tue, 21 Dec 2021 07:11:04 -0400
Message-Id: <1640085064.276534.1014103.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 15:20:09 +0800, Fenglin Wu wrote:
> Convert the SPMI PMIC arbiter documentation to JSON/yaml.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 146 +++++++++++++++++++++
>  2 files changed, 146 insertions(+), 67 deletions(-)
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

See https://patchwork.ozlabs.org/patch/1571409

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

