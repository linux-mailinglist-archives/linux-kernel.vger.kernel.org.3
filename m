Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD848485E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiADTNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:13:24 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:45638 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiADTNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:13:23 -0500
Received: by mail-ot1-f46.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso48303153otf.12;
        Tue, 04 Jan 2022 11:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYdrJ5aZo4VfG1E4eY4sPzFIpzgFNLDGmXy0wK46JQA=;
        b=hlgGKSnuOtiVNHrF/hBu6jlc/pMAbrfAONeK3SK4RQQVR/I45JFzyP2tsApmkf6udI
         F5nZfUFTFs4xgkpRGyQe4IvhLaIIcTJwfu7YRX8Axf5VGfMFEnEhh2Tz1d5Ml+NaDVuT
         fZqP+nzCQreasiNRxTBG7Id0gBdclhJE19bkyu/0/iB7kgK3CNqN3w6ViD63DiaEsVXE
         l9afJeub6sNXlzolaIRBuzHLSDKfP+2NUhFizo9Is1SgC6PZ6zGH7zT/aMWq5G5YNq67
         pluaVtW2Kj/ajolunWdFxNuTtCJunInY3eQy7awk2ZBxkiBYdDoa4M5YbNiWFXX3ZZc0
         3eiw==
X-Gm-Message-State: AOAM531O47/lABR6cVmoOAFpJGxDwBozxlI5jYZzzJNEoyi2KLpsnRXc
        6Ixhn/HlrUm4f4sw11jjL4PtpCRKeA==
X-Google-Smtp-Source: ABdhPJwbb0VRJ4x11NJ1brBesuytz6PGSa02P/yIprwJGhC/enR/g12iNSPFibSnwiqTccFGJdWFbw==
X-Received: by 2002:a9d:463:: with SMTP id 90mr36865979otc.35.1641323602523;
        Tue, 04 Jan 2022 11:13:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d1sm6821951oop.35.2022.01.04.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:13:22 -0800 (PST)
Received: (nullmailer pid 1239046 invoked by uid 1000);
        Tue, 04 Jan 2022 19:13:21 -0000
Date:   Tue, 4 Jan 2022 13:13:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 4/5] dt-bindings: memory: tegra: Fix Tegra132 compatible
 string
Message-ID: <YdScUagVpz4qnfCX@robh.at.kernel.org>
References: <20211217165919.2700920-1-thierry.reding@gmail.com>
 <20211217165919.2700920-4-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217165919.2700920-4-thierry.reding@gmail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
