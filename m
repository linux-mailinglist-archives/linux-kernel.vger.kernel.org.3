Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4E4C4CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiBYRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243928AbiBYRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:42:18 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3641EBA98
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:41:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so5571586wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hK70hB1bYpjbVyMofhuVieiReBXP1Q8ylw0iiDbK2jc=;
        b=pYT807/Ddu+PJ4DbYHixEmSpN6a5NdIAWnVilVXYLIw2wDgEczBiK+koTqrBFwnDnt
         dBT+ZnL3Nd2Dio5qWZbHsNXD+P3Swo88zMHWww/1CdBAOr922HWY4EurVXkQ4KiJwshn
         hfE09/D0MjzsrKFdYMIZDwvu5Kc0uslxs+k3/eHM0ulyZJG1+TYrWbSpP+kleu+/fjBU
         8vRKc28RTptiuoehyUSq+WJ2kcobxNR25JW8eRW7FJzwOwpKbUwpsWgfKOvXASRsWCEq
         hvj3SJc3RC/jRQxaeTOuDsj75bkqR96qNa0xvN61upLYTmE/8aHsg4JVTNIUAJK3OwVN
         Gskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hK70hB1bYpjbVyMofhuVieiReBXP1Q8ylw0iiDbK2jc=;
        b=RnIBulQMYKurcN2PHAMl8KSl7Pl3PUmA520Hh6Z5vnmhdIfH4Qji8hgPF3oG8BbqAr
         HWLSw3tM8u2gPrno0y2hLmSQ/Q0m8qWuQUBiGXlhFlEXvGrh9e4i1YWeZRpUw1DlrQJP
         R7O5H/p7kDPsCKBWUsNFUX4Gd5dSZLjPZW96m5161d45isFR0IuujbRPgFgd8fNgU7zH
         qkwL+szlulNW9rgX4SFvhIryrzCwb8oCboUCoPBjlxu0uD/SPSUtXJeU829MKKIYzI+e
         XpY7yq8vTckEjwF9tCbkXz/v85qYxQmXpaamQEHWTHTBDcfM9tBVFJGSMAq6KOgY6dEc
         2Qxw==
X-Gm-Message-State: AOAM532QWZKNcIJ0ejdtGC4KDkm/SFmMwl/1ypVBPZWAQHKy0XQI7az9
        vieFAaF2Tw3mxG4zxGSjNsVYLw==
X-Google-Smtp-Source: ABdhPJyqECsYMSy9W//bYsi3ZSr60A6g/+WllmvOLJTwk4EhLJjt7hkciZ9zBGH3oFXlXWDiHg4/KQ==
X-Received: by 2002:a5d:514b:0:b0:1ee:aed1:d48f with SMTP id u11-20020a5d514b000000b001eeaed1d48fmr5708767wrt.662.1645810904477;
        Fri, 25 Feb 2022 09:41:44 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:e11c:33b1:8704:339f? ([2a01:e34:ed2f:f020:e11c:33b1:8704:339f])
        by smtp.googlemail.com with ESMTPSA id z5-20020adfdf85000000b001e713f774d3sm2850442wrl.61.2022.02.25.09.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 09:41:43 -0800 (PST)
Message-ID: <3abfc379-d353-6caf-0cf0-83559a460be6@linaro.org>
Date:   Fri, 25 Feb 2022 18:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] drivers: thermal: tsens: respect thermal_device_mode
 in threshold irq reporting
Content-Language: en-US
To:     Benjamin Li <benl@squareup.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zac Crosby <zac@squareup.com>, Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220120200153.1214-1-benl@squareup.com>
 <422bd780-354d-d4ac-7b7a-8060325fc13e@linaro.org>
 <CACOsgWZ7KFSqC21sSq7hGYk_g2RoKTPPfoYQwcWmwCNSx5c-YQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CACOsgWZ7KFSqC21sSq7hGYk_g2RoKTPPfoYQwcWmwCNSx5c-YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 17:46, Benjamin Li wrote:
> On Fri, Feb 25, 2022 at 6:02 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>> Some drivers that support thermal zone disabling implement a set_mode
>>> operation and simply disable the sensor or the relevant IRQ(s), so they
>>> actually don't log anything when zones are disabled. These drivers are
>>> imx_thermal.c, intel_quark_dts_thermal.c, and int3400_thermal.c.
>>>
>>> For tsens.c, implementing a change_mode would require migrating the driver
>>> from devm_thermal_zone_of_sensor_register to thermal_zone_device_register
>>> (or updating thermal_of.c to add a change_mode operation in thermal_zone_
>>> of_device_ops).
>>>
>>> stm_thermal.c seems to use this patch's model of not disabling IRQs when
>>> the zone is disabled (they still perform the thermal_zone_device_update
>>> upon IRQ, but return -EAGAIN from their get_temp).
>>
>> What is the concern by changing the core code to have a correct handling
>> of the disabled / enabled state in this driver ? (and by this way give
>> the opportunity to other drivers to fix their code)'
> 
> It seems fine, is that the preference? Updating thermal_of.c to add a
> change_mode
> operation in thermal_zone_of_device_ops?

I'm not a big fan of this duplicated ops structure but preferably it 
would be better to put it there (except if you see a better way to do it)



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
