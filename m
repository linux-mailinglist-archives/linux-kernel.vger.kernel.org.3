Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5CB4957CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348250AbiAUBhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:37:45 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36396 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347920AbiAUBhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:37:43 -0500
Received: by mail-ot1-f46.google.com with SMTP id l64-20020a9d1b46000000b005983a0a8aaaso9961860otl.3;
        Thu, 20 Jan 2022 17:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=hqlXA1zkINF1/hiLfKQKWGGx9nwIuGLG8G3kFH0NWF0=;
        b=u2Scql7dz9SlGQIxASZJoBeEDxm9YK8nauYgozKqn0n7xura9K/1KE1bxg3AC3AB/9
         088AQFgvbFf+s8tPf5nwnwdh7wkLRTuhUI1qtxCIT2zSUSluaaSzJDWFa5D5q/v0GrA/
         HQNt3Tpy6Qv6X3XtNlbzpJyy8OBAeSej8/LZSZ/ObeKPe32n1EdepWbydpSMklOieh9r
         qSyuq/F3ftCglvMjwPkrg1vKJL3y76u3FIetFFq8yGDeM9u5Xj6mcJDxq1A1fu/yFBjg
         PUFh9Y1ObJ5EmGYhtPiS0AFMWQSpe5z+Pr0SO5+asHL+Mk3zR1b2ZARWbmWguVr9HZ8Q
         qCbw==
X-Gm-Message-State: AOAM532cl4MBKE3lCLx/5SrPbtD2LU8ZlZs7Zesx/4incVVqoO8qEovU
        P8bb715Gg8e7+D4EKHcrRw==
X-Google-Smtp-Source: ABdhPJzTkd1tMl1ZQIkmz6z38op171VvGqNMIYALgBN8WBKDrOAc0BvoXvlezg0FwGrDl6BnnOOILQ==
X-Received: by 2002:a05:6830:1e99:: with SMTP id n25mr1150607otr.344.1642729062253;
        Thu, 20 Jan 2022 17:37:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h7sm392952otr.43.2022.01.20.17.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 17:37:41 -0800 (PST)
Received: (nullmailer pid 2314868 invoked by uid 1000);
        Fri, 21 Jan 2022 01:37:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220120232028.6738-4-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com> <20220120232028.6738-4-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: clock: Document qcom,gcc-ipq8064 binding
Date:   Thu, 20 Jan 2022 19:37:38 -0600
Message-Id: <1642729058.545554.2314867.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 00:20:16 +0100, Ansuel Smith wrote:
> Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> clocks. The gcc node is also used by the tsens driver, already documented,
> to get the calib nvmem cells and the base reg from gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-ipq8064.yaml      | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.example.dt.yaml: clock-controller@900000: compatible: ['qcom,gcc-ipq8064', 'syscon'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.example.dt.yaml: clock-controller@900000: compatible: Additional items are not allowed ('syscon' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.example.dt.yaml: clock-controller@900000: 'clock-names', 'clocks', 'thermal-sensor' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1582346

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

