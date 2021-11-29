Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588654622D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhK2VGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:06:05 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:46630 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhK2VEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:04:05 -0500
Received: by mail-ot1-f51.google.com with SMTP id 98-20020a9d086b000000b0057a403bbd4eso2686993oty.13;
        Mon, 29 Nov 2021 13:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ixqJ+RY2dWFIvNpDhU+gxTfVfUYruXUuo17YT42W18=;
        b=BXph+lnLRB2mbmwStUt/YWkqaAXlomuxs7pPC51Lvykt/E/hh2KpUE3FPbkorUAdaR
         /SY8cDDvhZU33/s2i9iPXwvZHEdMTqJ+9UOdozGZukaKD7eOzhm/yAvRAVFxoRe0dNn/
         Y4qEvPuooqDUG0+KxGnXv5TYM4mV3kREPfElAtOPyNvV8K40D2f1N/2P4YNjLqwXO9Sl
         jhrE16QCGjC46WHFJDsHVas+gLJcFHQhCDn/u6nicz/n8o5c19uKgAkfSLB0rs8LF0DG
         judPo+E4AHDxo2ze1tQyQKACHIHTCx2Sqw+kwUUg6oFj9DHfLXLmaRo18OGnsZ5vkRnP
         S4Mg==
X-Gm-Message-State: AOAM532k3Ru35V4MDXBoXJkwFqhqAtMoIEizl9+c1kLSabSGUrKwBkEx
        L51HtRwpCTPNyw4OiTFOXg==
X-Google-Smtp-Source: ABdhPJzz1w47/saTd8O+0bjqYSiswi3LKIsOOshwOjfDd+i+fFukeeezynZTMlH2kWoM4DPxHi1/HQ==
X-Received: by 2002:a9d:7210:: with SMTP id u16mr33430776otj.160.1638219646852;
        Mon, 29 Nov 2021 13:00:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay40sm3308511oib.1.2021.11.29.13.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:00:46 -0800 (PST)
Received: (nullmailer pid 601270 invoked by uid 1000);
        Mon, 29 Nov 2021 21:00:45 -0000
Date:   Mon, 29 Nov 2021 15:00:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: memory: tegra: Add Tegra234 support
Message-ID: <YaU/fcN/UwqMQAAN@robh.at.kernel.org>
References: <20211112130627.3682795-1-thierry.reding@gmail.com>
 <20211112130627.3682795-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112130627.3682795-3-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 14:06:24 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Document the variant of the memory controller and external memory
> controllers found on Tegra234 and add some memory client and SMMU
> stream ID definitions for use in device tree files.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../nvidia,tegra186-mc.yaml                   |  2 ++
>  include/dt-bindings/clock/tegra234-clock.h    |  9 ++++++
>  include/dt-bindings/memory/tegra234-mc.h      | 32 +++++++++++++++++++
>  3 files changed, 43 insertions(+)
>  create mode 100644 include/dt-bindings/memory/tegra234-mc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
