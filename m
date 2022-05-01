Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521925163E0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiEAKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbiEAKz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:55:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531F220C1
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:52:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b19so16250625wrh.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gI3zKVuvBUpZPNwk0dB8gwBv+CGbUeSGw/y6OnW6r8c=;
        b=CtPgKeF5HdYQZULbn/MAXZCcsMdJ5+cvC7NIboiysxlLDO6cwYO4o9x8IfcuVkKuu4
         4/5jloM5g70fjfncQ2LgacOLTcc+0VAvf4u633fW2dhmof7qxEo6TrXb+Ehm3Lixk8AU
         tgtXhkpxNmypa+bPHhygo7WolN1VTeWrnLgLLZVhLQ0hPVNTqdAujhFD2jOY0m+79sAa
         DTZxGYvO22hXiCiU5wmoDsx2tXGSSYvORBV1xFCjq98iwH3yD9HG45Dc/lHvU/KjIINC
         /W67UZRxwe0PUktriYPN6JOG0dO0/XsNSuHwYz98pL3jLpwwEPffBLWOTxbc1LFWk6Ob
         iWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gI3zKVuvBUpZPNwk0dB8gwBv+CGbUeSGw/y6OnW6r8c=;
        b=wegG3jRyzTQeyzQ6gb6ZyZuE2px8KoLy6kMP1oHZ12bkWSw0mRnxDENsogTz/1eLUR
         zhNNU/hSo0pd8Tc+T2zpbgzJ0bCTzPrg3M59s2sofSQXNvs26BM0LUzGARHJ0U2qs79l
         PTM+B95EXyGg82YkgOjrRD6cYajx1S0tYmJDXf1HgGRgX5MRGRIXrG2K+t52x6DYd4e7
         jNCw0b3mtdSjIQl6cFGV1TjmQik//v4347t7botzYALe38OilO6+g3rDxGVDlt9NpaSc
         QTsaN6ps952AXOsqOVlafciuK3zCR2JtXQqGhrwalGnDQssUgIgzMCeuSlK8UjBPU9PP
         zsDg==
X-Gm-Message-State: AOAM533JMeJeHvyl+P4E0Zh4iO08pIbXdXm8hsvYj3v6YuoUPMPGcktm
        WmKivWQQ2OG3xlN+KGVdPkyEKkAqOIKOnkmg
X-Google-Smtp-Source: ABdhPJx9hPPLFKI9qlHPlVLf4I/hiMjEzseqrhge4XJ1KueITL24n6+RLHVilawbKfTlaMdAnM92dg==
X-Received: by 2002:a5d:58d0:0:b0:20a:e9f0:aea6 with SMTP id o16-20020a5d58d0000000b0020ae9f0aea6mr5862673wrf.60.1651402321391;
        Sun, 01 May 2022 03:52:01 -0700 (PDT)
Received: from [192.168.2.222] ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id m12-20020a05600c3b0c00b003942a244ec7sm3682707wms.12.2022.05.01.03.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 03:52:00 -0700 (PDT)
Message-ID: <82beb918-8fc8-8949-1afe-6d708f2ac8db@conchuod.ie>
Date:   Sun, 1 May 2022 11:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 6/8] dt-bindings: vendor-prefixes: add Sundance DSP
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220430130922.3504268-1-mail@conchuod.ie>
 <20220430130922.3504268-7-mail@conchuod.ie>
 <6fdc6da4-3a34-e67c-cab8-1c9570501a8a@linaro.org>
 <f49b1d52-11e3-1c8b-bb1f-324318a7f669@conchuod.ie>
 <94bd3b92-fe6d-6bb4-8cbb-56ed52b9c4b9@linaro.org>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <94bd3b92-fe6d-6bb4-8cbb-56ed52b9c4b9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 11:45, Krzysztof Kozlowski wrote:
> On 01/05/2022 12:39, Conor Dooley wrote:
>> On 01/05/2022 09:59, Krzysztof Kozlowski wrote:
>>> On 30/04/2022 15:09, Conor Dooley wrote:
>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>
>>>> Sundance DSP Inc. (https://www.sundancedsp.com/) is a supplier of
>>>> high-performance DSP and FPGA processor boards and I/O modules.
>>>>
>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>> Signed-off-by: Conor Dooley <mail@conchuod.ie>
>>>
>>> If your @microchip.com email still works, then there is no need to
>>> double-sign it. At the end you are still the same person... unless
>>> you're not. :)
>>>
>>> This applies to your other patches as well.
>>
>> I thought that the last SoB had to match the email it was sent from?
>> If that's not the case, my bad. The @microchip email still works, but
>> it would've meant waiting til Tuesday to resend.
> 
> The "From" address must match the SoB address. The person, rather than
> the email, sending the patch should be the last SoB. I almost do not
> recall cases where two SoBs were added in such flow like yours.

That makes things easier! Thanks for clearing that up for me, must
have misunderstood.

Thanks,
Conor.
