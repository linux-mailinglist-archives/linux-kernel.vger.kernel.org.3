Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0294C4EAF85
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiC2Opv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiC2Opt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:45:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60253B03E;
        Tue, 29 Mar 2022 07:44:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h23so25156901wrb.8;
        Tue, 29 Mar 2022 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=f1hZOQmmNmyJ7U7nVAiaQQ0lwaiu4vRuIQsNB/VIsek=;
        b=LFwUL3ZRs6RYhHzf2Bdq3dc2ZslNWBxkB1yhR+wEGS6JH1CAINYO8yj+nLkeMHE24p
         P5+HJJ9yWBhuBXgX/vfmtySqT1FV/U6hp7W7fVDw/xJ6jwxk/ymbYXTVT92XWs/O9E/6
         4VMhn4h7OzWX2RHnlJoqHAlaRNFPgU0R/cWjA/iT6aFYEDbkImo4/pFTNs7KsML/jku8
         ntEHwcuSkgx2jmUNHIsUhxwdHWu7KtNBW51dNBC/v6uAH43kyQmKk9tgQA7WSS3AuHRI
         XQCrFbf2xcxV4JEHdrv7XDvtf4ESDi19uZAe4x4q2HQr2zgwlTFm8e1/vjvZY8wpc3dx
         1TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=f1hZOQmmNmyJ7U7nVAiaQQ0lwaiu4vRuIQsNB/VIsek=;
        b=73GLBzgLqFPgoBUmilAvMc/E3Y8tYNxc0qamSXagjHqsA7kA1V2b7L4WauCwG7Ho7J
         063v3Hiq/Z/FgCv1ZiDRFIPR+U9T/yi+m0A+J9bPpjTZbx3jeQUPdhcuxHBLL+H7/WLi
         V39yRzdj1dnufFXjkBwVAMJ1+Ii5GuOZgwu2EI3hNUW0LnnLh+KPk5/k9Bd2hkD7aDGG
         bcvxrILU4A2rpqi14tZvfOmnIjLmEZYkQS3S22lpwEgaxJGLScJXISK+lPWBX2jGI08W
         b4P0eSJgCeeRiQGWujCCPTNWbGquS1HC3yNEfpalC/cGRih/XdmqbsoYg+R1LI8YlX1J
         ktXg==
X-Gm-Message-State: AOAM5323w6QvBHUqw51dEx4hZHIj76MOwZm1/3qjhhRK0gQDf6vs72Pw
        FUpLKnTAeAh0Y1yVmOeugwU=
X-Google-Smtp-Source: ABdhPJzMwHCsnpQQtTp4CjjZBj9sm+ezIYCdnM4RPz8U92H0vmmgiVSarO5uo1zeXs7VamaIsqqIkw==
X-Received: by 2002:adf:ec41:0:b0:1ed:beee:6f8f with SMTP id w1-20020adfec41000000b001edbeee6f8fmr30629170wrn.110.1648565042644;
        Tue, 29 Mar 2022 07:44:02 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b0038cc9bfe6a4sm2288573wmk.37.2022.03.29.07.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:44:01 -0700 (PDT)
Message-ID: <d3b8f78b-24b0-d0f1-f5cd-c3cb29ee25d7@gmail.com>
Date:   Tue, 29 Mar 2022 16:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        hsin-hsiung.wang@mediatek.com, sean.wang@mediatek.com,
        macpaul.lin@mediatek.com, wen.su@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220329115824.13005-1-zhiyong.tao@mediatek.com>
 <20220329115824.13005-2-zhiyong.tao@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 1/1] pwrap: mediatek: fix wait time out issue
In-Reply-To: <20220329115824.13005-2-zhiyong.tao@mediatek.com>
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



On 29/03/2022 13:58, Zhiyong Tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> 
> add sleep delay before read "jiffies"
> 
> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>   mode change 100644 => 100755 drivers/soc/mediatek/mtk-pmic-wrap.c
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> old mode 100644
> new mode 100755
> index 952bc554f443..ac7139a67e87
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -12,6 +12,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/reset.h>
> +#include <linux/delay.h>
>   
>   #define PWRAP_MT8135_BRIDGE_IORD_ARB_EN		0x4
>   #define PWRAP_MT8135_BRIDGE_WACS3_EN		0x10
> @@ -1197,10 +1198,13 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
>   	timeout = jiffies + usecs_to_jiffies(10000);
>   
>   	do {
> -		if (time_after(jiffies, timeout))
> -			return fp(wrp) ? 0 : -ETIMEDOUT;
>   		if (fp(wrp))
>   			return 0;
> +
> +		usleep_range(10, 11);
> +

You need to explain this change. Why is it needed, are you sure it does not 
break other platforms etc.

I can guess why you need that patch here. In any case in the code you provide, 
it would make sense to move the first if out of the do loop and only after this 
wait 10 us before reading again. Right now the code does usleep only after every 
other read.

Regards,
Matthias

> +		if (time_after(jiffies, timeout))
> +			return fp(wrp) ? 0 : -ETIMEDOUT;
>   	} while (1);
>   }
>   
