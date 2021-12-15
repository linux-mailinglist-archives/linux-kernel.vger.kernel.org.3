Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DA475CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244385AbhLOQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:03:48 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:46743 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhLOQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:03:47 -0500
Received: by mail-oi1-f171.google.com with SMTP id s139so32198149oie.13;
        Wed, 15 Dec 2021 08:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTcNTFB+NbkHTcAd9qD1dVkWYrQ03s2LijZVy1oBOuU=;
        b=joWO7PS6lWR0YEQjbF82GhunRWrsd9NAw/NtpCm1wUhcmx9rXCT8x+faROwvAa9Uor
         XH2zlGMsSCvhJ3ftDCzbw+UF/AYGGJFx0CHUbc4yetTRXcLDZoTF84fyKENV7Rhn3Jjs
         HFkgc0m4Y7D3gkzpgrr3m3wfcquVLlEZ3+dL8UQmSY5HEzbjZz9jQNqpG4cLOzsmXThG
         ergNCKzDxTxVocG8x18pxp187JmhUk8sTEgV6v93a5ry1FW5pq0Qw7sUZ6jwEPRvfDAe
         pG7B7InWF9Z75uJdhtwaCG5/7a1I5SAIRzr2uLbcXt8AlHML0SsreDmcAu5dkKXvak0z
         kkdw==
X-Gm-Message-State: AOAM5307IpXW1tXg5Rf+opEipydPWGA55ikYpGfmUs57ZVZBIIRS5LII
        N72qI67bxDc4BO9zptTzzw==
X-Google-Smtp-Source: ABdhPJxcEC8GaG5MiQpyLT/0ZeKJG5yMFntxwwj5HQx++f6s884/vXuecGcVNLCcGHcV0hCCY5AVXg==
X-Received: by 2002:a05:6808:1919:: with SMTP id bf25mr411273oib.33.1639584226858;
        Wed, 15 Dec 2021 08:03:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d6sm499525otb.4.2021.12.15.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:03:45 -0800 (PST)
Received: (nullmailer pid 1397034 invoked by uid 1000);
        Wed, 15 Dec 2021 16:03:45 -0000
Date:   Wed, 15 Dec 2021 10:03:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, kishon@ti.com, nm@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        tony@atomide.com, krzysztof.kozlowski@canonical.com,
        vigneshr@ti.com
Subject: Re: [PATCH v2 1/4] dt-bindings: memory-controllers: ti,gpmc: Add
 compatible for AM64
Message-ID: <YboR4WAKRu8ui9HZ@robh.at.kernel.org>
References: <20211208124611.16843-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208124611.16843-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021 14:46:08 +0200, Roger Quadros wrote:
> AM64 SoC contains the GPMC module. Add compatible for it.
> 
> Newer SoCs don't necessarily map GPMC data region at the same place
> as legacy SoCs. Add reg-names "data", to provide this information to
> the device driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  .../bindings/memory-controllers/ti,gpmc.yaml  | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
