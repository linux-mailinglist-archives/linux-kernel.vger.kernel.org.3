Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E042590E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiHLKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiHLKDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:03:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D975AA4E3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:03:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so702948lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7XCMouDowcv3LrNhIXPQ3Y5PTFI9QQ/MPyoPgacMrBE=;
        b=rhZ1Y8wuTv6tETnnEUcu4kXuxhUVCd0Qjj2ZcY6rurXdhS0cLI1z94igGIm1ACF9CQ
         eI6hgdo1Qcy7RHQWrPDQq8qKRYy79Rg7NCZfQqcjXDPQx+bd7NsgAOChY7HIwgjrDQ/A
         m3XCgqp6t4YfllXTM4SSGuEjUd7FPs7E26XM9jtnd1xIxFSQlwNZx2gCGeTVTZrVaLmp
         lZjFMuDC3Gtr7WtmrzP8hlATvkxtQJn3MUyPZ/32g7w0cixe0KS6a6ArHfsrREbTQMoV
         PXD6UNO7f1+eoOijDjSFWQziCeRYlpR2qQuNorYAmPQS3WvJk2CRQZLwXZWNVKh+bKUr
         G9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7XCMouDowcv3LrNhIXPQ3Y5PTFI9QQ/MPyoPgacMrBE=;
        b=6/NO9OvTWXZifmc7vcE/mWQOjQu1ffwPXpzSIgUbfWM1azwEDpdTRd3peJ1Jnm0bU6
         2DwpidEL324/ji6jr5htlZCQibDvWyeGKipnuXhm5S2xz+3C6kjeA5SysGQCg4XCsUZM
         EAshXMc+ZpeyTbrs1HJH5Lp+o8wcN5C3Df03CRclZC/wsl4YcpK2IzMbrZ19AHTLGxlp
         sFP5moOb3OuSzcwtlrACr3l3+sQ0MwTfqtM7bXO7vDHmWqTMQRthLuJXN2y3av2DrYce
         aSCanuyDlOfCKwD0raOqC3x9Hvi7LiuIXrYobB60UisdzDApopKNs+SFxxRsQ6c7cFxC
         SMHQ==
X-Gm-Message-State: ACgBeo0EVyNj+az11dTsCiyI5OiwKLVOWzULdcnKBjdSoHf4T578IGmP
        IGJ0KrESllMgP/JxNYlXGXIx2Q==
X-Google-Smtp-Source: AA6agR4Q2zKJuK5lITEVBPgcjvjTJoOGAyrwneRqBBawJ91Q6mMigIMsYYnZ8xwOnk8YuaziOl5CDQ==
X-Received: by 2002:a05:6512:a8f:b0:48b:685b:4ebc with SMTP id m15-20020a0565120a8f00b0048b685b4ebcmr976744lfu.258.1660298582823;
        Fri, 12 Aug 2022 03:03:02 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b0048a9f1933f2sm155333lfc.247.2022.08.12.03.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:03:02 -0700 (PDT)
Message-ID: <a9a0e625-6476-02b4-18ba-9ab2e4e9925b@linaro.org>
Date:   Fri, 12 Aug 2022 13:02:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 18/26] thermal/drivers/exynos: Replace
 of_thermal_is_trip_valid() by thermal_zone_get_trip()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
 <20220809220436.711020-19-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809220436.711020-19-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 01:04, Daniel Lezcano wrote:
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Missing commit msg.

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)



Best regards,
Krzysztof
