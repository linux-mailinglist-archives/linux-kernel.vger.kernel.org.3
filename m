Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73AB463D12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbhK3Rq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:46:28 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41704 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbhK3RqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:46:25 -0500
Received: by mail-oi1-f175.google.com with SMTP id u74so42743562oie.8;
        Tue, 30 Nov 2021 09:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ybArtp5NAo1h9pHzQHYt4+Qs6w6iIvokhHnIINTzz0I=;
        b=qftcKr4sOsBIREMtVai33g8u791raNbou+On9oUBMNdjgb19mw06ybGKdw8ACaqm+T
         sdvFJ+Tc0bcU4cdMgPyGc7ZQjQ5wU0r2UGkkaKFt/4eo67cLCYJHz7akQq4NfzoAHXOo
         lGame3nv6g49nxTuOz3peByCEgcK6GtFuOi/IMsoSbu+V87kQK35k68TSWpzqb4eGDdm
         REKGlhfilQMygH0bR5dgz/DCeR1aKVUItplASTrq4yGZDmacq163qN9cIFp6tv479djs
         npceBK6Ks9sta4jmdVZ+SnrXU5vsR3Ohzlpny3BJ4+soxDGU2cPm+E0e+xcG2IcKdXGa
         7LMw==
X-Gm-Message-State: AOAM533AaRDR2LJ4Om1NeR3MROi/pFId4cvt50wrb77Ts/uFlGZv/P9v
        gPaOrTcYxHyPanj/IqW1Qg==
X-Google-Smtp-Source: ABdhPJxpfwZHaJJsQJrxxxdGKQhKNwmK7qoAn5Ox2tfeIPsdhQ8/yFLYB/VG+xooU2jW+OEAPMZFqg==
X-Received: by 2002:a05:6808:144f:: with SMTP id x15mr329339oiv.157.1638294185979;
        Tue, 30 Nov 2021 09:43:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v19sm3208026ott.13.2021.11.30.09.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:43:05 -0800 (PST)
Received: (nullmailer pid 2713643 invoked by uid 1000);
        Tue, 30 Nov 2021 17:43:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-serial@vger.kernel.org,
        Youngmin Nam <youngmin.nam@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20211130111325.29328-2-semen.protsenko@linaro.org>
References: <20211130111325.29328-1-semen.protsenko@linaro.org> <20211130111325.29328-2-semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
Date:   Tue, 30 Nov 2021 11:43:04 -0600
Message-Id: <1638294184.179325.2713642.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 13:13:21 +0200, Sam Protsenko wrote:
> Add constants for choosing USIv2 configuration mode in device tree.
> Those are further used in USI driver to figure out which value to write
> into SW_CONF register. Also document USIv2 IP-core bindings.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Combined dt-bindings doc and dt-bindings header patches
>   - Added i2c node to example in bindings doc
>   - Added mentioning of shared internal circuits
>   - Added USI_V2_NONE value to bindings header
> 
>  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
>  2 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
>  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/samsung/exynos-usi.example.dts:35.39-42.15: Warning (unique_unit_address): /example-0/usi@138200c0/serial@13820000: duplicate unit-address (also used in node /example-0/usi@138200c0/i2c@13820000)
Documentation/devicetree/bindings/soc/samsung/exynos-usi.example.dt.yaml:0:0: /example-0/usi@138200c0/i2c@13820000: failed to match any schema with compatible: ['samsung,exynosautov9-hsi2c']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1561571

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

