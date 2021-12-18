Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A8F479BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhLRSIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:08:37 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45590 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbhLRSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:08:33 -0500
Received: by mail-oi1-f169.google.com with SMTP id 7so8826004oip.12;
        Sat, 18 Dec 2021 10:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=giXnH1vD4kFCTfNs5b0SUVp6XrXtWCcNzR2P1YYtOOk=;
        b=lQumNYlqDSGfap2n6RVg/TUN6i2uVpo29LRT1detfc01D3TtFnFyRBWNaEjoNhO/K5
         TFpmhvyvD1fd6M8jBfAOaSSyPDZaKJBG/KYMxcksAKA19C2fjvaJ2tB5W6bzCBsOAbIk
         iFi+CIxjvF4XbOI9tK4LvonJUkksqiYfdwE5HCgMpahj2WPx1g4TTexKkMvuBxH8+qZb
         pObkeurE0h/e0m6ZpxfukqUGCAyENvLGcyYOxfqZFFvyOfczrxE6zT8snAGxwFkx7jOe
         LYjkFnYwAVI5goPQ83QVFloxggzp++8dA9ZijNJmfQpaUQ00XHA55cv1v9xB5/lJkThS
         +SWg==
X-Gm-Message-State: AOAM531FB9AARZq6g4OwtzeUTlUYMZN7ZB3sl2IDPU9uj9wSN3gajIcr
        IIVSKLFJnhqCKRwVS58fHM96SSXKRg==
X-Google-Smtp-Source: ABdhPJymDCHB+g706FNmg46mv2VrrNIUpB+4oTBicifY597IHxu/pGuBJngDcAKLZ7MqwhHj/IwTnQ==
X-Received: by 2002:aca:674a:: with SMTP id b10mr6634914oiy.66.1639850912732;
        Sat, 18 Dec 2021 10:08:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g9sm2292655otr.18.2021.12.18.10.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 10:08:32 -0800 (PST)
Received: (nullmailer pid 72442 invoked by uid 1000);
        Sat, 18 Dec 2021 18:08:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20211217165919.2700920-4-thierry.reding@gmail.com>
References: <20211217165919.2700920-1-thierry.reding@gmail.com> <20211217165919.2700920-4-thierry.reding@gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: memory: tegra: Fix Tegra132 compatible string
Date:   Sat, 18 Dec 2021 12:08:26 -0600
Message-Id: <1639850906.478343.72441.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 17:59:18 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> While the memory controller found on Tegra132 is largely compatible with
> the one found on Tegra124, there are some differences that may require
> more specific matching on a Tegra132 compatible string, so add one to
> the list of compatible strings.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml    | 6 +++++-
>  .../bindings/memory-controllers/nvidia,tegra124-mc.yaml     | 4 +++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1570204


external-memory-controller@7001b000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/nvidia/tegra132-norrin.dt.yaml

external-memory-controller@7001b000: '#interconnect-cells' is a required property
	arch/arm64/boot/dts/nvidia/tegra132-norrin.dt.yaml

external-memory-controller@7001b000: 'operating-points-v2' is a required property
	arch/arm64/boot/dts/nvidia/tegra132-norrin.dt.yaml

memory-controller@70019000: '#interconnect-cells' is a required property
	arch/arm64/boot/dts/nvidia/tegra132-norrin.dt.yaml

memory-controller@70019000: '#reset-cells' is a required property
	arch/arm64/boot/dts/nvidia/tegra132-norrin.dt.yaml

