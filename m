Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49E4C3F44
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiBYHr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiBYHrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:47:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C4B4581
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:46:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d28so3144813wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=oKlddMOdoBQpHXORVm/dprXUDfrOkRgmeBsrcJHm1bw=;
        b=m2RaanlztnHpMkrKbTVH4cK8XTyZDBISo1kMKyf9MDpdwNDKeGoIAB/DzRaX99gM2t
         O+PlMP+fcc1TawEsM38iZgp654X0Wa2mQlW6b2g78ro4Blf65NCjB5JH06cFrU9r7SwM
         IWVVC8hPd5AG6n1hqKlW6hwtFUA7dYe3bgfPVQGvPjXVg8zULslMhrZU+sJB4w3JStME
         3P/fWZD1kVJwuIhH5hEnlZtTziYi1F+xBgumtdhufVA7HdfpyhM0hPUNDDJASG+oK+vG
         Bq3GAMwG95X2fdTheyLubB65xJqysSaY+cnuqW+LTy4fePMaDUozEZ4WndiWNrP7G0av
         dGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=oKlddMOdoBQpHXORVm/dprXUDfrOkRgmeBsrcJHm1bw=;
        b=5ZSG/VZvZIbytwEURkVr6pOzPM7cNwJdkGqCaMSNpWrTEAEonnlbuH/WTaMIot1tL/
         3XtjKtTgVJohtOGTFVx/mmedCAUWBas33Tm4wOD5C9y4LKh+Z5yMbU3NlVUHN8Rljh18
         NlefOMq1VUtvw7CIFNzAdsHfDImQH+X3A4KGO6bOchk/gyPnc0PDdbCWtF09xVWy9VT7
         qqqctIXdxGbsuSA3j84GJJFlttvyX15pCsK/y1ADP4PpRGigc0QvVIF8BE1cuYn0mL6Q
         4bWOycd6+z192OOHseZ1ufKbJ4vw1HeIH5R7xeiK7pFwobtZG7y2iEcsqsOdaACrSiuW
         LxMA==
X-Gm-Message-State: AOAM532RWXVX9hLd5re0NnKLZ8MTI+c3PWjfHt3K2zPkbPnwHrstG4N4
        T5CRVe4czS0tHbq9Pttt7jBxhQ==
X-Google-Smtp-Source: ABdhPJwWKlGDm8gsTQCIae+e+5zK2D2UI0JFQX/0+5DWZfLMtz1nTxwmfso/Qihyewj5DILPqcJNzQ==
X-Received: by 2002:adf:bbc4:0:b0:1ee:f2d4:2f75 with SMTP id z4-20020adfbbc4000000b001eef2d42f75mr3458910wrg.701.1645775210360;
        Thu, 24 Feb 2022 23:46:50 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:5e3f:6e2c:a7c1:38f1? ([2001:861:44c0:66c0:5e3f:6e2c:a7c1:38f1])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b00380f8be8ceesm4841753wmd.20.2022.02.24.23.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 23:46:49 -0800 (PST)
Message-ID: <905e3d32-43dc-7073-36ce-ab39bf7c6f0a@baylibre.com>
Date:   Fri, 25 Feb 2022 08:46:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4 1/2] dt-bindings: power: add Amlogic s4 power domains
 bindings
Content-Language: en-US
To:     Shunzhou Jiang <shunzhou.jiang@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, jianxin.pan@amlogic.com,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220225064455.1369197-1-shunzhou.jiang@amlogic.com>
 <20220225064455.1369197-2-shunzhou.jiang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220225064455.1369197-2-shunzhou.jiang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/02/2022 07:44, Shunzhou Jiang wrote:
> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
> 
> The bindings targets the Amlogic s4, in which the power domains registers
> are in secure world.
> 
> Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>

Please keep along revisions the Reviewed-by/Acked-by/Tested-by from previous reviews like the one from https://lore.kernel.org/r/CAFBinCBN-QoA-e9JzfUq-Wc4Chu=x6cVoP2SYf=q-GrnLdLGKg@mail.gmail.com

And please CC devicetree@vger.kernel.org to have a proper review from the Rob Herring, without a proper review from Rob I can't take it.

Neil

> ---
>   .../power/amlogic,meson-sec-pwrc.yaml         |  3 ++-
>   include/dt-bindings/power/meson-s4-power.h    | 19 +++++++++++++++++++
>   2 files changed, 21 insertions(+), 1 deletion(-)
>   create mode 100644 include/dt-bindings/power/meson-s4-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> index 5dae04d2936c..7657721a4e96 100644
> --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -12,13 +12,14 @@ maintainers:
>     - Jianxin Pan <jianxin.pan@amlogic.com>
>   
>   description: |+
> -  Secure Power Domains used in Meson A1/C1 SoCs, and should be the child node
> +  Secure Power Domains used in Meson A1/C1/S4 SoCs, and should be the child node
>     of secure-monitor.
>   
>   properties:
>     compatible:
>       enum:
>         - amlogic,meson-a1-pwrc
> +      - amlogic,meson-s4-pwrc
>   
>     "#power-domain-cells":
>       const: 1
> diff --git a/include/dt-bindings/power/meson-s4-power.h b/include/dt-bindings/power/meson-s4-power.h
> new file mode 100644
> index 000000000000..462dd2cb938b
> --- /dev/null
> +++ b/include/dt-bindings/power/meson-s4-power.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> +/*
> + * Copyright (c) 2021 Amlogic, Inc.
> + * Author: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
> + */
> +
> +#ifndef _DT_BINDINGS_MESON_S4_POWER_H
> +#define _DT_BINDINGS_MESON_S4_POWER_H
> +
> +#define PWRC_S4_DOS_HEVC_ID	0
> +#define PWRC_S4_DOS_VDEC_ID	1
> +#define PWRC_S4_VPU_HDMI_ID	2
> +#define PWRC_S4_USB_COMB_ID	3
> +#define PWRC_S4_GE2D_ID		4
> +#define PWRC_S4_ETH_ID		5
> +#define PWRC_S4_DEMOD_ID	6
> +#define PWRC_S4_AUDIO_ID	7
> +
> +#endif

