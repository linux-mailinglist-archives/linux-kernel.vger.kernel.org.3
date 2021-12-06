Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02FD4698D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbhLFO27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:28:59 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35646 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344236AbhLFO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:28:57 -0500
Received: by mail-ot1-f46.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso13837178otr.2;
        Mon, 06 Dec 2021 06:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=CWGHOhMZUfniE+Y2ng6wuO7zGULF9CPIy3yGJ1kJWX0=;
        b=DgwFIAmc9k2dWMF6EQVDHIiNE35cuKEvoa+pjnuDeEpoU1T9GbQbFPHDX0ItXFnlwY
         ddRE4uy8P1xniuAKAitMKdSo4lZwJ3GJNZWMq4J+hQndcEwYphV6FuJysgne/pqPSfcw
         uKKRU+YgChofbHOQCk0QhwL6P97XQiQBgIav/9/UTfZr9De6WGWtkblnH9e6AxfPlhbm
         uTQbWHRjacuypQvvrFtke+Ns08YssWEPkGzTiuoNtc949z5Nmq37UvnmHKXZCKB69UZb
         A6BJMbFvASPBGFL59M+GF6AiW7RI4VTr5x1V/IaEfEKM3wnDijThouPnBSfokHFORpX5
         viQw==
X-Gm-Message-State: AOAM533JlCKddPbz3MaK9BV/OnSMpny5CgEvxXy3hMcpEA4kDTlFMhdk
        R+VvpghYxn4GoSlytayN6Q==
X-Google-Smtp-Source: ABdhPJyfp+sRZSmmxcQQNS5FVwHTA4gbp/9HMnapB0bZgOO+3eG1BRDTnxJZIBTFqjfhvJMpWKKcbg==
X-Received: by 2002:a9d:12c:: with SMTP id 41mr30003581otu.322.1638800727961;
        Mon, 06 Dec 2021 06:25:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s2sm2197803otr.69.2021.12.06.06.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:25:27 -0800 (PST)
Received: (nullmailer pid 1976294 invoked by uid 1000);
        Mon, 06 Dec 2021 14:25:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211205230804.202292-3-virag.david003@gmail.com>
References: <20211205230804.202292-1-virag.david003@gmail.com> <20211205230804.202292-3-virag.david003@gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: Document Exynos7885 CMU bindings
Date:   Mon, 06 Dec 2021 08:25:22 -0600
Message-Id: <1638800722.490043.1976293.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 00:07:56 +0100, David Virag wrote:
> Provide dt-schema documentation for Exynos7885 SoC clock controller.
> Description is modified from Exynos850 clock controller documentation as
> I couldn't describe it any better, that was written by Sam Protsenko.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Fixed double : in description
>   - Added R-b tag by Krzysztof Kozlowski
> 
> Changes in v3:
>   - Nothing
> 
>  .../clock/samsung,exynos7885-clock.yaml       | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.example.dts:21.47-46.11: Warning (unit_address_format): /example-0/clock-controller@0x10010000: unit name should not have leading "0x"
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.example.dt.yaml: example-0: 'clock-controller@0x10010000' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1563783

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

