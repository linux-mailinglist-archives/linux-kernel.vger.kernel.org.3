Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AB5542D39
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiFHKYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbiFHKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:23:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADE1F48B4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:11:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v25so26399079eda.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mygdx+EWNce3HPDkrN+VDocEDtdpxehguvhwMJDyyeI=;
        b=PAAKqLB62Hf/CGzyWWAYkLIyFRIVbTaQknYin4XTddJKhLILqUaH/h+ROZBMEzpWG9
         QvZNQgojCeVWEyVWWvz52S0tjhNRD5zUpMdD+SSF4PFZw4Kzmfa3vqiqt3HVjg/mIEgA
         CUgcFu3b8gEdphdAFko5DtnElqBmE4T0Uk7F2XTl9/goXCdVZaoGEOgKv7QEO7Nhvoqh
         ZtZx8/7BFoPuNznm/pVcXHiHxsqKTyH5/8i39BW8eM4qLIm/hxWdIsb5PmO+oNG5mqbI
         3j5K3G0lMJISK4JnFAKs+uO/4kFyh4MSo16lSqaiAMgTjLW3UcBytzBo1km+4BzgDKWo
         7hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mygdx+EWNce3HPDkrN+VDocEDtdpxehguvhwMJDyyeI=;
        b=fZ4IohN2NLrzOBo+iCYRmwED9TXbS3CqN53rJQSFOP1hdRmP1dKN9ZKOhazQUbRAX2
         pYmzNXrRzY2Tmqj9NLa8qUmbu0sJN5UqZcopvWxbBnFxbOLIJDBC6nIK0DmM4kwxfHWa
         bQaLrVzqgbnMAcMwtOi0bm6ZUuOa76PjQUgbiad/YjAxSEGbUs9oVcoEOmnnsfrwqZiO
         XsdkV0EpizNNwj1DeZNeHLaOhyYYs5CJhyc8Lh4D6lmtc9goVUy/KTCNcaAH0RepaZw2
         MZfbZJXkwllxk49/glJdd2e6VTPgvCwWj71aMOev6td1W0WIvO6Fl7/5WyrzoXLY/C9F
         16aQ==
X-Gm-Message-State: AOAM531hhykIDdmWKGgeYzIU6wZ4OtESOgjobaWxlCzbuHKr8WhIMYAf
        SPDk8BPfc7u/sEbHFNaAJp/30g==
X-Google-Smtp-Source: ABdhPJz6yzZ0SRBcoSfjLq/PRs3lNBoAcpo1IGSW4puqEJVVItF1fjdsK3KOv8VpyJU205TN8zsZrA==
X-Received: by 2002:aa7:d6d5:0:b0:431:b7c0:50c9 with SMTP id x21-20020aa7d6d5000000b00431b7c050c9mr4115115edr.62.1654683105981;
        Wed, 08 Jun 2022 03:11:45 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m26-20020a50ef1a000000b0042bae6fbee2sm11815721eds.74.2022.06.08.03.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:11:45 -0700 (PDT)
Message-ID: <add025b6-c622-b204-d39e-67b31878d37f@linaro.org>
Date:   Wed, 8 Jun 2022 12:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 12/20] dt-bindings: reset: npcm: Add support for
 NPCM8XX
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-13-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220608095623.22327-13-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 11:56, Tomer Maimon wrote:
> Add binding document and device tree binding
> constants for Nuvoton BMC NPCM8XX reset controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/reset/nuvoton,npcm-reset.yaml    |  13 +-
>  .../dt-bindings/reset/nuvoton,npcm8xx-reset.h | 128 ++++++++++++++++++
>  2 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> index c6bbc1589ab9..93ea81686f58 100644
> --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> @@ -9,9 +9,20 @@ title: Nuvoton NPCM Reset controller
>  maintainers:
>    - Tomer Maimon <tmaimon77@gmail.com>
>  
> +description: |
> +  The NPCM reset controller used to reset various set of peripherals. 
> +  Please refer to reset.txt in this directory for common reset
> +  controller binding usage.
> +
> +  For list of all valid reset indices see
> +    <dt-bindings/reset/nuvoton,npcm7xx-reset.h> for Poleg NPCM7XX SoC,
> +    <dt-bindings/reset/nuvoton,npcm8xx-reset.h> for Arbel NPCM8XX SoC.
> +
>  properties:
>    compatible:
> -    const: nuvoton,npcm750-reset
> +    enum: 
> +      - nuvoton,npcm750-reset        # Poleg NPCM7XX SoC
> +      - nuvoton,npcm845-reset        # Arbel NPCM8XX SoC
>  
>    reg:
>      maxItems: 1
> diff --git a/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> new file mode 100644
> index 000000000000..5b3b74534b50
> --- /dev/null
> +++ b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Again - ignored comment from v1.

> +/*
> + * Copyright (c) 2022 Nuvoton Technology corporation.
> + * Author: Tomer Maimon <tmaimon77@gmail.com>
> + */
> +
> +#ifndef _DT_BINDINGS_NPCM8XX_RESET_H
> +#define _DT_BINDINGS_NPCM8XX_RESET_H
> +
> +/* represent reset register offset */
> +#define NPCM8XX_RESET_IPSRST1		0x20
> +#define NPCM8XX_RESET_IPSRST2		0x24
> +#define NPCM8XX_RESET_IPSRST3		0x34
> +#define NPCM8XX_RESET_IPSRST4		0x74
> +
> +/* Reset lines on IP1 reset module (NPCM8XX_RESET_IPSRST1) */

Again - ignored comment from v1. My last message was quite clear, wasn't it?

https://lore.kernel.org/all/4a69902f-a545-23a1-1430-e5ece16997e9@linaro.org/

You ignored several of previous comments, so:

NAK.

Best regards,
Krzysztof
