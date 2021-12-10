Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0375470CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbhLJWJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:09:37 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37491 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344573AbhLJWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:09:35 -0500
Received: by mail-ot1-f53.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so11005592otg.4;
        Fri, 10 Dec 2021 14:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z0ZIWpgf+ozqCXjjJqmBIsm6dGvp4HgfAzO7q4NuCw8=;
        b=KtDlc+sPUJ/NbRI9zKayYnPAFfPFtlWDlVY3g3HPOVG53H/AknIcWt7Au14MpdiPPl
         Y8XPH1voC1okNEfeXBIxolb5uiAc59FLAlqnCINiAndWQZCly0ubHl8A5m4MXPtCbEir
         P8TbdoP1vptSLkzMMu7xSBOTHE5q5tMunqP+YtKl/IEcq52vS5xgLdWJj4MOxB95WgZa
         BIUCfmJmb1L+GllxTWfSL8d6LMK3XC2qj59XxhLMXldMaRAqIKryQ6VTBHc+2YWsaBLS
         PtgGJwodJc4gsrHqWzc5jqADGvknT+DV1SBx/SlHMJMcKnwBonnnH9RP6/OTZrsOSGEw
         75Ew==
X-Gm-Message-State: AOAM530SpMkPa2RdayqIUHFbrQf/yvNgYcBf39G7+LvSbePJoYiRsL98
        SHXx7uZlhrW5o05WQB00bg==
X-Google-Smtp-Source: ABdhPJzE1v5OmwDcvB5jsdLIarkvcrqvllmn9doaEKyiymwKfG7SjrwD4X03lykl1F1KBPo+plnVfg==
X-Received: by 2002:a9d:12c:: with SMTP id 41mr13206819otu.322.1639173960028;
        Fri, 10 Dec 2021 14:06:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y12sm1084779oiv.49.2021.12.10.14.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:05:59 -0800 (PST)
Received: (nullmailer pid 2010456 invoked by uid 1000);
        Fri, 10 Dec 2021 22:05:58 -0000
Date:   Fri, 10 Dec 2021 16:05:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     yifeng.zhao@rock-chips.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kever.yang@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-rockchip@lists.infradead.org,
        heiko@sntech.de, vkoul@kernel.org, robh+dt@kernel.org,
        kishon@ti.com, cl@rock-chips.com
Subject: Re: [RFC PATCH v4 2/4] dt-bindings: phy: rockchip: Add Naneng combo
 PHY bindings
Message-ID: <YbPPRu+KYRLFKOkD@robh.at.kernel.org>
References: <20211208185449.16763-1-jbx6244@gmail.com>
 <20211208185449.16763-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208185449.16763-3-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021 19:54:47 +0100, Johan Jonker wrote:
> From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> 
> Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V4:
>   restyle
>   remove some minItems
>   add more properties
>   remove reset-names
>   move #phy-cells
>   add rockchip,rk3568-pipe-grf
>   add rockchip,rk3568-pipe-phy-grf
> ---
>  .../phy/phy-rockchip-naneng-combphy.yaml      | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
