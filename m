Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2A04CC9D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiCCXLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiCCXLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:11:30 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229D557B30;
        Thu,  3 Mar 2022 15:10:44 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id q5so6266489oij.6;
        Thu, 03 Mar 2022 15:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2KRV1GyTQqui7RvrHbWgPMaKwbdMLd0koGoelufXZGo=;
        b=fZJ0A9DicfFT6etBo/JyW0tHLjHfTpAFYQEEAyTk3PaFdhYRq2qEAPiStjjEcNze57
         3Of6YlXa9bw4UwH2vNIfr1WYy/UcN3O9xjK/AGU2LXAfqUkF3sPisHlEf2i/eLCYf53Z
         8HRlcHDBmMimfUs0E/z+PjYrUjoVf4w+gKq3IDfqF7vB9bA4O62A5Aya9akg1a2YYzhl
         1G8GC45vHebiTE/7AFvbrNI94oyZJFp6JDC564Zshrd0Wvk+puaHJVISy9EFmFpql8Jc
         MzO6APRhSEpkbuGlggcHeTAPZrhnCuZCuMkb5UcIdwi+vbMA2y6MY11DTo2XRvuBaH06
         CMcw==
X-Gm-Message-State: AOAM533aDwKy21wxel4sO0xsV6hyuYtn0zdVynbRZnS9YRv5uw70o3A6
        4qtBicR8nGBnx/wLtI8KPZ5kzFF80w==
X-Google-Smtp-Source: ABdhPJzgT1COlgMO64X8OrpSfqFTj1Ahr/VDt4O81IIdmejDeYYGlDPqAF//jemxiFGQ5aAUY/dw4w==
X-Received: by 2002:a05:6808:1453:b0:2d4:f628:8487 with SMTP id x19-20020a056808145300b002d4f6288487mr6929898oiv.19.1646349043242;
        Thu, 03 Mar 2022 15:10:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x10-20020a4a2a4a000000b0031bf0818df1sm1635117oox.4.2022.03.03.15.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:10:42 -0800 (PST)
Received: (nullmailer pid 2570330 invoked by uid 1000);
        Thu, 03 Mar 2022 23:10:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        devicetree@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20220303211620.32456-1-david@ixit.cz>
References: <20220303211620.32456-1-david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: timer: Tegra: Convert text bindings to yaml
Date:   Thu, 03 Mar 2022 17:10:41 -0600
Message-Id: <1646349041.283916.2570329.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2022 22:16:19 +0100, David Heidelberg wrote:
> Convert Tegra timer binding into yaml format.
> 
> This commit also merge 3 text bindings with almost
> identical content (differens in number of registers).
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - reg: true -> reg: maxItems: 1
> ---
>  .../bindings/timer/nvidia,tegra-timer.yaml    | 150 ++++++++++++++++++
>  .../bindings/timer/nvidia,tegra20-timer.txt   |  24 ---
>  .../bindings/timer/nvidia,tegra210-timer.txt  |  36 -----
>  .../bindings/timer/nvidia,tegra30-timer.txt   |  28 ----
>  4 files changed, 150 insertions(+), 88 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
>  delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
>  delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>  delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/timer/nvidia,tegra-timer.example.dts:21.24-31.11: Warning (interrupts_property): /example-0/timer@60005000: Missing interrupt-parent

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1600650

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

