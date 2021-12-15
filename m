Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE47B476315
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhLOUVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:21:25 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:47015 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhLOUVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:21:23 -0500
Received: by mail-ot1-f51.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so26222874oto.13;
        Wed, 15 Dec 2021 12:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQ8vlrBk7DJc0hVmIhObgL2xXmJjWuBfV9XvXNLrZNQ=;
        b=Ogpwdjq6glMsfRTJI128dk3Hq0LletLGcGZpGA4TZaaZVZlR2P/wTFa/isDB1yykPm
         RBjYfkTi2spknLelVi3cMVi3xB0T2wIDCqeZGaNH4M3hOZ7OTcBNetFHLjnHNATcm/ND
         EnhKicq7/8G2UUytJDxxsIlCoRYDWCHCxqXQVojPfi2crIchiGTk99+wDEgmTVAi5X2p
         fv4fGB4pVpgifu7BI4rR/2SQUlhFxip6rMQfwzgeS+UkktuTj48FWOEuh7PwWQV+bDYe
         7I0UicBDYo5xpFM5mnfMtb4rj5rj+pXGN4TOehn4bniN8pAC1nrjbkTw+yh8562DWibE
         AwOw==
X-Gm-Message-State: AOAM532FurhW5a1yOOEHFUQLD/aiq6yOHGagnvI6RRVTux8O+FVggns4
        zWPkuCggLQ5dqeZ38MOveA==
X-Google-Smtp-Source: ABdhPJxC59Ji8AeInAmQhyDZnQ4dqv7USkDOWK/uEcjTK8UdpgoiO8oit8r2/wnetTew1hS//mcZnw==
X-Received: by 2002:a05:6830:2704:: with SMTP id j4mr10080144otu.184.1639599683090;
        Wed, 15 Dec 2021 12:21:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w19sm532539oih.44.2021.12.15.12.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:21:22 -0800 (PST)
Received: (nullmailer pid 1772078 invoked by uid 1000);
        Wed, 15 Dec 2021 20:21:21 -0000
Date:   Wed, 15 Dec 2021 14:21:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: memory: tegra: Update for Tegra194
Message-ID: <YbpOQdWUgc7LbPr1@robh.at.kernel.org>
References: <20211213162151.916523-1-thierry.reding@gmail.com>
 <20211213162151.916523-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213162151.916523-2-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 17:21:46 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The #interconnect-cells properties are required to hook up memory
> clients to the MC/EMC in interconnects properties. Add a description for
> these properties.
> 
> For the nested EMC controller, the list of required properties was
> missing. Add it so that the validation can be more strict.
> 
> Also, allow multiple reg entries required by Tegra194 and later.
> 
> While at it, also remove the dummy BPMP node from the example because it
> is incomplete and fails validation. It's also not necessary for this
> file and the BPMP DT schema already has a full example.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - reword commit message to reflect changes in v2
> 
> Changes in v2:
> - drop incomplete BPMP snippet from example
> - explicitly set minItems for reg property
> - describe MC and EMC general interrupts
> - add required properties for EMC
> 
>  .../nvidia,tegra186-mc.yaml                   | 78 ++++++++++++++++---
>  1 file changed, 67 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
