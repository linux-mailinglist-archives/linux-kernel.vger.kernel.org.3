Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C027653A390
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351150AbiFALHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiFALHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:07:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498617069
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:07:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b8so1645400edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3osu7T3SV7pLFUm34eKitCGA5jgF7P0j4WJfxVS//Uo=;
        b=AVUhoQ/nFg8dyZ1q3x13KvZ7Drov/nf3LspoCrgYZT3+wsWj4NhiBCgxvM+7cOQ+J1
         SxX1OJbc/G/ncfQ1XBk4pYEJg8rN3J3vbvwUwov1+K+fP9klozW02WZ3tm7rdGURvd4B
         /g7c9mnF9FnQnPlz2rZ3gCYow/cKkxqZDvdhiq0zE1ViTzRZpAZGKhKUe6VhyvnAddO1
         CDZTfVB/2lh7WCBefCxQCGkl9pqev47arP5T4PlOar6ziMhbWm5EZXvPbsZCagz6H9fC
         FkURlKiX0Mr+kQne2/2TrweCIE7UaHyupWshlLfrbfiWpvgiXBjufGBMEf/gjeN5LDrP
         /86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3osu7T3SV7pLFUm34eKitCGA5jgF7P0j4WJfxVS//Uo=;
        b=NzmMMldmxk19KhbCKBC1d3xHS18ftAhFTFnIRzfPVHJiuNp7Lb6CxSjqtOUkVb/C97
         cfe0K4gRfMZFwQLEhcaVlbt+budOIPwU1VsSPvBjj8QWCvjhAN/lBwiFykoDkBsbUH7G
         BVx+quPZk0ZeDET7ZOXmujZR3KwQB5lO5MW+1ynK198SvvaUC1UaZFShPrkAeud2EaDE
         w1rwfBXFGOa3uGVMO/h19yCXGCGg/YGNoWSIiwhyiCxVS4sqFIBqzqHVqOZTyveihAIe
         faCJRPwmkQcMJNruL5ah++ecyYvvOmbIxoFoBH23Yg0SpCj6HJxCcymBI84w7NiidKwc
         x2OA==
X-Gm-Message-State: AOAM53281Qrz01d5KRbW3xLJ79iq4RrQzRXJKanXpFhJbRNWy/l8tH4M
        vhtMklEF54WeCuX3OAhZqyjBhw==
X-Google-Smtp-Source: ABdhPJzAj7OvNiQyM6nzDZUNqO/TAz1xsLnJbXtxMAkHg9+6yBHRkNb3jPVTDzszOc5c+1S5fxE8Vw==
X-Received: by 2002:a05:6402:3594:b0:42b:65dd:489 with SMTP id y20-20020a056402359400b0042b65dd0489mr52339189edc.222.1654081628855;
        Wed, 01 Jun 2022 04:07:08 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ay25-20020a056402203900b0042cf43e1937sm806712edb.75.2022.06.01.04.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:07:08 -0700 (PDT)
Message-ID: <c2f2a3a2-ea5d-59a7-eb84-d59b7d9bff47@linaro.org>
Date:   Wed, 1 Jun 2022 13:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD
 integration
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
 <fab40b87-7471-83a3-d154-aa2da0b7d23f@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fab40b87-7471-83a3-d154-aa2da0b7d23f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 13:03, AngeloGioacchino Del Regno wrote:
> Il 20/05/22 14:46, AngeloGioacchino Del Regno ha scritto:
>> In an effort to give some love to the apparently forgotten MT6795 SoC,
>> I am upstreaming more components that are necessary to support platforms
>> powered by this one apart from a simple boot to serial console.
>>
>> This series adds the necessary headers and support for the MT6331 with
>> MT6332 companion PMIC in the mt6397 MFD driver, along with some basic
>> devices.
>>
>> Adding support to each driver in each subsystem will be done in different
>> patch series as to avoid spamming uninteresting patches to maintainers.
>>
>> This series depends on another series [1] named
>> "MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper"
>>
>> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
>>
>>
> 
> Gentle ping to not let this big effort (with drivers depending on this one) get
> forgotten and wasted.

Yeah, but it was not even 2 weeks since posting and we are in merge
window. Please resend after the merge window.

> 
> P.S.: Mark wanted to merge the regulator drivers for MT6331/6332 from another
>        series that depends on this one (but compile errors due to said dependency)
> 
> P.P.S.: Lee: Reporting what Mark said (Full context in [2]):
> "I'll need a pull request for the MFD bits I guess, please make sure Lee knows 
> that's going to be needed."
> 

Best regards,
Krzysztof
