Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB5A59F72A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiHXKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbiHXKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:10:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A017427CC6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:10:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k9so20165040wri.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FYtLLEtrQV5jb6y+N+fJ4gbxN8G4x+LqblZ/wev2j4I=;
        b=iUaIM8f5Dtbp8R4P3kMLiGslR17Bwci0l/A2w0k4o7vAkS6FlKg1+gCHrgAmfz6uQD
         pd6aW2JoEWTBXmcbb3oYiRDL4Ilz9YB9DUxCUGMCANyNVOEbxbUdgEjvB6yEPGR5FFXF
         3q3HXzlAHC4QgGEktc2sB1UJ8Qg8NfH9rSV4AqQNDVfpvuBkm+VJ6kk90okjBJvk3Iuz
         FGHDDTAdE0J69F7ME29xCTDSUr/l3V/JlLlsnNwVkC8Z64bbYHu/A33Ui7FAIY1j99Yv
         79B4ErStfds1KWyS98kzYg/9T5DljZcBDRMF1zR4QkbljhDT4Xm3iVDZjDoK+tLhGvpH
         PGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FYtLLEtrQV5jb6y+N+fJ4gbxN8G4x+LqblZ/wev2j4I=;
        b=xZQyogH9kN7blb7YdMUmokbe0diZ+FU0owQwAnkgF+3uNHyfh9XbH3kOgsVj/Exgse
         FcWkPMAieLipQkvrE3R0H8N4K+yddq2MZaHT+cVh8tG6/gJIOM+CqSK+vJk+eOpXTpek
         UiRyu5LrNa7F2UgsAcdURh91q7gu0WlRuHYpL6ax0+UtyJlTnPBsN+Pi4DSLrGZtSsMW
         CqzbDpvqvHED2qpYTtwHFP0vfclA1ESRQbMJXO55EcOuNqU7uXb9VEqg9YcVbpeBYR/4
         8jIOyhz7B2R4oxPywUmyqJ4TamHatryv7HDooteBNHoh/p6Qr6H/n1lBUCsKPbobv0rO
         pFRQ==
X-Gm-Message-State: ACgBeo3kmq+FfUy0rBvOAJvhaFktxt0rRV9cmPKeG4VLBC2LKh46Tn5p
        VB7WZ0gLt3bOptgeGhm4Mgi1ozhMgS4=
X-Google-Smtp-Source: AA6agR7Bw/IhAgnQtVjXRCdTp7hctYFXLFI6R0POaMsgIaxTBSNueXRYwlYaIN11wdiLoabBZpIB4w==
X-Received: by 2002:a5d:6e8c:0:b0:225:5f3f:1d8f with SMTP id k12-20020a5d6e8c000000b002255f3f1d8fmr6734212wrz.610.1661335832129;
        Wed, 24 Aug 2022 03:10:32 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w7-20020adfd4c7000000b0021d76a1b0e3sm16522238wrk.6.2022.08.24.03.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 03:10:30 -0700 (PDT)
Message-ID: <81eeafd6-26b3-1414-19d4-032e186ef308@gmail.com>
Date:   Wed, 24 Aug 2022 12:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH linux-next] drm/mediatek: Remove the unneeded result
 variable
To:     cgel.zte@gmail.com, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220823075515.209198-1-ye.xingchen@zte.com.cn>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220823075515.209198-1-ye.xingchen@zte.com.cn>
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



On 23/08/2022 09:55, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value drm_mode_config_helper_suspend() directly instead of
> storing it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Please make sure to add all the mailinglists that get_maintainers.pl gives you.

Regards,
Matthias

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 5f02f8d0e4fc..91f58db5915f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -833,11 +833,8 @@ static int mtk_drm_sys_prepare(struct device *dev)
>   {
>   	struct mtk_drm_private *private = dev_get_drvdata(dev);
>   	struct drm_device *drm = private->drm;
> -	int ret;
> -
> -	ret = drm_mode_config_helper_suspend(drm);
>   
> -	return ret;
> +	return drm_mode_config_helper_suspend(drm);
>   }
>   
>   static void mtk_drm_sys_complete(struct device *dev)
