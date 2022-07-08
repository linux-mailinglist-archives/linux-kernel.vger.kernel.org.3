Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8156B46D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiGHIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiGHIW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:22:57 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D1B81497;
        Fri,  8 Jul 2022 01:22:55 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d3so19046375ioi.9;
        Fri, 08 Jul 2022 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Akov7SZtUyEX9D0+3zzLnuIGNu/dLwAPRoI7n7xKXwA=;
        b=TRV50Pwd5sFVo2E1gPlLsmgMiLSKMpheIV4nJ2xcXHBx97J8Am/NdIsQmb5jiSueRF
         khKbAvo7q6avJHCZi7XdEzpRx9PIwpak6EdVOisplHkLfW6Vsbsr7bljDySt/V/2BEbJ
         q1gMNptzMFfKjBChwI0lnmtdrb+RPDAPzhWyYuoqe10Lo71y9vleLsbPmakin0OmMVKL
         uWXfsHI9iEjKUEe6mpVLpjQo1HRjDLZFP499HogUkQ598g5o9PWJ4CrLEXomSYOP9vGh
         mMPyIME28eRynOIhLPAsTuFMOwg5M8CMFxst36RJIp/b74fT0wj00cAxc8zxkpGNp29I
         YsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Akov7SZtUyEX9D0+3zzLnuIGNu/dLwAPRoI7n7xKXwA=;
        b=tTPYXQkv0ROfMo+ok243qqWc8gBm5ES2KZlT2BKz2/aRgcD7SDYtgjn4vom7I96+zJ
         5enrAM9XtQLXwZEmldPOhRiFWekmkbgk/aT0vbGKnHBwvzkFhwEvvj04D7b2gIQb7vsN
         Wc3a9jUNof7cbmiw+0mdO/Hoym9yX8QmkhshbfElwHTD/Sp0WMCSTh4teA8xDgmufW+u
         DBhhG2oCuc0lgR3Ea5vb5Z0nMlzB9daWDvaYkp/uSbkJgzH6iGW0LonvSorekWIMMBqK
         Eksi4yX4RW+c+wAl2fVQpcMMawNhEw13p/J8aFJfoyfj5pEL5CVuJzGv5FcoJXcG32+T
         4+ug==
X-Gm-Message-State: AJIora8HfHYp/jRhBjNg42ktSF+v99mqCkHTrQhzK49CQH4BNOqXnqUs
        CXKtyUDNCvOa9BSDV945oJoXXP8MyCRjnTFB
X-Google-Smtp-Source: AGRyM1tfdSkTBt7EaCr+m3mYoeilSPCzVf9/PiNlHAX15oqMZh5CVi/9v4QlhKpiOcCqveypnOPygw==
X-Received: by 2002:a02:a70f:0:b0:339:de0d:4ed6 with SMTP id k15-20020a02a70f000000b00339de0d4ed6mr1413393jam.292.1657268575018;
        Fri, 08 Jul 2022 01:22:55 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r3-20020a02aa03000000b0033cd78a3612sm10838734jam.18.2022.07.08.01.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 01:22:53 -0700 (PDT)
Message-ID: <184ce9e3-6031-98ab-cae6-a4aa2015b5c4@gmail.com>
Date:   Fri, 8 Jul 2022 10:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] arm64: dts: mt8173: Fix nor_flash node
Content-Language: en-US
To:     "xiangsheng.hou" <xiangsheng.hou@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bin.zhang@mediatek.com,
        benliang.zhao@mediatek.com, linux-mediatek@lists.infradead.org
References: <20220630090157.29486-1-xiangsheng.hou@mediatek.com>
 <20220630090157.29486-2-xiangsheng.hou@mediatek.com>
 <24bf3c0f-7070-0bcd-2fae-9fe086d146b2@gmail.com>
 <e4a50d4e165887ac4741c0b8d68470dc2f060655.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <e4a50d4e165887ac4741c0b8d68470dc2f060655.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2022 03:40, xiangsheng.hou wrote:
> Hi Matthias,
> 
> On Thu, 2022-07-07 at 16:43 +0200, Matthias Brugger wrote:
>>
>> On 30/06/2022 11:01, Xiangsheng Hou wrote:
>>> Add axi clock since the driver change to DMA mode which need
>>> to enable axi clock. And change spi clock to 26MHz as default.
>>>
>>> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
>>
>> Applied, thanks!
>>
> I will send a new patch v3 since there need a change in [PATCH v2 2/2]
> by review.
> 

Thanks from letting me know. From what I can see, 1/2 in v3 did not change, so 
as I already applied it, you could have dropped it from the series.

Please correct me if I'm wrong.

Best regards,
Matthias
