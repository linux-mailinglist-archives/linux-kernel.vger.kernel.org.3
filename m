Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2347C4ECA43
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349172AbiC3RHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiC3RHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:07:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F280212AD5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:05:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so42816467ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Tj0NXhVhm7PGyEw1T3IIPx7yGFLG3tjmHr4oUiu0aBM=;
        b=A+SD9/FO0TL/gKjMkQJKNe7U2AmbJ+03I9pf5OplDO3o62aL9aZB0bfmXop0Cwyu9Q
         uB9gqqAdy/pD1ii7JGHUBIvJuFx+gqsctjIVWkFEfuCG64xYlijvuKUkYx41BTLSzLS/
         WH4IeaKte2epTvfA26x5YO5mQp06UhGRO3jWlgKWCdgg+gHcKMNR+lV+C9pRXcYMeyHx
         MNrr2Y2DSvIJmhRyh9JwrO/29C7nyQfnGno6cclU8yFoyH7/OnISb6YY88EEuh3i0YA3
         7WjUh4c0QIx3Gn7uIKF4QlCL8WNfrJd2ZpkaiZEtfbhsXyfqaOhds0BQUddYwosZb+wQ
         2b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Tj0NXhVhm7PGyEw1T3IIPx7yGFLG3tjmHr4oUiu0aBM=;
        b=Y1pzkGBxxtMAWw4BDVBCaWf4D2E1LxVpBkWw5ovZ5ECcmZxL2ZOwhVZtis9ienq9iI
         0+/OVzUS6q9/QwcgLkDYoeM74hyHKt27GshAAB1nGLtR1+Gzg/8CJpbJMwZqRE/3eGK2
         XlIJiVrYUafdin4FGW9InPViRX0g4d/NXpr+btHNcsZb7oK6MVncT8rAulT1of3kxgdT
         MRkIa8DEdG5bTiLxKd3UV6MREdh6s/CrK021t46JXmyjS3+LWbMcLDUkKELfck/oP4ua
         KyVrj4ibXCIztAghK7rcoJK1kSeaS+ap9HMy2gif6+QnHJkITINJLUVjraeuQ8c55G2j
         p22A==
X-Gm-Message-State: AOAM532Y2iQTDtXDUuxzboEBtw5unWfGhk9x70Y9HdvSoxSlxFXwZLdd
        hJC2XHDtE3Y0bTiCEs2q6sH64w==
X-Google-Smtp-Source: ABdhPJxDV3+M/9S6hZfXffPzQU3d3SBZw2wRZGcJOtZhc39pkVomwUVA9HxLnJdaS0KeGuJt/LS/6w==
X-Received: by 2002:a17:907:6d96:b0:6df:f199:6a7c with SMTP id sb22-20020a1709076d9600b006dff1996a7cmr552529ejc.137.1648659944508;
        Wed, 30 Mar 2022 10:05:44 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b0041952a1a764sm10233880edd.33.2022.03.30.10.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:05:43 -0700 (PDT)
Message-ID: <da21cafc-4e5e-cb5f-e7e5-ac9f223616a6@linaro.org>
Date:   Wed, 30 Mar 2022 19:05:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] thermal: exynos: fix masking value for artpec7 temp_error
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220330093905.191315-1-hypmean.kim@samsung.com>
 <CGME20220330093842epcas2p11a4e220245298c5729e4a37d1484d4d5@epcms2p3>
 <20220330094328epcms2p35a3346066ae7b3e8a489e2c81d44f8c9@epcms2p3>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330094328epcms2p35a3346066ae7b3e8a489e2c81d44f8c9@epcms2p3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 11:43, Sang Min Kim wrote:
> This patch is a modification related to masking of the temp_error value
> in the sanitize_temp_error() function.

Don't use "This patch" please.
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

>  
> For SOC_ARCH_EXYNOS7, the temp_error1, 2 value should be masked as
> EXYNOS7_TMU_TEMP_MASK(0x1ff).
> The current code masks temp_error2 with EXYNOS_TMU_TEMP_MASK(0xff)
> value even in the case of EXYNOS7.
> In addition, when entering the if statement, both temp_error1 and 2
> are masked with EXYNOS_TMU_TEMP_MASK(0xff).
>  
> By modifying to use the previously declared local variable tmu_temp_mask,
> the mask value suitable for the SOC can be applied.
>  
> Signed-off-by: sangmin kim <hypmean.kim@samsung.com>

Fixes tag?

Code looks itself good, so with changes above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
