Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFA75328B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiEXLRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiEXLRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:17:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E65986ED
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:16:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m6so20499842ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xNw7LrBTg5witOvFihOmp1AXVpa1kkgs/O9ROK/zEZ4=;
        b=so+P5zIvJb4xvcv4LtGNWVQOzHBkfikB2mojxL71HaNmFT32Gwy/TrJxGjXXNJ8X4X
         gcGEzYp7IUPT4UYmGtjpICLxu25/V44WTnm2aLdi7r8k6U0gJi7eDZ+0btAIl0o7ZBAC
         cdC5VXdcwI2/kBNI9Rdib9tsyCu+GsqwPCtbDF9coIW/nAqkkouzvIj/85dhNRAFRJgC
         d2OzkotRYv00AT+/7DOUZLpbZ576Nfk5B/xzXPWf7D9A1tn2qrnTueAglVEip2b0H6Z5
         QgkAMW/1cge883ssPfkSjkvVb2lB0ClQLHh14Ew1jR+RcljdvYpKXRpTLaE5MWNS+ANB
         +bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xNw7LrBTg5witOvFihOmp1AXVpa1kkgs/O9ROK/zEZ4=;
        b=o7AdJT5zik2JiQC1JBETC+Emu1EI5UJnj3O3enxLWuGehGyPrLgE9JXoxe6tUoqLc9
         EDt4nU8nqOXbywA5H2FP0hctPrcZsnXJV3Q/1VeaQhILUrtEUCsMk8pqG4xthF3aTm3R
         JeRHVXihBItYswg9j0oMhtspKSBrtKZsY3A1XyE2gvMmj/PDUw2xukJYTLFjCa1QsfyN
         Z07pw/VC3ju6UUzQq2DRYLrkIRWHW3z13jrTmAJWk0EnSlA/xbRxHwkcrF92ltA+bzB7
         ktXdR75cR3uOX7yyT2TURfQeGm0pOWdqrBErztzOwRNuLju+F10gI4x6ezl7kAWPmxbZ
         7NMw==
X-Gm-Message-State: AOAM533ufCYcP7Y6++5drmwI4rKctJW5k390t+yzg+WtG8cF8hxx/nsT
        GMPXdxjl+8rZ7jUZDv/zPzGSgg==
X-Google-Smtp-Source: ABdhPJz+lx+iMVXCLSd0N+qqf6vPl237rq1dEPT3DWIOqNMRqpMCyclgt7wE8RtUgZVGeOnk1rv2bQ==
X-Received: by 2002:a2e:1614:0:b0:253:d71b:cf6d with SMTP id w20-20020a2e1614000000b00253d71bcf6dmr14147086ljd.80.1653391004531;
        Tue, 24 May 2022 04:16:44 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id u1-20020ac24c21000000b0047255d2118csm2486056lfq.187.2022.05.24.04.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 04:16:44 -0700 (PDT)
Message-ID: <027c4fd9-194d-79c9-2ebe-e7bd1824b313@linaro.org>
Date:   Tue, 24 May 2022 13:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
 <20220523113029.842753-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220523113029.842753-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 13:30, Peng Fan (OSS) wrote:

One more comment.

> diff --git a/include/dt-bindings/power/imx93-power.h b/include/dt-bindings/power/imx93-power.h
> new file mode 100644
> index 000000000000..27fb7df80f93
> --- /dev/null
> +++ b/include/dt-bindings/power/imx93-power.h

File name with vendor, so "fsl,imx93-power.h"

> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + *  Copyright 2022 NXP
> + */
> +
> +#ifndef __DT_BINDINGS_IMX93_POWER_H__
> +#define __DT_BINDINGS_IMX93_POWER_H__
> +
> +#define IMX93_POWER_DOMAIN_MEDIAMIX		0
> +
> +#endif


Best regards,
Krzysztof
