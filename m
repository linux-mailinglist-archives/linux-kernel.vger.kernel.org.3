Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A289E51D871
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392227AbiEFNFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiEFNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:05:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783862A0F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:01:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i10so12434329lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yAmT/C8oHoIi+bRromxMIRp4Gpsqt0hP9qUoy71fZN0=;
        b=gPFSvYRrrwZ8UcrBnBkXXoqrt3hxOBdSl9zMzR+4c097Jj1hIEJOtLND+lXqR7+nKw
         ZTx6olJ+5Qo8MBuK0fBGNClLTJzdGMyTAD9JQDWpXUjnP/ywX1d2OdfDulyw8c5og/Jx
         xPlw2qK6CfvoRpRF2E5S0IAlpgus/+jlLeTvpn/zoNiIB3y56p44ITAFvfrTdigktxGg
         oNZnbs3QeoyURe7f5X9/+OYp0RXr8NFJfA+KKoMbz06SOg5GDl+MTZ8uI1/2ueXUnSrN
         XM2a264GlicyX69hwspP0XdiDC7Xb8ODexzV6Mfb//TUyEM5iHl8Cze6Eda1NzAaig7J
         Et6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yAmT/C8oHoIi+bRromxMIRp4Gpsqt0hP9qUoy71fZN0=;
        b=Nw7wkGr7a4Zkrw8srPtUCZJukLB41/wI9oBPz6pJRoihHKU+SYgC7tbc+pIoDovZB1
         yU7EwvFCaNC0F5sPDRDSStIFBlIxA2R42IxjjfqY6wWbV8ochrZq1UoNUv7VBgGZikb0
         XpqC6OjNqriLnUZLXs/H3FMhOJYHARTWhvmEf7DEthYxcp6sDWEuQx7eZc9kho7E9a59
         YWRbhVK/KZSfjyc8ABXZwXAFSOov9sSh7frzcQON2P5VUiBwBlVbnr3PrWwOswozBiew
         u0NqseXBYKLlPIufE8sV04ZFUysNIXw+FiL8FJhcqtMx5RAxOLbzT/wZ68fizuwWZgcV
         BR2g==
X-Gm-Message-State: AOAM5327Ko0mZAxBi+i78QSr0Y6Lsp8NPMDtNW9hD+u4rlySgGHPJnAM
        f+RzltbFAo5pjekpvdr62weol52bn+YD5A==
X-Google-Smtp-Source: ABdhPJwjlm00jlN+64J3QcGL6O0+QFGJ0jRzTlfBp0xKCzrA71d1nkyCaCjZGuQWGsSnQU5bbsLjSA==
X-Received: by 2002:a05:6512:10d5:b0:473:dddb:6b20 with SMTP id k21-20020a05651210d500b00473dddb6b20mr2450069lfg.7.1651842094949;
        Fri, 06 May 2022 06:01:34 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w13-20020ac2442d000000b0047255d21179sm680126lfl.168.2022.05.06.06.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 06:01:34 -0700 (PDT)
Message-ID: <6eac705a-d5ec-e7c5-1327-0bf94c016452@linaro.org>
Date:   Fri, 6 May 2022 16:01:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 -next] drm/display: Fix build error without CONFIG_OF
Content-Language: en-GB
To:     YueHaibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220506123246.21788-1-yuehaibing@huawei.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220506123246.21788-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 15:32, YueHaibing wrote:
> While CONFIG_OF is n but COMPILE_TEST is y, we got this:
> 
> WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
>    Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && OF [=n]
>    Selected by [y]:
>    - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=y] || QCOM_LLCC [=y]=n) && (QCOM_COMMAND_DB [=n] || QCOM_COMMAND_DB [=n]=n)
> 
> Make DRM_DP_AUX_BUS depends on OF || COMPILE_TEST to fix this warning.
> 
> Fixes: f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> v2: fix this in DRM_DP_AUX_BUS dependencies
> ---
>   drivers/gpu/drm/display/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
> index 1b6e6af37546..09712b88a5b8 100644
> --- a/drivers/gpu/drm/display/Kconfig
> +++ b/drivers/gpu/drm/display/Kconfig
> @@ -3,7 +3,7 @@
>   config DRM_DP_AUX_BUS
>   	tristate
>   	depends on DRM
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>   
>   config DRM_DISPLAY_HELPER
>   	tristate


-- 
With best wishes
Dmitry
