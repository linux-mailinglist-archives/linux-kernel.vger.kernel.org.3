Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7994C6A59
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiB1L1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiB1L1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:27:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5DA43ECF;
        Mon, 28 Feb 2022 03:26:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d17so14856118wrc.9;
        Mon, 28 Feb 2022 03:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0nOl9Gu2cS+40aKnl77MAdTBzkl+e2ajXLPqa1328c4=;
        b=RF4z69yluICtYu1fuLZaU5ixtaQDPyAtJIV6s7TbYCPDKfko8sreM/MwfRn1VCiVB0
         TSDCP5j9Bnpu2IOzh061GbVz6HMuZpuN1R0Vg3dYvBkElL2SqQ+XsqzJS/AaEkhVxfw8
         wjb/fCMdjSlcZ3gLtLUiAjcGxqyIgkLiSdPfg+MVpcYvPygMabCcQirectYD9SNiQcC7
         fB60JFiWqd2xEG7hLjg/wCYtRsDbH6QLwiQ9J5RvnUl6+lgM0nvbbnxwSaHUGPVp7fQK
         56bQlW4K55lgpwfxgKyCGG7EdXEhk/UsWnq8TC5BCaqrtBDDWNQ6IyZV0/E/JCHjALLN
         Qhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0nOl9Gu2cS+40aKnl77MAdTBzkl+e2ajXLPqa1328c4=;
        b=OQ6nHNInaNeEhA1OeT+jT8rX6pJrkTWX1/yI/HOpUtZ6KnQYFHRTjDNzQo3OOmeV0A
         GHIrA+8tNCfJgJoir/Aifoyag3BlIGnv0+5LOPItWbIljH5K2fMOAWaAA9JfZ89ZvWUR
         SmjYaZ/5T3iunaO1ZIvCn5o0JKY0hBxtAB84X/YLo79EKzvU/pj9Ca33vprLUMsKFlEU
         ovGsq1/xm4t9SIEv4AnhW0IQUhBxd1inGPaUmPRXfsJZOxXMfSK96iSpvchoS0Wu4oOh
         oYf4duIMPMtfwLIOQ/pxRUDH7p89uNAg0y9fJcmlJflTbRbTqUm4NJfrWBaRA6q6H718
         +EJg==
X-Gm-Message-State: AOAM530QV0klwOa0eu3ahINz8/R7sMDJD2c6HJo4RyqQEkVsrBq320Sw
        JwvUCeCQS4BdpInXYmHzLI8=
X-Google-Smtp-Source: ABdhPJyEN3IVhZ9CqchTTNuRDYhwp5BAWHwjBXE4AYXcGoAFKxxj9OkPswk656aj1zqS3OkJFo7PcQ==
X-Received: by 2002:a05:6000:1c0b:b0:1ef:f0cc:6e53 with SMTP id ba11-20020a0560001c0b00b001eff0cc6e53mr1225544wrb.715.1646047592597;
        Mon, 28 Feb 2022 03:26:32 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm9847832wrw.49.2022.02.28.03.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 03:26:31 -0800 (PST)
Message-ID: <530f6169-afdb-8242-f4b4-54a54a73948b@gmail.com>
Date:   Mon, 28 Feb 2022 12:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/7] dt-bindings: timer: Add compatible for Mediatek
 MT8186
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     hsinyi@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220128062050.23978-1-allen-kh.cheng@mediatek.com>
 <20220128062050.23978-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220128062050.23978-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2022 07:20, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This commit adds dt-binding documentation of timer for Mediatek MT8186 SoC
> Platform.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index e5c57d6e0186..e0d20d6adf81 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -22,6 +22,7 @@ Required properties:
>   
>   	For those SoCs that use SYST
>   	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
> +	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
>   	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
>   	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
>   	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
