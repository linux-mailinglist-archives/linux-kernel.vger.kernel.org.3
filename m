Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59CE48BCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348176AbiALCFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:05:16 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36396 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348165AbiALCFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:05:14 -0500
Received: by mail-oi1-f169.google.com with SMTP id r138so1579548oie.3;
        Tue, 11 Jan 2022 18:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7yYE6Cs10Esq3OViO3ltPRe5e9ugTO3WijsMpNxMlOs=;
        b=8NpJ2KX0D5iwWMd8MGVf9Wianv2d1N81eZgeimpbY69I/FSOjgtVix4ZYNvsRSegod
         n/+4Y4VonjzO6V/mqb/tDUnqjGBtaMz7pXLbyvkoxfkMB4CBGC3w+56a/kbSiqM0bu/q
         NNKWODwrWWOiS/2y2OIszGiWaRAeovzDwnFcvNdJ4PtYWK4JbsnjA2L8NRi0z+z9O86L
         zDfDdfCzxTy9itfvad3t4nEnPa+YnGoKxreqPQTGpHIa3LrnnVENM7kjJKdvBpgJjw4M
         r5F7QQyIcdbaF8JOKDE94s+2FZLlGhjOBr622RR+ihhYhLqekuvIdTh2eUSH+WZ+KMad
         2Z7g==
X-Gm-Message-State: AOAM530XaoX2Gc40UWOn2jaN6QlKLQX7pRc4siY4fFNxrmV/NNoKmyRs
        ryKtUPiPPbAhDme5hs3Wyg==
X-Google-Smtp-Source: ABdhPJwZSetCrwyoCTRuxp0BWKa6Ycop3qtlZUE4Xdi6xWhx3gEMoXb6UUGZRi5pGMZWrEgL2mwrhQ==
X-Received: by 2002:a05:6808:1710:: with SMTP id bc16mr3653978oib.179.1641953113423;
        Tue, 11 Jan 2022 18:05:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t26sm1998929oic.51.2022.01.11.18.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:05:12 -0800 (PST)
Received: (nullmailer pid 3920878 invoked by uid 1000);
        Wed, 12 Jan 2022 02:05:11 -0000
Date:   Tue, 11 Jan 2022 20:05:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v1 1/2] dt-bindings: power: Add MT8186 power domains
Message-ID: <Yd43V1woRMAcXOfS@robh.at.kernel.org>
References: <20220108131953.16744-1-chun-jie.chen@mediatek.com>
 <20220108131953.16744-2-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108131953.16744-2-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 09:19:52PM +0800, Chun-Jie Chen wrote:
> Add power domains dt-bindings for MT8186.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      |  1 +
>  include/dt-bindings/power/mt8186-power.h      | 32 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8186-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index d6ebd77d28a7..135c6f722091 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -26,6 +26,7 @@ properties:
>        - mediatek,mt8167-power-controller
>        - mediatek,mt8173-power-controller
>        - mediatek,mt8183-power-controller
> +      - mediatek,mt8186-power-controller
>        - mediatek,mt8192-power-controller
>        - mediatek,mt8195-power-controller
>  
> diff --git a/include/dt-bindings/power/mt8186-power.h b/include/dt-bindings/power/mt8186-power.h
> new file mode 100644
> index 000000000000..ca8ea2d24801
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8186-power.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license please.

> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8186_POWER_H
> +#define _DT_BINDINGS_POWER_MT8186_POWER_H
> +
> +#define MT8186_POWER_DOMAIN_MFG0			0
> +#define MT8186_POWER_DOMAIN_MFG1			1
> +#define MT8186_POWER_DOMAIN_MFG2			2
> +#define MT8186_POWER_DOMAIN_MFG3			3
> +#define MT8186_POWER_DOMAIN_SSUSB			4
> +#define MT8186_POWER_DOMAIN_SSUSB_P1			5
> +#define MT8186_POWER_DOMAIN_DIS				6
> +#define MT8186_POWER_DOMAIN_IMG				7
> +#define MT8186_POWER_DOMAIN_IMG2			8
> +#define MT8186_POWER_DOMAIN_IPE				9
> +#define MT8186_POWER_DOMAIN_CAM				10
> +#define MT8186_POWER_DOMAIN_CAM_RAWA			11
> +#define MT8186_POWER_DOMAIN_CAM_RAWB			12
> +#define MT8186_POWER_DOMAIN_VENC			13
> +#define MT8186_POWER_DOMAIN_VDEC			14
> +#define MT8186_POWER_DOMAIN_WPE				15
> +#define MT8186_POWER_DOMAIN_CONN_ON			16
> +#define MT8186_POWER_DOMAIN_CSIRX_TOP			17
> +#define MT8186_POWER_DOMAIN_ADSP_AO			18
> +#define MT8186_POWER_DOMAIN_ADSP_INFRA			19
> +#define MT8186_POWER_DOMAIN_ADSP_TOP			20
> +
> +#endif /* _DT_BINDINGS_POWER_MT8186_POWER_H */
> -- 
> 2.18.0
> 
> 
