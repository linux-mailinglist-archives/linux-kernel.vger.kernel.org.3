Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73193479BF7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhLRSIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:08:35 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33758 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhLRSIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:08:31 -0500
Received: by mail-oi1-f174.google.com with SMTP id q25so8951781oiw.0;
        Sat, 18 Dec 2021 10:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=3fGBHfhnSGOfV7vCG+wQzp3UlSs7DZ5URt+w0FqKPMA=;
        b=pvtQZ/JvNYLMnkO8u+gSk7qQXVGTatAuk+4H59Mz8GwHw5YYSYtXVYWSCNSj8fMaKY
         JTg/ZVdsmbBzzBfuphYu7eMDXJTIXJFq16gWVdqlZInn5L8s+Cf3ITkDzxO8gdn3V2kZ
         6Sq/IIQqHFoL/iWXmD0VPuIxIYBbV+1l+TgJ5TtnTteu+MPWt3m/s4FNI23pRce7r8Kw
         3jfa+sB4IzKHi0njqCj3SLDv1L9O9mgBNI/SzLdgCtbOBq/vH9KBrfp3c+gvhXtQaKjK
         w1d7B7FxHmETkR41ZN0IxxvlqCWTm21ZyLqbNukyjwr7IMRYOvLgoJv1AuL1na4Gfulp
         l4gw==
X-Gm-Message-State: AOAM531eMX59UUT9s2NxI9YzwKCShJZYQxfXwKSMhEcjpt4pHY8TkYRN
        /woXB1nQGQYrdMKXiFf0qnqqnpdBWA==
X-Google-Smtp-Source: ABdhPJw1r3eqLckdvydF31crFqVOj0b7o9J+rR5xj5IUzEG6W1sr1YDf4wS3ykG4M/U7seiwiYQaSg==
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr6363999oil.65.1639850911252;
        Sat, 18 Dec 2021 10:08:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g17sm2359815oiy.14.2021.12.18.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 10:08:30 -0800 (PST)
Received: (nullmailer pid 72440 invoked by uid 1000);
        Sat, 18 Dec 2021 18:08:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org
In-Reply-To: <20211217165919.2700920-3-thierry.reding@gmail.com>
References: <20211217165919.2700920-1-thierry.reding@gmail.com> <20211217165919.2700920-3-thierry.reding@gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: memory: Add Tegra114 memory controller bindings
Date:   Sat, 18 Dec 2021 12:08:26 -0600
Message-Id: <1639850906.470783.72439.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 17:59:17 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Document the bindings for the memory controller found on Tegra114 SoCs.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../nvidia,tegra114-mc.yaml                   | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra114-mc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1570202


memory-controller@70019000: '#reset-cells' is a required property
	arch/arm/boot/dts/tegra114-dalmore.dt.yaml
	arch/arm/boot/dts/tegra114-roth.dt.yaml
	arch/arm/boot/dts/tegra114-tn7.dt.yaml

