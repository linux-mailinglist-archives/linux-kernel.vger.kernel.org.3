Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D542D53A35E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352217AbiFALAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351590AbiFALAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:00:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA487A28
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:00:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n28so1628573edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KT/SgWw/Hw0WKZaDwYH8usaKfs0dydPl+6sV5mw9Js0=;
        b=s7ZnjSmHN0XMUgG9VPsibbZ9xhVHFOFc9K5hY8SuQsDI7loybtXxgxS9g2alpFCf8Z
         DnJcUR/gSxk96dAZqDepc3429N3GeHkTGBWo+/71w7fOvOOQJNAcXEIIjnNIjnm7aqOq
         M7Tkh+SIR2e/napBPQg2JX3ijNyDp8kHwNHxjPvAefR1LyWmh2VR/jbDv8li/v13A7b7
         Kkm7xDQur3X964QEjH/lkuPycF6zW4Qp9QS9Kfo81BkKY0FYr5qyoZlsIjWFjOc5gPZ2
         jU14YdhOqdtWpM5GRl4Ge1mlHE4z/DxDJtk7PHjkjgnEWxI+Y2k1TWXOkrBKOxsnBGNo
         dlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KT/SgWw/Hw0WKZaDwYH8usaKfs0dydPl+6sV5mw9Js0=;
        b=BraEMZ9CJ80sowga5TWwKp9ttWHiSGZlEGA3Qi0t6yYDc5eNZymY5+dVbTi+rcxLPV
         oE805PL1Faw3sy2d+1Z5WCmaKlakAkZguW8KwP71POuztCiDPN+P2UVEkuaJVPk8P4M0
         rXIxZGElTT6aS9opjC/i7XZdAFZkLkKoDBP5VosFGCpPvbpy/B6BwUd6lgPiyFFZRZBb
         es/wTnYTZFafi1DFVE7vvfEzQG6WBXhRlkKAE5nSjh928EHDYdTfCBuFJ8DF0/ARCaZ3
         5o7wgU3LoFQdV/zSrGRk7s4YNNCgBcPRgX4m9pHU/pSpfbYuttl1ohDurgWCsaKeM/hv
         TJ1Q==
X-Gm-Message-State: AOAM530PydyTK8oMs+780CU/JkO3pOT+h5KYa+9alYvQm34Z0uNc1awZ
        +jlVMwgMNVqELvzmNSHs2nuEVw==
X-Google-Smtp-Source: ABdhPJwMjcLypyEXu3G39Ns6ihFcyzx/tRjtuxM/CyNbT1pUVe+YxlIZoqpenLgPwevNGqmGfXgdeA==
X-Received: by 2002:aa7:d9d9:0:b0:42d:f9e4:49e0 with SMTP id v25-20020aa7d9d9000000b0042df9e449e0mr2065854eds.299.1654081240809;
        Wed, 01 Jun 2022 04:00:40 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lc26-20020a170906f91a00b006f3ef214e5asm564503ejb.192.2022.06.01.04.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:00:40 -0700 (PDT)
Message-ID: <630b0d13-6778-2508-6a34-9daa0358047d@linaro.org>
Date:   Wed, 1 Jun 2022 13:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2 1/2] clk: hisilicon: add CRG driver Hi3521a SoC
Content-Language: en-US
To:     "Marty E. Plummer" <hanetzer@startmail.com>
Cc:     arnd@arndb.de, cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
 <20220501173423.2473093-2-hanetzer@startmail.com>
 <f42cb4d0-7133-eea5-b456-b5169bebfad1@linaro.org>
 <20220601105846.7hriawg3stxb657f@proprietary-killer>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601105846.7hriawg3stxb657f@proprietary-killer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 12:58, Marty E. Plummer wrote:
> On Tue, May 03, 2022 at 01:37:42PM +0200, Krzysztof Kozlowski wrote:
>> On 01/05/2022 19:34, Marty E. Plummer wrote:
>>> Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
>>> generates clock and reset signals used by other module blocks on SoC.
>>>
>>> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
>>> ---
>>>  drivers/clk/hisilicon/Kconfig             |   8 ++
>>>  drivers/clk/hisilicon/Makefile            |   1 +
>>>  drivers/clk/hisilicon/crg-hi3521a.c       | 141 ++++++++++++++++++++++
>>>  include/dt-bindings/clock/hi3521a-clock.h |  34 ++++++
>>
>> Bindings go to separate patch. Your patchset is unmerge'able.
>>
> So, assuming I have the following patches:
> 1: +include/dt-bindings/clock/hi3521a-clock.h
> 2: +drivers/clk/hisilicon/crg-hi3521a.c
> 3: +Documentation/devicetree/bindings/whatever
> 
> In what order should they be applied?

Applied or sent? The maintainer will apply them in proper order, this is
bisectable.


Best regards,
Krzysztof
