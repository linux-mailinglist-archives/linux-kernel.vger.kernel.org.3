Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F55A5715EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiGLJkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiGLJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:40:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A588CEA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:40:38 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o12so6606942ljc.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=+qkfPlCxqbG9qhgmJwcaiOZdFi09fLFwfAcMTyA0/dc=;
        b=Cp5V6ic8+iXNW0gpQPXNWkZGKPNpR5qcuZWGSQTQpjHWgYR97zHZ4yVixyEO+8AqQY
         BDRKCgnwhou+j14dllE0e8aTfqWfIMX3ByM/nPHClWbPuvEVBb+vvbf4bNN/WFVf9jgq
         BfbkQCwUOQnSqoTOt7haVyJSIk7cmSeZ63IZ7mXWMLW3z25y16QmiSHuGLuUz+TNSWMb
         KYNTr0AtYJFiH/kacbYcE4AUaFGedq/jnl6CQiXk5jMdoGHrSPOnBKj6q8Q+VcFjjTOZ
         STQcWjh6ehL3VBN1Fp2Gi2eIBk8fHO2FVMvOLmmiuTMxir8Aotb8v1ki3073Imwk0V8+
         ICaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+qkfPlCxqbG9qhgmJwcaiOZdFi09fLFwfAcMTyA0/dc=;
        b=wnvUeRQO5oPexDsGbgLnWUIdkqN9AgZC+Plr+VcMZgAsA/RNGN1fcVX0JXTBPtc+jO
         T7kasQoi6urFjMNCybO0sLhXx0efIjZ9tIOTQV3rRp3eVEZyTyOiKcpinIWSI9wn0uXP
         0zO2x84hDm4f0S6VRChKl7WqmJEpQ+K1+l3yHVPEv05XFGcOCmbKAIVNklLC15CCWnws
         QixbbrwI5OzA972gYLpnz/fa8tXcfwZFEVX9qWZ1236yhk5XirRPdURSofoPWEkhIIL+
         RI0+l5ySZQuJEW7sxgmBwd4V/Fd0fjnQYLBLQlXXwWpTzzaUG1EpTNCKiDetZcUvy0ty
         jHUw==
X-Gm-Message-State: AJIora/u9sc+kFB2GPQm7RtKFoDGtv0i2C9Ijl5fX9ZnUz8QQtneZf6m
        +VEvQZpMCw35bk3z5fe4pFb0gw==
X-Google-Smtp-Source: AGRyM1vv/Ki6opySk8sYVUy+JwlZPDRRGxZPc2h0jjpQjs8Nsi3a3cth7n+hXa8lU5/cRpQhhKPg4A==
X-Received: by 2002:a2e:aa8e:0:b0:25d:5ac8:854d with SMTP id bj14-20020a2eaa8e000000b0025d5ac8854dmr11740857ljb.324.1657618836591;
        Tue, 12 Jul 2022 02:40:36 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id v14-20020ac2560e000000b0047fae90bfb4sm2083581lfd.56.2022.07.12.02.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:40:36 -0700 (PDT)
Message-ID: <b7a33482-9bce-7ab1-43cb-3c93a5282490@linaro.org>
Date:   Tue, 12 Jul 2022 11:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: clk: meson: add S4 SoC clock controller
 bindings
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220708062757.3662-1-yu.tu@amlogic.com>
 <20220708062757.3662-2-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220708062757.3662-2-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 08:27, Yu Tu wrote:
> Add new clock controller compatible and dt-bindings header for the
> Everything-Else domain of the S4 SoC.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
>  MAINTAINERS                                   |   1 +
>  include/dt-bindings/clock/s4-clkc.h           | 354 ++++++++++++++++++
>  3 files changed, 356 insertions(+)
>  create mode 100644 include/dt-bindings/clock/s4-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> index 7ccecd5c02c1..301b43dea912 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> @@ -12,6 +12,7 @@ Required Properties:
>  		"amlogic,g12a-clkc" for G12A SoC.
>  		"amlogic,g12b-clkc" for G12B SoC.
>  		"amlogic,sm1-clkc" for SM1 SoC.
> +		"amlogic,s4-clkc" for S4 SoC.
>  - clocks : list of clock phandle, one for each entry clock-names.
>  - clock-names : should contain the following:
>    * "xtal": the platform xtal
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1abc53f9e91..e4ca46c5c8a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1775,6 +1775,7 @@ F:	Documentation/devicetree/bindings/clock/amlogic*
>  F:	drivers/clk/meson/
>  F:	include/dt-bindings/clock/gxbb*
>  F:	include/dt-bindings/clock/meson*
> +F:	include/dt-bindings/clock/s*
>  
>  ARM/Amlogic Meson SoC Crypto Drivers
>  M:	Corentin Labbe <clabbe@baylibre.com>
> diff --git a/include/dt-bindings/clock/s4-clkc.h b/include/dt-bindings/clock/s4-clkc.h
> new file mode 100644
> index 000000000000..8b46d54d79fe
> --- /dev/null
> +++ b/include/dt-bindings/clock/s4-clkc.h
> @@ -0,0 +1,354 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#ifndef __S4_CLKC_H
> +#define __S4_CLKC_H

Use header guards mathcing paths. See other files for examples.

> +
> +/*
> + * CLKID index values
> + */
> +
> +#define CLKID_PLL_BASE			0
> +#define CLKID_FIXED_PLL_DCO		(CLKID_PLL_BASE + 0)

Drop CLKID_PLL_BASE

> +#define CLKID_FIXED_PLL			(CLKID_PLL_BASE + 1)

ditto... and so on.


Best regards,
Krzysztof
