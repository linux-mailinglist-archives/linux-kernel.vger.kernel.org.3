Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD64A689C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242924AbiBAXk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:40:58 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46985 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiBAXk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:40:56 -0500
Received: by mail-oi1-f179.google.com with SMTP id y23so36452197oia.13;
        Tue, 01 Feb 2022 15:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ee57DHmj5dnuP+LBJd/K38nnzdPSCpMAb2DQvjNUIqo=;
        b=AmD7xoJ0KEyoUbXGpfmzGhQ5KNVhZk53iRsYSMhQdzkilNJS2wYOZoqCKIwyK8NNyQ
         QAMpnv4Kfi5dSOT60Bb9Y7rrwZlngxx2D+lDGBqPwR75kh0tND6K3cm+EddGcmlvHIPM
         yMmKXb5G2sma0Ppj9CwkzzEmZ4fmukfg28ITzRKmRp4pEXwJoWMh02bkpQjWStEg1L9t
         eo7Juoxw0sc7uRrDad673fVW61INQolYUZPk65lQkZZWW2ZCAWgOzPA5NKKa9olAxmbC
         DSAnOfwY8Wiq+459jQdHHu2MeE0eoYw//gKHAhudboLjtp4qBNDN44R8QIKc7dCGUljL
         noeA==
X-Gm-Message-State: AOAM531SvJWc3KT+hTYR/f2VEp2wbNAMBZjocBn4YJxQRqySVHn4bzGZ
        AKbwOu4yJUoUCCfEEjiE3Q==
X-Google-Smtp-Source: ABdhPJzKGe8aH8cwKkyPsDTKRydI1q7bfkfX/247BTUn16n0WJN8xDEVsRoo0CVaEQQiea9VxzrldQ==
X-Received: by 2002:a54:4018:: with SMTP id x24mr2813412oie.222.1643758856152;
        Tue, 01 Feb 2022 15:40:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r8sm17915906oia.19.2022.02.01.15.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 15:40:55 -0800 (PST)
Received: (nullmailer pid 981764 invoked by uid 1000);
        Tue, 01 Feb 2022 23:40:54 -0000
Date:   Tue, 1 Feb 2022 17:40:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Nishanth Menon <nm@ti.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Angus Lin <Angus.Lin@mediatek.com>
Subject: Re: [PATCH v22 1/7] dt-bindings: soc: mediatek: add mtk svs
 dt-bindings
Message-ID: <YfnFBirxSnCqRDem@robh.at.kernel.org>
References: <20220127033956.24585-1-roger.lu@mediatek.com>
 <20220127033956.24585-2-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127033956.24585-2-roger.lu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 11:39:50 +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../bindings/soc/mediatek/mtk-svs.yaml        | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

