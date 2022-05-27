Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ACD535DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350405AbiE0J5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiE0J5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:57:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3233892
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:57:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w14so6042425lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e0tqh7qqeg/7ehiexIPgsAiDdSoZS7aeFNTayUPMdOc=;
        b=ZLNumBwMjmYz6Ddz8l4E2qz1MRkHPqE7mQJC9CNLFuEaHUR0cfrIBdygNdA/Ny4Mv6
         rp/F0FVbaIMEK/PbDA1txZDM+QZynz6bdG/YBBF7tZdfUrzZLXmoaMTBIGDx4nVetifA
         RgaYMbHFsRKj3w6ZSXklGPByUn3iubvjr98VjEVQ2J0SMeLhlFwt23IiHavr3PjJdzvw
         KOq1x7q4bL0pp4pwfnRt9HLodEYBWgQiHaeJaHS1aFTpikMLgsEo4/zNvhcQlybydzYX
         zwPwiqMWvOtpDMrKi5aTBqxls/5n91GIjM28071jM2dsNQ8xKuyJA68BvePufLBdginC
         m9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e0tqh7qqeg/7ehiexIPgsAiDdSoZS7aeFNTayUPMdOc=;
        b=WBx3xnswCG3UHC7UAWI3gAI9mZLLbHe2xaVo+EZLznWs6oNLOPvRhpCoSu7wdVpbz2
         kcmlc7gTh6C+mLc9D6XmYLg9eGEbce4ahfNCOZ4M9AKg8b7BBbFYZ1WlYShKj3/BT+It
         r0E0znB3TXGvDFd5hDXelb01XAQHv6MAfyEw5QEdhfAh/vJfMrPWdQOx/XfUZvA6XIL2
         tHya/KFXkFMVznTY51Yx0/eGbhyI1l5ZGSrXLTjEo3xZK7apvO5trimLem0ZK3JSWUPF
         jKjRJll634D19OWrwqpm2mRYLv12jk75NkoAWRmN/TLpyph8QbqfDwk/HJddkVKaNCH5
         uubA==
X-Gm-Message-State: AOAM533255baMQtlDwGSwCs1oQn6HTjtZiDjmUw3ii/vwihR7CM8GXKn
        GMCV/O5l9J1+oxm02S5HCbxWnUrG7vCvbA==
X-Google-Smtp-Source: ABdhPJz1lmb5CKBAD9Igt8Z+9gebkQewb8KfLfs/WVghEp6rr2duyaG6bgXXnHEH9ITbnlE44kqHSQ==
X-Received: by 2002:ac2:4c53:0:b0:478:6908:c76f with SMTP id o19-20020ac24c53000000b004786908c76fmr18791795lfk.634.1653645419012;
        Fri, 27 May 2022 02:56:59 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a17-20020a05651c031100b0024f3d1daf04sm911304ljp.140.2022.05.27.02.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 02:56:58 -0700 (PDT)
Message-ID: <7c22e193-2a7b-2537-feff-c4656c022f31@linaro.org>
Date:   Fri, 27 May 2022 12:56:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 -next] drm/display: Fix build error without CONFIG_OF
Content-Language: en-GB
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, tzimmermann@suse.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20220506123246.21788-1-yuehaibing@huawei.com>
 <CACRpkdZUwfVNZyS6RgcupJ+TRUZVM+1_3ABj_-f_3+v+wNE6mg@mail.gmail.com>
 <CACRpkdaKrk+cj9Yvpe3kmR1iJFczi-yckHiKeLGu9F=hRFiU9w@mail.gmail.com>
 <CAA8EJpq7_V7mZbN+G5fZdK0a4kTcxROAd_bGJtQ5mhzdYr6pNQ@mail.gmail.com>
 <CACRpkdYATkP2ONCxHq6+XsWM8949tXxd5r=OKM36dgwWp3Sxgg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CACRpkdYATkP2ONCxHq6+XsWM8949tXxd5r=OKM36dgwWp3Sxgg@mail.gmail.com>
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

On 26/05/2022 23:08, Linus Walleij wrote:
> On Wed, May 25, 2022 at 3:36 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>> On Mon, 23 May 2022 at 15:55, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>>> Nope, failed:
>>>
>>> $ dim push-branch drm-misc-next
>>> dim: ac890b9eeb9b ("drm/display: Fix build error without CONFIG_OF"):
>>> Fixes: SHA1 in not pointing at an ancestor:
>>> dim:     f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")
>>> dim: ERROR: issues in commits detected, aborting
>>>
>>> I don't know what to do with this, sorry. The other committers are maybe better
>>> with this kind of situations. I think it is designed to stop me from
>>> shooting myself
>>> in the foot.
>>
>> Linus, can we get an ack from you (or anybody else from DRM core) to
>> merge it through drm/msm tree?
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
>> After a second thought, I think the patch contains wrong Fixes tag. It
>> should be:
>>
>> Fixes: 1e0f66420b13 ("drm/display: Introduce a DRM display-helper module")
>>
>> With that in place would we be able to merge it through drm-misc? Does
>> it needs to be resubmitted?
> 
> But it doesn't apply to drm-misc... that's my problem :/

I think it didn't apply because of the Fixes from msm-next.
If we change that to the mentioned commit (1e0f66420b13), then you 
should be able to push it.


-- 
With best wishes
Dmitry
