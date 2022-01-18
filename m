Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2700349136D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbiARBcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:32:53 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33338 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbiARBcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:32:52 -0500
Received: by mail-ot1-f51.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so5010733otu.0;
        Mon, 17 Jan 2022 17:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=UTya3NP8ShVi3TupYuluGp8FAaiOXk0bgJr9capIY1Y=;
        b=aN17tOQXkxYyAq+7JgHXMpIMT4PdRRZlzJQ0Pb4YZgdpIeOK6o3zN8U3o57OvF/SUh
         TnmrUbWjqz8KRdtm7H811nMDQSw4ro4OJUqvLWTMWPx3ZxoXHdxanBlMmvuZScUwYx50
         UKezkw8r9N8QYlihCbmm0z7RuRz72peU9M7rPobIqTlXW3ZYCneHluZUfDaPjZ439QEJ
         Aoog1nVzhtenFOLC5MW3sab8RHEmBV0d9YQFGhq+IHGtMF2lcbaAvhYVQacJF0xz8mmi
         kD8mPlQrt99B3J0T8NwqrcIalxMKwtqJcvdaU1EhkOh10DhHO373rOS0ZAMdsi5mZFGv
         8Scw==
X-Gm-Message-State: AOAM530J//N+N1zl1s4lpqGt+WIXATc24OJOgdYT6M0OK/uB1odl/nkQ
        ya88D4hB9HZLCrr1GOvLhHru8BEWuA==
X-Google-Smtp-Source: ABdhPJxY2OtlCebxGCFuxE33YrmMjePyRG0OvLHCPVYYAFzbcANNCuNMrHqFQjab+l6ECjiYQmfEfw==
X-Received: by 2002:a05:6830:150b:: with SMTP id k11mr15905244otp.231.1642469571569;
        Mon, 17 Jan 2022 17:32:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o11sm7905064oiv.10.2022.01.17.17.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:32:50 -0800 (PST)
Received: (nullmailer pid 545751 invoked by uid 1000);
        Tue, 18 Jan 2022 01:32:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220118004434.17095-2-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com> <20220118004434.17095-2-ansuelsmth@gmail.com>
Subject: Re: [PATCH 01/14] dt-bindings: clock: Document qcom,gcc-ipq8064 binding
Date:   Mon, 17 Jan 2022 19:32:47 -0600
Message-Id: <1642469567.797039.545749.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 01:44:21 +0100, Ansuel Smith wrote:
> Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> clocks. The gcc node is also used by the tsens driver, already Documented,
> to get the calib nvmem cells and the base reg from gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-ipq8064.yaml      | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
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
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.example.dt.yaml: clock-controller@900000: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.example.dt.yaml: clock-controller@900000: compatible: ['qcom,gcc-ipq8064', 'syscon'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.example.dt.yaml: clock-controller@900000: compatible: Additional items are not allowed ('syscon' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1581028

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

