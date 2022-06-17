Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5030754F528
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381786AbiFQKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiFQKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:16:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B16A403;
        Fri, 17 Jun 2022 03:16:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w17so5131628wrg.7;
        Fri, 17 Jun 2022 03:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A49OZTNmycM9T7O4NhhDhLVhxX9lOTw3kIpDlpZkAyM=;
        b=XBQ9rPfZKRdBPtoXtIDPtDm5ePwdBYLHauLnGGWBfyYK4V27rOD367bNmrog6F8/Ru
         WDSpLzNCNOBvZxOqs72PkT/USJnfg5WiogShSVWz+V0bkzEqsQMg3KyCcRLjryog2X8L
         CSyPKCbbaltsXxzajmdLnZfXkFVDblFiiPPxBWgPSgYmCaSOd89Pw9EuAeoWM4dEOcWr
         ++p1wVHebubT4bosHuJA4/uVBbQUDp7VnVkYiqqm8i/Gblj6DtglFdIhJjR6X2C34mFD
         xc6RLfoa+9zmP5k3mbQSdtH2llgaDFFTVNJE8FJ69VIo4jQHpuysE3Qwx8tpcgVHPKqy
         PH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A49OZTNmycM9T7O4NhhDhLVhxX9lOTw3kIpDlpZkAyM=;
        b=C63m3k/ZTrXBQBbR//H5UghiKPA7fYdnTunwj9h3JhiIXxaLhwRV8pL9p42dgiO5Cs
         uG9hyJyOv5V7L78eQEU/4HRAQ9x2VKMHaRnfb819zOKqyGboLktT1Vy8qhjke/vzij/c
         ulJP7Lo8gYhHGJC6zvP/jiV5FhcLw9LM+Tfv1jA6gr1of4M9FaV9MWuOADnDFwfuvJUt
         9C8HUzLwQ3F0k1koD54W880pkXi3a/vCXIFWk0zsjx7Ec/Ehj6taUYO7x0dUO9kyXLY0
         jFbk3lYASrXv4K59QA/0hpGEetqM9Ik6h+965Rn7FUCL2+kuRDzz3i4cROWF3yLXEzvI
         LcMA==
X-Gm-Message-State: AJIora9fVpK3d/vCqLjon55sNnuvJFoNVofaJcAqHsZSmvrfsuOQBFIZ
        vJjmBH/ElUZcljYwlnEQwpXO5KgIytXA7g==
X-Google-Smtp-Source: AGRyM1tDqQqatoQldPx3uviM4GbaYxoLOekVUtagRZDz0I8oeqZWsm2wZSSmkf0V7SDtj5NyzupOgw==
X-Received: by 2002:a05:6000:1a89:b0:219:b255:d874 with SMTP id f9-20020a0560001a8900b00219b255d874mr8668409wry.50.1655461016065;
        Fri, 17 Jun 2022 03:16:56 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id by8-20020a056000098800b00219c46089f6sm4197360wrb.64.2022.06.17.03.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:16:55 -0700 (PDT)
Message-ID: <71bf73f9-fa60-e4ba-a339-64d876514af2@gmail.com>
Date:   Fri, 17 Jun 2022 12:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, rafael@kernel.org
Cc:     viresh.kumar@linaro.org, rex-bc.chen@mediatek.com,
        jia-wei.chang@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220617090652.56247-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220617090652.56247-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/06/2022 11:06, AngeloGioacchino Del Regno wrote:
> This SoC shall use the mediatek-cpufreq driver, or the system will
> crash upon any clock scaling request: add it to the cpufreq-dt-platdev
> blocklist.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Fixes: 39b360102f3a ("cpufreq: mediatek: Add support for MT8186")

Fixes tag should be before any Rb, SoB etc tags.

With that:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 96de1536e1cb..2c96de3f2d83 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -127,6 +127,7 @@ static const struct of_device_id blocklist[] __initconst = {
>   	{ .compatible = "mediatek,mt8173", },
>   	{ .compatible = "mediatek,mt8176", },
>   	{ .compatible = "mediatek,mt8183", },
> +	{ .compatible = "mediatek,mt8186", },
>   	{ .compatible = "mediatek,mt8365", },
>   	{ .compatible = "mediatek,mt8516", },
>   
