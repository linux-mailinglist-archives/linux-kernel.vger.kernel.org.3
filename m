Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C0531031
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiEWM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiEWM5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:57:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CF052B31
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:57:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c19so12340309lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u6n7lfQbbIWcpS2iQa+0BOTFblQ5AQf1UMOzYtLKQ4g=;
        b=czS5j38njliHDh4xPnTDQqwSPDW9ICQXV/4G82hcs/smRSJNQwJKIpGMXv5/kiDIt9
         qsqUxquVp3bPqCtuiwcFt019uXWcp7mKTMtJCqd/U0UUjDLR9fITActC57U0E8bd1bc8
         5jH0sVTTUoDsmtpHaSyFue5oXfVER/gj4pEFgFICmk4aUj4wZ9U3K4DinDB04V7NVfew
         zY1wK27bBswzXkAXog42grd0TSZzyJwxHASDp9rZPb2dh63mtLnsC8D+yoZnFQCfbvkD
         UAz8TE6ExGjexLe2Tsh09BGf1+f6zT1ravHtRUCM4onXUsYWH8M7dsa5B/N/cQFFtUOg
         g8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u6n7lfQbbIWcpS2iQa+0BOTFblQ5AQf1UMOzYtLKQ4g=;
        b=3zb1WbvAzd1q0lI3moCP8nRU1xkTcDjZX2OQ4XW+SP5Ay/MbxKe1CTFy5gfhAXQh8k
         dneDFVnxngziZz+TlqUrFvNFxkA7jZXkat93xLrg/0+3Kwxf7h/lyJ/QQYx61XHAC6yl
         QfNCBehEhGlZ9eAXZo8og7DGdlK7Ut0ZBvdaYR8MbknPeUQ9iJODn2O5q3GUQzF1T7HE
         2duTAMhPMpHbiYBgw9GGQJplzriUdM5Zd4S6eo0Q7pFglpIaWQ9w7f1Ui7GlSvR8CA+D
         MIHRvLwAfI1h1UXKTniXaV/ScajfNSdGQ9llPI5LgiTJ1kA/uiVly0sTMilsc4sC2t/Y
         76fQ==
X-Gm-Message-State: AOAM532e+qD+AOcomWSchMZvl52FQCqvbQ59b8S9qagT4+5iyGZoRo8B
        m9ybsJJ8st1y5TuDGSvi0P8OZw==
X-Google-Smtp-Source: ABdhPJxO5q9f6EcR6FhvfaacGCWAHpb9r8fZp0RC4/oZYgV+ANOuSNjR2Qs40FI4VYxVKHy/zk6Rmw==
X-Received: by 2002:a19:7112:0:b0:474:876:7a23 with SMTP id m18-20020a197112000000b0047408767a23mr15870672lfc.139.1653310635691;
        Mon, 23 May 2022 05:57:15 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p8-20020a05651211e800b004758e4e6a96sm1966166lfs.245.2022.05.23.05.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 05:57:15 -0700 (PDT)
Message-ID: <9534934e-4c4a-ba2f-3bc3-d6d241e625bb@linaro.org>
Date:   Mon, 23 May 2022 15:57:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 -next] drm/display: Fix build error without CONFIG_OF
Content-Language: en-GB
To:     Linus Walleij <linus.walleij@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220506123246.21788-1-yuehaibing@huawei.com>
 <CACRpkdZUwfVNZyS6RgcupJ+TRUZVM+1_3ABj_-f_3+v+wNE6mg@mail.gmail.com>
 <CACRpkdaKrk+cj9Yvpe3kmR1iJFczi-yckHiKeLGu9F=hRFiU9w@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CACRpkdaKrk+cj9Yvpe3kmR1iJFczi-yckHiKeLGu9F=hRFiU9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 15:54, Linus Walleij wrote:
> On Mon, May 23, 2022 at 2:46 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, May 6, 2022 at 2:33 PM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>>> While CONFIG_OF is n but COMPILE_TEST is y, we got this:
>>>
>>> WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
>>>    Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && OF [=n]
>>>    Selected by [y]:
>>>    - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=y] || QCOM_LLCC [=y]=n) && (QCOM_COMMAND_DB [=n] || QCOM_COMMAND_DB [=n]=n)
>>>
>>> Make DRM_DP_AUX_BUS depends on OF || COMPILE_TEST to fix this warning.
>>>
>>> Fixes: f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
>> Patch applied to the DRM tree.
> 
> Nope, failed:
> 
> $ dim push-branch drm-misc-next
> dim: ac890b9eeb9b ("drm/display: Fix build error without CONFIG_OF"):
> Fixes: SHA1 in not pointing at an ancestor:
> dim:     f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")
> dim: ERROR: issues in commits detected, aborting
> 
> I don't know what to do with this, sorry. The other committers are maybe better
> with this kind of situations. I think it is designed to stop me from
> shooting myself
> in the foot.

It 'Fixes' a commit in the drm/msm tree, however a fix is not 
msm-specific. We can push it out through the drm/msm, but we'd need an 
ack from drm/core.

-- 
With best wishes
Dmitry
