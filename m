Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6754F467332
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379134AbhLCIWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhLCIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:22:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0DC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 00:19:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o13so3970148wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 00:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C+Z4vejBCev8044vvB1NeqNLBeDPVXUFRoYWu/TaspY=;
        b=MtMtRE0zMGdSglKacnoIqHG94r88NMi9IBkw6VrS2aCA2Pftf2dg4YY0foOp/0i1C9
         hdzhCGcbPVzdf/6Um9gH8mTe1IbWhPf45UlRkui1Fj00A3hFLXbbxxM4g7qShSs86OmE
         ni9LCbEB/A34Nz3D/MU+F6u40bj7+Dx/jrrKtSELTO/pOZyeZVWjodFAX8NjdMZrRX7m
         YP6qLpjF+Z9gn78QzlSiar+rw8T19iLBX7LMvjk7YpBNwndWxeJsC0OqtMD1LDn9umdb
         g5mY5RpwwySNBd4/FR2fge1PaP5HtNASW3XaYDlZq3pVEwXtYWClj3jBEHpKC+i/UKmE
         ZFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+Z4vejBCev8044vvB1NeqNLBeDPVXUFRoYWu/TaspY=;
        b=4BHeLxeEdM+1BGJLuz6i9SuKRH24rO8Va3HO5gqKRDrqQ/sHbXnIiaTJIPWxpfAbwu
         qPG47uSA35ddREiMJob4/uBqfuVoRMeBVT210zYlpftXj+/4nJ1tbII4lvPS/9J20OnD
         TqPiz2BzKDp1Acge57N29xDlyjIHi0No9ijwM6HMtyT32P/4p+lFlLRHYIjvVlbP42R9
         t4OFx47f7kkQj48+IkzkUPUFSxQVYu6gGAZEIAFYNw5+5sv4a2oqL/CNu1SOHbnv675L
         UUHTPPnbvIDcGh450GpV/zE2QV6NtIZuozp34WMEQa1B+soXvTaFjrqmTr/0TxVi/WyC
         vZjA==
X-Gm-Message-State: AOAM532RCSd6FhNUQizZ77NhxX5BgzWhjubebi6xEPpbtMTnNVUi+2au
        vSAR9fUrD3WnHKW+uXRn2xJnlQ==
X-Google-Smtp-Source: ABdhPJwSIIgPG4RIodw5uVv64GtFJ8Jf1jCn4khk3SXwDKHFNvELsHfYB+JEPWFYLWCv9Dd+WCjaIw==
X-Received: by 2002:a5d:456e:: with SMTP id a14mr19647671wrc.256.1638519542678;
        Fri, 03 Dec 2021 00:19:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b56f:eb59:b51f:d674? ([2a01:e34:ed2f:f020:b56f:eb59:b51f:d674])
        by smtp.googlemail.com with ESMTPSA id g13sm1853738wmk.37.2021.12.03.00.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 00:19:02 -0800 (PST)
Subject: Re: [PATCH v3 1/5] dt-bindings: Powerzone new bindings
To:     robh@kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, arnd@linaro.org,
        heiko@sntech.de, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>
References: <20211201163856.41419-1-daniel.lezcano@linaro.org>
 <CAPDyKFor=OCOYqY2K9WyOa5FrM+tCE8KR8CuBOxHdz-ch9Tzkg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2a4224c5-175c-285e-6bee-2c775c9ea8ff@linaro.org>
Date:   Fri, 3 Dec 2021 09:19:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFor=OCOYqY2K9WyOa5FrM+tCE8KR8CuBOxHdz-ch9Tzkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

are you fine with these bindings?

On 02/12/2021 15:42, Ulf Hansson wrote:
> On Wed, 1 Dec 2021 at 17:41, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[ ... ]

> This looks good to me, feel free to add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe
> 
>> ---
>>    V3:
>>      - Removed required property 'compatible'
>>      - Removed powerzone-cells from the topmost node
>>      - Removed powerzone-cells from cpus 'consumers' in example
>>      - Set additionnal property to false
>>    V2:
>>      - Added pattern properties and stick to powerzone-*
>>      - Added required property compatible and powerzone-cells
>>      - Added additionnal property
>>      - Added compatible
>>      - Renamed to 'powerzones'
>>      - Added missing powerzone-cells to the topmost node
>>      - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>    V1: Initial post
>> ---
>>  .../devicetree/bindings/power/powerzones.yaml | 97 +++++++++++++++++++

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
