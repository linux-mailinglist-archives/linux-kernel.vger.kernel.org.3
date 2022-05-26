Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BCA535123
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347833AbiEZPCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEZPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:02:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F95EBE7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:02:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q1so2054339ljb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0D8beMvITCEnQx8kNlsoiMBAwRlvlYs/p4e3T9UBysk=;
        b=OR6Rn0cIwMEBUkUXJ1VyIu9n2UbV0stSHvaMzeU1kJ8kDh5lCNQlz1mNu6sD4hHaA0
         dsQbVAi+wzj9faH/mKfIHl6OHg8vSDYfvVfGL7nDV0zDbUdYLM/PEvvKA41sSrKUmhNa
         Bza8cJbKFMFqMb38bLJ9tRAbpyPb+z30Go1M6a3e1PvUVdxAgWCKgkFhExjpjUVXpw9t
         VJW3ngnXh77cwHNots7cBAFoRGuaHz+/s5GLwa6f/BB8OYwQSJhTy8x5G6KNtJcil68y
         qHH8/clbfVYNMeGjJ27vJdWGCJBHSA/KAVz1PQB1QZMFNOFrA4XuwtJKrGPqcm0Vj6pp
         anbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0D8beMvITCEnQx8kNlsoiMBAwRlvlYs/p4e3T9UBysk=;
        b=Spql15/k8AJnwx50wGeiS+3hjBsnKTw0LnzVQkyW6s7Vd+d2VqQXzt4z0nAewD/r6W
         v8F3c/0LjfVJYqoavkBE28mPgTLR2fP7j5RcxQdytu9Q6Eyh4eOOGJ8GYbYtuXvBV56A
         Nn/ZA4HMz1od8yE0wBAToh1OqcMy09oLv1FlULuCtcWW014zuDzczP9L+N3Uk9FWZ/Ee
         fKNjdtmyMYU4Dumg1VgQphVoNMTyPEKusAQ9LIeDew+KTFD8Oo1vAmjPFM8psWbgpJsc
         GaBZ4lKnIPibMGbJfYTlyio5+nrxSvviluCibqtRB2/s2hV6ZQ0KSfiqPd0u7u8JsKpc
         3How==
X-Gm-Message-State: AOAM5326fkdqhbBetZp83xTkF5Tj47WBFsUVM75/dZN503zEJXdMthFZ
        groSZqOVNLHwd64EzcJ56a9yGdZ2ihjpog==
X-Google-Smtp-Source: ABdhPJwzG8K/zqLzj6k+ONVQDWc9rr4vNc0HCZhyxgpG25v5q4sJTfmZUi0az3S8isaPu1yB9kMinw==
X-Received: by 2002:a2e:bc2a:0:b0:253:edc9:dc73 with SMTP id b42-20020a2ebc2a000000b00253edc9dc73mr11569641ljf.351.1653577336150;
        Thu, 26 May 2022 08:02:16 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b0047255d211d6sm390892lfs.261.2022.05.26.08.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 08:02:15 -0700 (PDT)
Message-ID: <310e5453-9771-eb90-1a67-b04ec695fee0@linaro.org>
Date:   Thu, 26 May 2022 18:02:13 +0300
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
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Yue,

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

After a second thought, I think the patch contains wrong Fixes tag. It 
should be:

Fixes: 1e0f66420b13 ("drm/display: Introduce a DRM display-helper module")

With that in place would we be able to merge it through drm-misc? Does 
it needs to be resubmitted?

> 
> I don't know what to do with this, sorry. The other committers are maybe better
> with this kind of situations. I think it is designed to stop me from
> shooting myself
> in the foot.
> 
> Yours,
> Linus Walleij


-- 
With best wishes
Dmitry
