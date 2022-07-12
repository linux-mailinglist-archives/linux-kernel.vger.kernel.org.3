Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4985720A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiGLQUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiGLQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:20:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B218CA6F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:20:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id e28so11210423lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pPvdo6E/8z4yuwllWLa9VmBaE7sTUkZvuVnN88mQiew=;
        b=pjHJ6TMi7gYiJfM3BBjUdaGo3Pz31kFTgqMi699hX4dsUEuKdWS/SzqioBK9aMSMxz
         jv4bOKzp+vs3j3+I7kcyVuq3zZoWverBE5sE6grD7VEmf6urAWnTCriJJI0qpulJueF2
         CD7FkE+R6b390qI+JOU0yrli0gfymIxGZaK3ZMNvhlS9iWHKEDmDFrQCHxsg33RZ7TD1
         HIH8JwEm0etHsY2yiAgX9QeWaUI96KZNE7sS6iK3cW7m1Ubo5KL+KMzjEoCTulsdY2PA
         WVaZIR/1ljH56ZSpM7ga0WEbM+FHYJKi6ZxM//HZRk/CnivStkxw6KOFjZKwR4Nkt1zT
         oyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pPvdo6E/8z4yuwllWLa9VmBaE7sTUkZvuVnN88mQiew=;
        b=ShQBGknp/kGlp1u8gWsjrkhzyJCmum2kT/MrDrwF3u2WZQNh9bmVB4UmD+qDX48Bpv
         5bPXwSGM48A5K0axFTNZWJ7W/q9mhnIcSwiH10PH00hyELFK+rfQqvNRU86tA8o+LpA9
         fUzvGTH8eAk+gYjNm9md3vclYUTnMZCsX6dAftvP5sI+oh5eZJXju/kWDDbfq+QktuEr
         51EquF+GOTGhcgXP5ZZ7zxgjs2VEnEWHwAXfGNVgTS2vAtHz0WNnW8QYPqR3RUk7iGcg
         lND8RTYZBJf2/V7fBNBliKgPQFiZxoaabF0QrI7xQBE1tVReZL9QTInkpeVDlEg3XxBp
         IJyg==
X-Gm-Message-State: AJIora9457M9Ja9mcp5lYSKAaFIJ8CwWrVewaiYdcs3a5QEThVlM9KyD
        prATqk1PYFH0Saz/Kvlt2zU7FA==
X-Google-Smtp-Source: AGRyM1v98KWxppvdS1K4LP70/57yD3snxlG0GqUiLRvcK8eTNrXTs4BZtDFfUmG8nkYMA6we7cMSvA==
X-Received: by 2002:a05:6512:1381:b0:489:cd0b:3a03 with SMTP id p1-20020a056512138100b00489cd0b3a03mr11481588lfa.583.1657642842608;
        Tue, 12 Jul 2022 09:20:42 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b00477c0365b20sm2263111lfr.188.2022.07.12.09.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:20:42 -0700 (PDT)
Message-ID: <09c807b3-67c4-1439-793d-2b7d461f4656@linaro.org>
Date:   Tue, 12 Jul 2022 18:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/7] iommu/exynos: Handle failed IOMMU device
 registration properly
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-3-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220710230603.13526-3-semen.protsenko@linaro.org>
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

On 11/07/2022 01:05, Sam Protsenko wrote:
> If iommu_device_register() fails in exynos_sysmmu_probe(), the previous
> calls have to be cleaned up. In this case, the iommu_device_sysfs_add()
> should be cleaned up, by calling its remove counterpart call.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Fixes: d2c302b6e8b1 ("iommu/exynos: Make use of iommu_device_register
interface")



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
