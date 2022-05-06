Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169A151D6C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391368AbiEFLkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242314AbiEFLk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:40:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A88658E40
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:36:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d15so3577395lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XafsDV8I0xHrzVkv4lSdRDTo5FGQ0l18EsU91PxSrTY=;
        b=R/9u2E/dM6T5z3Ufuk0pILf/XaQE12+vA3CHOQMvtmD7vacSqg6PRji9NzlXeQig7d
         MAkwEe8dhqsZ4NX4tfVcYsHhKtMwK/lqOTRA2onnjz9V1JqsDYITp8IpBvEM3+agWg0V
         ddqJltjhy6S6IrcSB70mYwPw3jDWq3Zr5xETNZohTeU4TAnCezQuUHu4ZGwcjSnarNxY
         y4/2AYaGddX/+OYwOvZwRX7jcM4LOkLhcUcHp8mt5E6xarP123G+WCS7y4tnAcYpgsfo
         Epf5pyLfMyFAebYW25CET/ldtijPYr9BX5TxXQ8az+pRZuBS6RSvBctVfMaLD/hiLjdO
         1uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XafsDV8I0xHrzVkv4lSdRDTo5FGQ0l18EsU91PxSrTY=;
        b=Dc8aE0VW1XQUZHT7vlr9w46J6QRUDHFnv7phE1b7gTax1v/ngjr4ukTMKygmdqGVLx
         JNE+3bfSU7aFLrAdsVlzPrpZf1fBSNmaEhyJ7q/rz07NVfIPhVpJcfpC4EcbPYKSuQTC
         okjJ1czRLLKoH7sLLuDYMj8I3XwK3xpL+vw46Bk94ud2+DbphrOLdfB2rEu9NgiHtX5u
         QzHG8pAwz/vfLtoj8T9db6h1Px+Zp0Q5cyO7IhOOc5EJpVy+j6LCvSrIyHTau115vE/f
         VJPXNtXgtIzjJ8Uz+eiXir4JFRHGcGDbWFSzBQDYjWPZ6bcMqECjhzWW5TUe6qwdxu9D
         lmrw==
X-Gm-Message-State: AOAM533GZeU9/UChSUKy2go5zLEaPht6TxD3ZhMROVMaN35VM9JAFI9C
        /VrATtwwyeWJXgw+uU3EKhZyFw==
X-Google-Smtp-Source: ABdhPJxADU+mLvDMm3zIaM1F95WrlOimpTGlSy6aaEIi5buS5/Jd61rBVItq1CRnPCHmI8zY3L0ySA==
X-Received: by 2002:ac2:530c:0:b0:471:fa37:1123 with SMTP id c12-20020ac2530c000000b00471fa371123mr2255207lfh.397.1651837004835;
        Fri, 06 May 2022 04:36:44 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q17-20020a05651c055100b0024f3d1daebesm603620ljp.70.2022.05.06.04.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 04:36:44 -0700 (PDT)
Message-ID: <dbe452b1-7f6a-141c-5fe3-bd889c62abc7@linaro.org>
Date:   Fri, 6 May 2022 14:36:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] drm/msm: Add missing OF dependency for DRM_MSM
Content-Language: en-GB
To:     YueHaibing <yuehaibing@huawei.com>, robdclark@gmail.com,
        sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220506020300.20704-1-yuehaibing@huawei.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220506020300.20704-1-yuehaibing@huawei.com>
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

On 06/05/2022 05:03, YueHaibing wrote:
> WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
>    Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && OF [=n]
>    Selected by [y]:
>    - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=y] || QCOM_LLCC [=y]=n) && (QCOM_COMMAND_DB [=n] || QCOM_COMMAND_DB [=n]=n)
> 
> DRM_DP_AUX_BUS depends on OF, so DRM_MSM also should depends on it.

I think the proper fix would be to make DRM_DP_AUX_BUS depend on OF || 
COMPILE_TEST rather than just OF

> 
> Fixes: f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/gpu/drm/msm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 4e0cbd682725..1d710a20ffdd 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -3,6 +3,7 @@
>   config DRM_MSM
>   	tristate "MSM DRM"
>   	depends on DRM
> +	depends on OF
>   	depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
>   	depends on COMMON_CLK
>   	depends on IOMMU_SUPPORT


-- 
With best wishes
Dmitry
