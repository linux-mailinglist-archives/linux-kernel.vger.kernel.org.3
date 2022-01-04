Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCDC484888
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiADT0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:26:24 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34352 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiADT0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:26:20 -0500
Received: by mail-ot1-f49.google.com with SMTP id o3-20020a9d4043000000b0058f31f4312fso46322544oti.1;
        Tue, 04 Jan 2022 11:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKrA0VG5088QppXxlOYC79pk7hClbKGMriiqTjf+5V0=;
        b=3SD2Hb4r0YQKOKueieYa49vmHWpCOoRGfoM2erCQte2JsaEuNSIlWBxoAxtitJzbiW
         0hr+hGzE/N2EPi+gRyzCju2wO7OZvBD3HRbyTEMKpHwR5RZx9+cu8m1JiOpV0oHVnBnX
         oA9EV9BLNOXmnxoa1RvMNKt0fBoMXMLU/7MbMQrLlaG4y/y7pGdK0DeXC8AqeCfQnLK8
         rwdBZJOoxaim6lqQ4yHrMeDq3CDYwIsk5pcPbcelRKlOaVseXcf2O9tMzEFKrubZ6XzB
         pIc1bxnVKi5EU/kiSxwrmdqAK2CAKg1mXp3LwWnLTKAfqvxfVV7qj4xpzVyVdhkzpaew
         h2Kg==
X-Gm-Message-State: AOAM5331Noa/ouXbTusUeRROlmr8MCJgG6+9D6eXwh+ZNcGj2ar/KS4p
        FJyhLDD7yWQbuZ+Gjy9XT/8aTLPd3A==
X-Google-Smtp-Source: ABdhPJxCXU9/2UnfSX6FTnORjLMwzO5dNGz4FBXb+4cI/iN163LD8/6FZ+ptpnnF6UXfyvHIEKWbJg==
X-Received: by 2002:a9d:bf7:: with SMTP id 110mr37296906oth.94.1641324379789;
        Tue, 04 Jan 2022 11:26:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j99sm7957678otj.15.2022.01.04.11.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:26:19 -0800 (PST)
Received: (nullmailer pid 1261017 invoked by uid 1000);
        Tue, 04 Jan 2022 19:26:18 -0000
Date:   Tue, 4 Jan 2022 13:26:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org,
        Philippe Cornu <philippe.cornu@foss.st.com>
Subject: Re: [PATCH] dt-bindings: display: st,stm32-dsi: Fix panel node name
 in example
Message-ID: <YdSfWqj34Ragg+Yj@robh.at.kernel.org>
References: <20211221125145.1195234-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221125145.1195234-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 08:51:45 -0400, Rob Herring wrote:
> With 'unevaluatedProperties' support enabled, the st,stm32-dsi binding
> has a new warning:
> 
> Documentation/devicetree/bindings/display/st,stm32-dsi.example.dt.yaml: dsi@5a000000: Unevaluated properties are not allowed ('panel-dsi@0' was unexpected)
> 
> The documented child node name is 'panel', so update the example.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-dsi.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks!
