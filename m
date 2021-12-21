Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C878347C61A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbhLUSOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:14:46 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:37690 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbhLUSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:14:36 -0500
Received: by mail-qk1-f170.google.com with SMTP id m186so13397465qkb.4;
        Tue, 21 Dec 2021 10:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZh3Qpd5SvcqUEcT4y52L9C1fd8K8ht/Ht2rKQMnZjA=;
        b=2le176EVEyP0SuNIq4HFWzj8b8PvR7z2k/GuCucaLgK4/artjHfyy5+IHJ/WNtDcoL
         8elzBVMt6b8Q8F/u5b8+4J5y3jW85b8MLyiIVRUoqo4FmmdgyXQ7zBTocumVohT7ewJT
         7n2pL4zVd7R/O40+7GyThIaGtrE5yv9G1yX+GrUCsOIeRTim82fsXKAy/L/KUQloR/b5
         QO5flTyfRHlBHskLHxgG4Aztx7FIqRpfQeyFuBP94CC/fEFx4eKJGHqF2AN3p0KGDEy+
         ybR3Wo14w0RbLEt9I2ckkiC3/7UYlMfNwhhaK3kbHFiEv6jgsv3fCLvdgELpwgz2EpEV
         3afw==
X-Gm-Message-State: AOAM532VkJJdu/mD/jLTZ/apyWAUQDnaiMFloy4NH4kOCWqNzpiz/l3f
        S6YvLsImmddAUewuputLbg==
X-Google-Smtp-Source: ABdhPJw/vwQnHfFXE5Kgv5iAOXOBqrO6DxVee4i4XIzMBK7qyJ5XdnnCecKYFFLszmdnzt2n50BYFw==
X-Received: by 2002:a05:620a:e0e:: with SMTP id y14mr2856584qkm.760.1640110476023;
        Tue, 21 Dec 2021 10:14:36 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id e15sm325541qtq.83.2021.12.21.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:14:35 -0800 (PST)
Received: (nullmailer pid 1521054 invoked by uid 1000);
        Tue, 21 Dec 2021 18:14:32 -0000
Date:   Tue, 21 Dec 2021 14:14:32 -0400
From:   Rob Herring <robh@kernel.org>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v1 1/2] dt-bindings:pwm:Add bindings doc for Sunplus SoC
 PWM Driver
Message-ID: <YcIZiFvyo+N4ai7r@robh.at.kernel.org>
References: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639741568-5846-2-git-send-email-hammer.hsieh@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639741568-5846-2-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 07:46:07PM +0800, Hammer Hsieh wrote:
> Add bindings doc for Sunplus SoC PWM Driver
> 
> Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>

The author email and S-o-b must match.

> ---
>  .../devicetree/bindings/pwm/pwm-sunplus.yaml       | 45 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> new file mode 100644
> index 0000000..9af19df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-sunplus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SoC PWM Controller
> +
> +maintainers:
> +  - Hammer Hsieh <hammer.hsieh@sunplus.com>
> +
> +properties:
> +  '#pwm-cells':
> +    const: 2
> +
> +  compatible:
> +    items:
> +      - const: sunplus,sp7021-pwm
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
> +  - '#pwm-cells'
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm: pwm@9c007a00 {
> +      #pwm-cells = <2>;
> +      compatible = "sunplus,sp7021-pwm";
> +      reg = <0x9c007a00 0x80>;
> +      clocks = <&clkc 0xa2>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f9a84..721ed79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18242,6 +18242,11 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS PWM DRIVER
> +M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> -- 
> 2.7.4
> 
> 
