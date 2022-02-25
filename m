Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603974C4AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243100AbiBYQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbiBYQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:37:52 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C31110;
        Fri, 25 Feb 2022 08:37:19 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so6878671oos.9;
        Fri, 25 Feb 2022 08:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+CnsTOnDIJmDrNcQ9nVz49RWIRwJjG5a52upp/7BFmQ=;
        b=H4CGbDmty7EZw/ad487z4dM+dubS0VP05GzroPoY/FEPfOW3uYU2f0pcTJNNFiauDe
         Vm+X6sxubeSPnWOpPstKfOPKnOi0EnIoQE706y9/DgNMy1dZAuCqc2NURCnjk+wvG9pM
         qCBPDJJWMkthBekfl49oocDu23Fqayp8+sikC+duVIXhetO1X+vimcuUJPMfQFWQ88HB
         HTLprGxRhDlLcTQg69gOtzg9V/lbdmdXfCkEAaZGt9nQ64ZeIczg6OJ8uaYF2z6Uaqve
         3ky3t2DCHhxNKlm+utiTLxT8BKd8A0p3SJ3NLCYJ1SIPD6qYJKOpLJIZ2xg8yVVRxW35
         /ZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+CnsTOnDIJmDrNcQ9nVz49RWIRwJjG5a52upp/7BFmQ=;
        b=Vpi/IpkHENhmA2wloRNMtbuiXbdSbwhewCrk0si+flEIzR2yzbbne1WTpKzSJlCU/+
         ALWLIhOsTMtRgMREJePxefRSc1QlSkJAdMmpc/jjhr0Zmddka4iOzmpiwkfr4RMphA50
         iA5nopiyKPwafGzzPI6cff4lt08/PbIsHE+EbsuWdaR0UT5JEGx+eXGM3cJG4LxdWph1
         zGGUx6kkM8Q5cXn1sQiO/wvhTORSWvirVPmj+url46kb1HRBcUZSVQClVEQ/WtDTo8u1
         0aoVh5CB3WI2milQckqUwq0semK7QRdegdMXwSzyBn5pTWwoA19qWTdfe4ShJVEPM1Mi
         extw==
X-Gm-Message-State: AOAM532JDgTR4sgma9fwQdS7MSGFOX1opkQq8+GP0+hSFaHEivPNRbsl
        9+NCzyQ2izMpmhZoclDmnbk=
X-Google-Smtp-Source: ABdhPJzZYQI8AhCr2LAlApfBhaQyy3zwuH9AFQj6H1d1talFInZKbk7s4QTyhYD7Ul8eRS2Sx77rOg==
X-Received: by 2002:a05:6870:c5a3:b0:d4:5e07:6e5c with SMTP id ba35-20020a056870c5a300b000d45e076e5cmr1650631oab.191.1645807038960;
        Fri, 25 Feb 2022 08:37:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t82-20020a4a3e55000000b0031847b47aaasm1312835oot.26.2022.02.25.08.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:37:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b30fed61-9ed4-3ba2-0370-b0007a80d8e9@roeck-us.net>
Date:   Fri, 25 Feb 2022 08:37:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [2/4] dt-bindings: reset: mt8186: add toprgu reset-controller
 header file
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, wim@linux-watchdog.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org, p.zabel@pengutronix.de
Cc:     runyang.chen@mediatek.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
 <20220216014505.28428-3-rex-bc.chen@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220216014505.28428-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 17:45, Rex-BC Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Add toprgu reset-controller header file for MT8186.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

With the next patch squashed into this one:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   include/dt-bindings/reset/mt8186-resets.h | 33 +++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>   create mode 100644 include/dt-bindings/reset/mt8186-resets.h
> 
> diff --git a/include/dt-bindings/reset/mt8186-resets.h b/include/dt-bindings/reset/mt8186-resets.h
> new file mode 100644
> index 000000000000..36e5764e2e6c
> --- /dev/null
> +++ b/include/dt-bindings/reset/mt8186-resets.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Runyang Chen <runyang.chen@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8186
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT8186
> +
> +#define MT8186_TOPRGU_INFRA_SW_RST				0
> +#define MT8186_TOPRGU_MM_SW_RST					1
> +#define MT8186_TOPRGU_MFG_SW_RST				2
> +#define MT8186_TOPRGU_VENC_SW_RST				3
> +#define MT8186_TOPRGU_VDEC_SW_RST				4
> +#define MT8186_TOPRGU_IMG_SW_RST				5
> +#define MT8186_TOPRGU_DDR_SW_RST				6
> +#define MT8186_TOPRGU_INFRA_AO_SW_RST				8
> +#define MT8186_TOPRGU_CONNSYS_SW_RST				9
> +#define MT8186_TOPRGU_APMIXED_SW_RST				10
> +#define MT8186_TOPRGU_PWRAP_SW_RST				11
> +#define MT8186_TOPRGU_CONN_MCU_SW_RST				12
> +#define MT8186_TOPRGU_IPNNA_SW_RST				13
> +#define MT8186_TOPRGU_WPE_SW_RST				14
> +#define MT8186_TOPRGU_ADSP_SW_RST				15
> +#define MT8186_TOPRGU_AUDIO_SW_RST				17
> +#define MT8186_TOPRGU_CAM_MAIN_SW_RST				18
> +#define MT8186_TOPRGU_CAM_RAWA_SW_RST				19
> +#define MT8186_TOPRGU_CAM_RAWB_SW_RST				20
> +#define MT8186_TOPRGU_IPE_SW_RST				21
> +#define MT8186_TOPRGU_IMG2_SW_RST				22
> +#define MT8186_TOPRGU_SW_RST_NUM				23
> +
> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8186 */

