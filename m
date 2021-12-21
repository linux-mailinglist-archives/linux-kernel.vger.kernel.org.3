Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4334C47C1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhLUO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:56:36 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:35415 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbhLUO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:56:35 -0500
Received: by mail-qv1-f51.google.com with SMTP id kj16so8643814qvb.2;
        Tue, 21 Dec 2021 06:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfHUO6xtXv9Ts0W33bZQlQeeBuIG/rdx+gMNJR+vL2M=;
        b=OsaU6xQ8mIPk7bJ9yHsCqmBpUyoWBmjdH8+icDepVhuLGvFg1vQzr/LlH9LCd6Ny7a
         ew4yysVxUrbDGHQIOCB0hRS28pU1u2xdW7r1JVqJGcGuVIK2Lg90UzS9YrAinZX3zT90
         dI46W7i+Q8Q0GbSS6lInbuiMsWOOZuCPEpIW26anO0wNKX1Jy+WXjjhEBTbojRBweeih
         7yBpbFl/swQ/6q8u8EQJtM0lewaEkCD7C0H1qTq+f6s+qJC+xt/1shUanKzexNbCVQsZ
         f5IufDKOFEZHtRYAxMnpKBaA4OJOqoi1x0BPol8hNyTmsIo7q9ozo/u40ZoZuEJzUc2e
         +emg==
X-Gm-Message-State: AOAM5307UOdsGk7p8yFSlI0+Oo67UJLhQa92Il5Yaomtf5JtFV8SzYwg
        r53fJBTyN+iFnaHPvBgayg==
X-Google-Smtp-Source: ABdhPJzKvh6+eMR4c3h3MgNOzyuXugSjD5a43VT7csyUNrV/SxCwE64LUsGRc2BySZ7d5T5kol/K+Q==
X-Received: by 2002:a0c:d841:: with SMTP id i1mr2815831qvj.126.1640098594266;
        Tue, 21 Dec 2021 06:56:34 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id k1sm13044520qkh.53.2021.12.21.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:56:33 -0800 (PST)
Received: (nullmailer pid 1403641 invoked by uid 1000);
        Tue, 21 Dec 2021 14:56:32 -0000
Date:   Tue, 21 Dec 2021 10:56:32 -0400
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/2] dt-bindings: timer: sifive,clint: Group interrupt
 tuples
Message-ID: <YcHrIM9e+tSmpk8B@robh.at.kernel.org>
References: <cover.1639744468.git.geert@linux-m68k.org>
 <b2409de8943b56dfda2c972f4fe566a381be07a7.1639744468.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2409de8943b56dfda2c972f4fe566a381be07a7.1639744468.git.geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 01:38:04PM +0100, Geert Uytterhoeven wrote:
> To improve human readability and enable automatic validation, the tuples
> in "interrupts-extended" properties should be grouped using angle
> brackets.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v3:
>   - Add Reviewed-by,

Did you? ;)

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> v2:
>   - Split in two patches.
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index b75fd6f982b1ecb3..3b25ec37d81159cb 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -57,10 +57,10 @@ examples:
>    - |
>      timer@2000000 {
>        compatible = "sifive,fu540-c000-clint", "sifive,clint0";
> -      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
> -                             &cpu2intc 3 &cpu2intc 7
> -                             &cpu3intc 3 &cpu3intc 7
> -                             &cpu4intc 3 &cpu4intc 7>;
> +      interrupts-extended = <&cpu1intc 3>, <&cpu1intc 7>,
> +                            <&cpu2intc 3>, <&cpu2intc 7>,
> +                            <&cpu3intc 3>, <&cpu3intc 7>,
> +                            <&cpu4intc 3>, <&cpu4intc 7>;
>         reg = <0x2000000 0x10000>;
>      };
>  ...
> -- 
> 2.25.1
> 
> 
