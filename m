Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C214AA9B0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 16:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376559AbiBEPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 10:36:24 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43654 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiBEPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 10:36:23 -0500
Received: by mail-oi1-f173.google.com with SMTP id t199so12158292oie.10;
        Sat, 05 Feb 2022 07:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Y2Qv/CaLIFl6ThWPqox5+Cd+VEGPcdfkgPqDQlBgUio=;
        b=SKENTsSH9A7zzzEZU3OHtzUe+ZAZfQtOk0+1gLXBfNjgOHQ246KQ6vNm1YOYPrhool
         zpAdAopMfX0ot2reocgA/z6Dn/UyI20YJz+qacQbMXVdA+EAnLI1izFDXDt3tUG0HTmL
         1i6Yd79/fbz2luH7XDVCdzA5LQJCydmL6hoyBazJnkiobtdPKcNL6E8TMkSWMudmGaXU
         T18OwksJkaK21URntLFqZV1rjNtDay6nEcD3iZg4qiIrJbzmnWo7VgmaW9NwYygku0Uw
         RN7zvq70yRn9hFgPF7NfvQjh7jjBnoD3Lu1ki406c36+ihm4ClmmHWvo262jTj2xVedQ
         Ftng==
X-Gm-Message-State: AOAM532pKfTxYnu2SEe4OIwzGpH+O9n/MjbfDSFYloKHK/yrCkPwGpG3
        orMLdUgVwBkZT38i3gnTJxfc1ZeJjA==
X-Google-Smtp-Source: ABdhPJyDreVR/y7GuACHhMt7r5+pIjIs7ZZ0nwWWaGud+7VMpAvtUIzeQzwJGJqTK9DuenoOVznIBw==
X-Received: by 2002:a05:6808:1184:: with SMTP id j4mr1911329oil.73.1644075382872;
        Sat, 05 Feb 2022 07:36:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 100sm1962743oth.75.2022.02.05.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 07:36:22 -0800 (PST)
Received: (nullmailer pid 542296 invoked by uid 1000);
        Sat, 05 Feb 2022 15:36:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220205120043.8337-2-krzysztof.kozlowski@canonical.com>
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com> <20220205120043.8337-2-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: memory: lpddr3: convert to dtschema
Date:   Sat, 05 Feb 2022 09:36:21 -0600
Message-Id: <1644075381.224411.542295.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Feb 2022 13:00:39 +0100, Krzysztof Kozlowski wrote:
> Convert the LPDDR3 memory bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../memory-controllers/ddr/jedec,lpddr3.yaml  | 266 ++++++++++++++++++
>  .../memory-controllers/ddr/lpddr3.txt         | 107 -------
>  2 files changed, 266 insertions(+), 107 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.example.dt.yaml:0:0: /example-0/lpddr3/timings@800000000: failed to match any schema with compatible: ['jedec,lpddr3-timings']

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt
Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml: Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt

See https://patchwork.ozlabs.org/patch/1588734

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

