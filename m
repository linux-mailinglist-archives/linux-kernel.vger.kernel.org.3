Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2464D5E75
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbiCKJdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347497AbiCKJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:33:39 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9328C1CFCE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:32:33 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 73B7D3F312
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646991152;
        bh=xIzYRU2oNWdduxoY6MvZtjPiNpiB0Z8z/sKuAw0C2qc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=G25XzcX9UzWc6Fer2I4w/TXp+eRIN428xF2+P4x8/tSpHnwJkB6Pd+3+G7D2s0wMM
         U0A2uH/ZFZJ6EU4CsIKIeJaI2VSYbMYx3GuY/Ia+dKv8NPZFeMqjOE5Fp29yb8IZkG
         rTrMGl7pGl/GqMDVdA6Y0E+JVEVkDMber9Xc5gaZ+3uRVvPbkDNS6FjyZYhch7UwVj
         2pJUKnx4IkHyZWr9SqolCI5mmxDwbvv2u9Lc00YwY5xvh0X8Mhtu+zMr57sehekM1i
         yRXSDislJ1nU7KHueRrsPE+8TFdN/lx3c08lh24aZVi8WIN5O7EavSt5f3i9AIBvFF
         sxoKghVyClESw==
Received: by mail-ej1-f70.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so4597416ejw.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xIzYRU2oNWdduxoY6MvZtjPiNpiB0Z8z/sKuAw0C2qc=;
        b=XGo62Z4w9ZOFk5vNeJz+pjn7tDEyHNinYxqw6ftHvucPHTSUZU6Wk8dhZ7sCE8WUHd
         LSbpa0xyKyPy2e7NZ1sRkb82uJ0z+yTs/fL4W0IbE14Rnrrt4pV/zkpRNQJ0yCSLFWdB
         NNRfQbFGcKymEboNmcNbX0oEvdXC6N/2ZfpCmP+ITm4o6GYWPY8+sTO8HT6oPggwgsme
         nPlWR2t47fMd23cFAFMTnfKLCftI5HQsAEIDJMVxCov7ev4mw3vDffneKjCyZeSk6PXq
         9UTFmwFGVNdCxaWHsAoTtJuJe7y92Pw/fRjmvm3U2yA7RmOVXV/DuAimgMfsQSm6jiPK
         Rcmw==
X-Gm-Message-State: AOAM532O183PpMr4D/Fea9tavLMSxGwieVmgjIWnX6HSfNAZIYpBisur
        Rh02a2Fg5gT+CavHGu8zkaKycZ26rpvqDKwt6E0iBHlrfMuOkvz6O1dxz8q0lyG2QqaeG03xpWS
        pyde4W2j95vKiLfucxVpCO391wRV8ywy0QudgpJY/5A==
X-Received: by 2002:a05:6402:34cc:b0:416:63d6:1891 with SMTP id w12-20020a05640234cc00b0041663d61891mr7996167edc.308.1646991150508;
        Fri, 11 Mar 2022 01:32:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzX2m7ZAd6ngYFL+n2qedTYPcIn/4wYe/mTYx/piDEGTAZtBCO5d8BOoN6DOIlkEyqV0b8CMg==
X-Received: by 2002:a05:6402:34cc:b0:416:63d6:1891 with SMTP id w12-20020a05640234cc00b0041663d61891mr7996145edc.308.1646991150320;
        Fri, 11 Mar 2022 01:32:30 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm2734617ejb.194.2022.03.11.01.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:32:29 -0800 (PST)
Message-ID: <aa65e94f-eaff-0646-8f07-c0ba0cf9abd1@canonical.com>
Date:   Fri, 11 Mar 2022 10:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/10] dt-bindings: timer: Add HPE GXP Timer Binding
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-5-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310195229.109477-5-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 20:52, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Creating binding for gxp timer in device tree hpe,gxp-timer
> Although there are multiple times on the SoC we are only
> enabling one at this time.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ----
> 
> v2:
>  *Removed maintainer change from patch
>  *Verified there was no compilation errors
>  *Added reference code in separate patch of patchset
> ---
>  .../bindings/timer/hpe,gxp-timer.yaml         | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> new file mode 100644
> index 000000000000..1f4e345c5fb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/hpe,gxp-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP TIMER
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-timer
> +
> +  reg:
> +    items:
> +      - description: T0CNT register
> +      - description: T0CS register
> +      - description: TIMELO register
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: The frequency of the clock that drives the counter, in Hz.

Which clock is it? Generated inside the timer? If outside, why driver
does not take the reference to it and uses clk_get_rate()?

Best regards,
Krzysztof
