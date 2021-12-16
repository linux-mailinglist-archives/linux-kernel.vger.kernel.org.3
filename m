Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D6A477D04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbhLPUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:06:01 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:37617 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhLPUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:06:00 -0500
Received: by mail-oo1-f47.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so69428oov.4;
        Thu, 16 Dec 2021 12:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/i1QfoNP41D0v1l+fFljT7XuXIUpeAfbgQOkVLC7ZQ=;
        b=SH46dkEJX943KITLe1oKYtYE6odMEHYivPm6x1HX460jP2ReHNas9ndtv4+l5pp1GR
         63I4/z70tbKx0Xzdyugd7clR9jfnJPV0sprsMEYj3Uk3qgLgahSnV3sYSCd2J3BMNJvK
         hiqy3wfm7A2qOKGRFM29+Tf0AXq54Sl+cgKpjRW1SNFjFbo8SrO74jpjpvucyyiEnfja
         LCyjlfKuEW/aj3jPt0qRTzqWfxi4vMRlBFfEZQ91T1Yta9NLz65qiIfQDbSUSDZ2/Qyc
         vV1/EXvz77xGbyppYrp1vTGJmCP24WrSb9VetIbke93VgIwcWKlSE9pSHVreencE5cy1
         GujQ==
X-Gm-Message-State: AOAM532zb3uXn5EKgsUxrp34khaKSlt0m0y2MG98hDilU7f0x8Fabq3s
        Qc5IKhzbGEp/pbogOApXf62+K/sjyw==
X-Google-Smtp-Source: ABdhPJyIw1usEhvXLNgoSg9c6ablaAifSOIE8K5INypzYK8aFSlXK/cLXjMz17LxL9hv8hPFxX110Q==
X-Received: by 2002:a4a:db77:: with SMTP id o23mr12240152ood.15.1639685158510;
        Thu, 16 Dec 2021 12:05:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f20sm1257735oiw.48.2021.12.16.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:05:57 -0800 (PST)
Received: (nullmailer pid 662296 invoked by uid 1000);
        Thu, 16 Dec 2021 20:05:56 -0000
Date:   Thu, 16 Dec 2021 14:05:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiantao Hu <xt.hu@cqplus1.com>
Cc:     wim@linux-watchdog.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, qinjian@cqplus1.com
Subject: Re: [PATCH v3 1/2] dt-bindings: watchdog: Add bindings doc for
 Sunplus SP7021
Message-ID: <YbucJFI0um3zjKVl@robh.at.kernel.org>
References: <20211215101831.256667-1-xt.hu@cqplus1.com>
 <20211215101831.256667-2-xt.hu@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215101831.256667-2-xt.hu@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 06:18:30PM +0800, Xiantao Hu wrote:
> Add bindings documentation for Sunplus SP7021 SoC.
> 
> Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>
> ---
> Changes in v3:
>  - removed second reg source. The registers are not used in the driver.

Use by a driver doesn't matter. If they are part of the h/w, put them in 
the binding.

> 
>  .../bindings/watchdog/sunplus,sp7021-wdt.yaml | 45 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> new file mode 100644
> index 000000000..033e2f599
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/sunplus,sp7021-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SoCs Watchdog Device Tree Bindings
> +
> +maintainers:
> +  - XianTao Hu <xt.hu@cqplus1.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    watchdog: watchdog@9c000630 {
> +        compatible = "sunplus,sp7021-wdt";
> +        reg = <0x9c000630 0x08>;
> +        clocks = <&clkc 0x24>;
> +        resets = <&rstc 0x14>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0bca0de0..c2ba65155 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17933,6 +17933,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS WATCHDOG DRIVER
> +M:	Xiantao Hu <xt.hu@cqplus1.com>
> +L:	linux-watchdog@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> -- 
> 2.33.1
> 
> 
