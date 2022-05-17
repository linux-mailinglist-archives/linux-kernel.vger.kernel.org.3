Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12A529CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiEQIng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243643AbiEQInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:43:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF57443EC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:43:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ks9so33280095ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2H+kyojoKMIqacwlCH+yjlqbOTerfAkahQ6Tr2/rTHg=;
        b=RuxlII7DDT22gV3GAwwJTVmCMCV4pDM4pbh+o3BD/8obibk5uM02ZTj7eCUeBuVoXH
         SN/TOA4EpDEQgZUVUSqNFUl8r/odk0k6Zw2w6nGkGPVivm4uqhHAzIb1S0exTpPv/CVl
         UHNifheqVZ1n43+Hxneac6yJGSZh/KVMplobKOtY9icqW1fuAFoVZhSdTigz5mwd3+I9
         LFiOVvcXzA+zcGoFSQ03X+W7J0+jB3YqoA2oQUxAblos7JNxydqJNQttB2HhBmSelDIB
         s5qWALHMM6w14rAV2KzlragLqUThmueQe93Fa9sZ28DAJ+9KrhZEvToL+TyR6qecoRGK
         EVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2H+kyojoKMIqacwlCH+yjlqbOTerfAkahQ6Tr2/rTHg=;
        b=fjgJzdkUNS6c6RfTTrSBbhY1+jb0lXQf/9lX5pA+R1CuTCn7mA4fRY/b+ZRR8ERBnT
         aktqoEXeZ5G1IiDIWZxy7kPvQ3m8oDLW1JTO+G5Ydz626uQ0dvvQQV31xgBOg3ibfV/8
         NyHIxpYmLv66Euas0OO4MDJe6Dd0JPojcDeWhOFY0AKfuuODN1+Mz73vpBQd5GUJNtqI
         EJ+cuX/Oe/hQMd5EU/tfZD6uG5jR0QKADaXzbJX1PzbMN6rKxNKhCCTtHIOOB2hhrut7
         XsSjttvwgbqYK1r5x3aqBIna69g1hNm3A0vzlul/I3z0ZkkbV/2Ml2gVu4kj4NxN9TbA
         OQiQ==
X-Gm-Message-State: AOAM530c+9ccfH/yTq5M9W9PausZgz1x4U3kg2x+CvNIcV7/YvsUv2MH
        uy8+a5LOtFwVN4sH3ioGkV7xFA==
X-Google-Smtp-Source: ABdhPJxtQjXQRb10lFqBAUzMfJDMOxeVz25FrJyNKeUEWXkNqJZB5jvCADp0PGfSltuUqftQ/W2Wkg==
X-Received: by 2002:a17:907:c28:b0:6f4:2a80:f355 with SMTP id ga40-20020a1709070c2800b006f42a80f355mr18406294ejc.101.1652776998992;
        Tue, 17 May 2022 01:43:18 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c14-20020a50d64e000000b0042617ba6380sm6658474edj.10.2022.05.17.01.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:43:18 -0700 (PDT)
Message-ID: <e77d83ee-c045-26a6-15bc-df49a3b880ae@linaro.org>
Date:   Tue, 17 May 2022 10:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 02/13] dt-bindings: Add headers for Host1x and VIC on
 Tegra234
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
 <20220516100213.1536571-3-cyndis@kapsi.fi>
 <20a7087d-dddd-134b-4cef-0ebcbc5115f3@linaro.org>
 <3b1e22cf-a439-2d84-a1fc-dd352a3f1b2c@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3b1e22cf-a439-2d84-a1fc-dd352a3f1b2c@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 10:41, Mikko Perttunen wrote:
> On 5/17/22 11:02, Krzysztof Kozlowski wrote:
>> On 16/05/2022 12:02, cyndis@kapsi.fi wrote:
>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>
>>> Add clock, memory controller, powergate and reset dt-binding headers
>>> for Host1x and VIC on Tegra234.
>>>
>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> All your patches are send from wrong email address and the SoB chain is
>> not correct. Please add respective SoB.
>>
>> This applies to entire patchset.
>>
>>
>> Best regards,
>> Krzysztof
> 
> I can do
> 
>    Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>    Signed-off-by: Mikko Perttunen <cyndis@kapsi.fi>
> 
> if that is better.

That's not needed, if your name was in the sender field. The trouble is
that your name was not there and I have no clue who is cyndis@kapsi.fi.


Best regards,
Krzysztof
