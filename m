Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF31529CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiEQIsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiEQIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:48:43 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8476043ADE;
        Tue, 17 May 2022 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XpPlQoFkEA14izG0/3owwVuWJtisit8G2XM/kloA1D0=; b=YPvloaBhaF9ZBDhNcnSM4a/vxg
        P6y9T4Qz0pBvqEBE7H/Yr32K6LmCZmH/YQVfuA/mrN5iupQPmDe8JsLc9PY05Yax2JOVqoWgjJKTy
        WZW7Sm4CCcxc3KXtZ+qNTgMJ5XIpgodC6X7Dp102SU9d67c1N6mGPcmMs11RgJeehYudmnGOsRHNa
        bQt5WkXXLLro1PxmO23FJRUljSfJKXXNoyMv/LPnQJki2QH21JgDbO7Oa9hlq+gQ+vqFON3XF+a/D
        V0w9BzerUg08oOJXrxdazXmuRPJ5ebpGjGjLpeuLwA65FprteaCWSponhfOL0UpkjMK1Wa//Q81im
        UXyXDT7w==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nqsse-00027X-86; Tue, 17 May 2022 11:48:36 +0300
Message-ID: <9ee48521-c853-e07e-1f0b-90e9a46af728@kapsi.fi>
Date:   Tue, 17 May 2022 11:48:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v1 02/13] dt-bindings: Add headers for Host1x and VIC on
 Tegra234
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
 <20220516100213.1536571-3-cyndis@kapsi.fi>
 <20a7087d-dddd-134b-4cef-0ebcbc5115f3@linaro.org>
 <3b1e22cf-a439-2d84-a1fc-dd352a3f1b2c@kapsi.fi>
 <e77d83ee-c045-26a6-15bc-df49a3b880ae@linaro.org>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <e77d83ee-c045-26a6-15bc-df49a3b880ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 11:43, Krzysztof Kozlowski wrote:
> On 17/05/2022 10:41, Mikko Perttunen wrote:
>> On 5/17/22 11:02, Krzysztof Kozlowski wrote:
>>> On 16/05/2022 12:02, cyndis@kapsi.fi wrote:
>>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>>
>>>> Add clock, memory controller, powergate and reset dt-binding headers
>>>> for Host1x and VIC on Tegra234.
>>>>
>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>
>>> All your patches are send from wrong email address and the SoB chain is
>>> not correct. Please add respective SoB.
>>>
>>> This applies to entire patchset.
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>
>> I can do
>>
>>     Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>     Signed-off-by: Mikko Perttunen <cyndis@kapsi.fi>
>>
>> if that is better.
> 
> That's not needed, if your name was in the sender field. The trouble is
> that your name was not there and I have no clue who is cyndis@kapsi.fi.
> 
> 
> Best regards,
> Krzysztof

I see, that makes sense. Looks like when I did the above From field 
change I must have messed up my configuration somehow since it looks 
like older patches I've sent do have the full name.

Thanks, I'll try to fix it for next version.
Mikko
