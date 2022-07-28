Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E028E583A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiG1IlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiG1IlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:41:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E040A4D802
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:41:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a13so1197970ljr.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=qNuYEjp7WeXIJ9ePRdLMLsHm6eHVbqcc9mreMlXusBM=;
        b=T6rixmhUatWGToZ2WePBF7ExJxbbNLXwrPSTZsIotzvYO5UME86v74npwnrBqHJPms
         fOQczzq5bJ4diI6T0lTWdkv8wfVEJerbNqKV/tO18z/j50ofdkcaeWzdwHj+ncxFJSQT
         AUby0P0gqCd6YU0W8j3j5Vd4eJ/a+hYdxtUqTAXS3bdL4EKu024EsMfCL7jGTD+Am1gJ
         td47eKhbYeglYbBBbNVwOLje5bVN6OCWtimYrifFPvKZgHZPXTS7jgAzkzfBItrupe6t
         57FGTYN1Z6g0diW+wmfqdn/cXW/eiOGxpI3ZxCKbhFRbMVIvhujaaXus1U8uCDzN0qy8
         tGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qNuYEjp7WeXIJ9ePRdLMLsHm6eHVbqcc9mreMlXusBM=;
        b=mpsiwnEzD+DVBivWXJWwzzjRQRpG5jdF1Moh6NdCz3t+ZkoIlzQiX9ALmvwLBy80Ue
         cj7JY5+FA1t6sIsmtKpJ5AwL7eNXBKTAMenS4m2WkF+pNn25ES7+UuHF8bfOL7jLP9qc
         wVaSN+HqYQ3X0bDgiM2ALjUJr6cpbjYt4Pna2jqPemErKcy/Cmrj+SmovUAKpKQC+Wo1
         NlTCQNOxNPsgqd+uCN2EUvthpiuSbu5ICLQYXAFxOZpv1L01xog9vB2JGEhm9t8QARpu
         6Lxvi8xSCx3iWoHCpyufXv4uk1QNWMLny6AMvxtXM5HqRTS8rlq2XTSrJQ7P2rCWzZGp
         sHgw==
X-Gm-Message-State: AJIora+jV5jDUzmnGbvkFq5k5rvI+IxHgLdB44jem1KwvlznMwtKg5dV
        aJcu939gcMhyZb2YgGPPmwz9Ng==
X-Google-Smtp-Source: AGRyM1sDoEXB5/FNKjHlS/zvqoBlUUeT2luECMbU/cwhNDKKkdOvFAaAuNscnU+XY5m7mUFR1n8DRg==
X-Received: by 2002:a2e:a58d:0:b0:25e:d96:3281 with SMTP id m13-20020a2ea58d000000b0025e0d963281mr5597695ljp.379.1658997665641;
        Thu, 28 Jul 2022 01:41:05 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e8e74000000b0025a724f2935sm10541ljk.137.2022.07.28.01.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 01:41:05 -0700 (PDT)
Message-ID: <82e3fd36-df96-a555-4cea-47fabd26502b@linaro.org>
Date:   Thu, 28 Jul 2022 10:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V2 1/3] dt-bindings: clk: meson: add S4 SoC clock
 controller bindings
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
References: <20220728054202.6981-1-yu.tu@amlogic.com>
 <20220728054202.6981-2-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728054202.6981-2-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 07:42, Yu Tu wrote:
> Add new clock controller compatible and dt-bindings header for the
> Everything-Else domain of the S4 SoC.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>



> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1abc53f9e91..f872d0c0c253 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1775,6 +1775,7 @@ F:	Documentation/devicetree/bindings/clock/amlogic*
>  F:	drivers/clk/meson/
>  F:	include/dt-bindings/clock/gxbb*
>  F:	include/dt-bindings/clock/meson*
> +F:	include/dt-bindings/clock/s4-clkc.h
>  
>  ARM/Amlogic Meson SoC Crypto Drivers
>  M:	Corentin Labbe <clabbe@baylibre.com>
> diff --git a/include/dt-bindings/clock/s4-clkc.h b/include/dt-bindings/clock/s4-clkc.h
> new file mode 100644
> index 000000000000..b686c8877419
> --- /dev/null
> +++ b/include/dt-bindings/clock/s4-clkc.h

Filename with vendor prefix, so:
amlogic,s4-clkc.h

> @@ -0,0 +1,146 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_S4_CLKC_H
> +#define _DT_BINDINGS_CLOCK_S4_CLKC_H
> +
> +/*
> + * CLKID index values
> + */
> +
> +#define CLKID_FIXED_PLL			1
> +#define CLKID_FCLK_DIV2			3
> +#define CLKID_FCLK_DIV3			5
> +#define CLKID_FCLK_DIV4			7
> +#define CLKID_FCLK_DIV5			9
> +#define CLKID_FCLK_DIV7			11

Why these aren't continuous? IDs are expected to be incremented by 1.

> +
> +#endif /* _DT_BINDINGS_CLOCK_S4_CLKC_H */


Best regards,
Krzysztof
