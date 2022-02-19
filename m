Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052B64BC9BF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242797AbiBSSQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:16:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiBSSQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:16:04 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA967B576;
        Sat, 19 Feb 2022 10:15:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m14so11248484lfu.4;
        Sat, 19 Feb 2022 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=ZCklAq/Hx2JD+s8iRJLRBAzKBHd1Vzm6GJgE7/9rJMc=;
        b=UYwoW4i1T7TbzJAmNBBE/HsET4YSXMQnecavrbyKf7inSJeH4v/AfLKQ8XpquPHPFX
         iHWiMhWE8hnIwE5wwQ3x0sdr0DvGHneRSwv0U2sPFqcr7o2DoUyEq7lJM/bZLipvNcMC
         FGPUSRotuOyEZfkkLmM8T8ov0xh8zYlkKpiKNlY/bpuf2avLCS8tbvakdIc8fZiIcZAl
         uXtLVd8pJH3TJ8H9fpqUO8MzYZDNfYOJ12TTEqjdLsIjHcXOCObWpLBMGuA3JGPAAkIy
         B9O/fZAgXJHykF3mbMeYmOwvr5MNeDygsQx+NDu5kT8ZAWAalmLWUf9u70TYiNCsahas
         38ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ZCklAq/Hx2JD+s8iRJLRBAzKBHd1Vzm6GJgE7/9rJMc=;
        b=0JoWACQyFY0kQkUj4ZVmlqYI5JfRXQXWx8gb7jCANyBA/6+VG+0l5t74HWXYnHP+Ic
         TDfDFQ0G41sk16nil9bPXMGrunu8ftgYjXRmhRQnfwqCZZD2GcTaCQRQObbmOD67V9bn
         96eubvi/QSvhTnECE/96hy/qsL4ts1Cef5M8PznP5xCn3t3DgXxzKXV6GpnM5dYCxd8m
         gJBjSab27i5CvZ1NWzXN+N/h4KSrUTvod3J1MfvfuOdNGE5L7MbvxO+0dmgoPmbIZFYx
         OZbIQpqNdnby6cvcaSO776SW8ryhPSRjdBtyyUGsb7WEouFZZWvL7yDFVcpA78viN83W
         DuQw==
X-Gm-Message-State: AOAM533Gpno+B1tBsYqb6K71XDH78Ljm2mBIWKhuqe5v/+2ZvovzfgqP
        YtYu9CdjkIrg5xrCgGU0E8Y=
X-Google-Smtp-Source: ABdhPJwJdZ0Gd/bbMF0s0unbw8e1WaovO3J5g4uv+x1CAXGO8sdtzQ4dLL+prgBxwbaaJyAXR9g9RQ==
X-Received: by 2002:a05:6512:548:b0:438:a549:d499 with SMTP id h8-20020a056512054800b00438a549d499mr9082717lfl.326.1645294543281;
        Sat, 19 Feb 2022 10:15:43 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id v18sm729633ljn.78.2022.02.19.10.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 10:15:42 -0800 (PST)
Message-ID: <50838e8c-8121-d6fb-d693-031739829157@gmail.com>
Date:   Sat, 19 Feb 2022 21:15:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/9] gpu: host1x: Add context bus
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-3-mperttunen@nvidia.com>
 <1c97bbb5-ba0b-742c-2a21-8abf195b9e6d@gmail.com>
In-Reply-To: <1c97bbb5-ba0b-742c-2a21-8abf195b9e6d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.02.2022 20:54, Dmitry Osipenko пишет:
> 18.02.2022 14:39, Mikko Perttunen пишет:
>> +config TEGRA_HOST1X_CONTEXT_BUS
>> +	bool
>> +
>>  config TEGRA_HOST1X
>>  	tristate "NVIDIA Tegra host1x driver"
>>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>>  	select DMA_SHARED_BUFFER
>> +	select TEGRA_HOST1X_CONTEXT_BUS
> 
> What is the point of TEGRA_HOST1X_CONTEXT_BUS if it's selected
> unconditionally?

I see now that it's used by arm-smmu.c, should be okay then.
