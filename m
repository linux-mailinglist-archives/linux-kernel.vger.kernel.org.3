Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C078569F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiGGKJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGGKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:09:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5AF4F1B3;
        Thu,  7 Jul 2022 03:09:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l42so638035wms.5;
        Thu, 07 Jul 2022 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=U5N9NRe+aarCaMPvgWomO4spTpGm8g7FmpQ6Wwxj0Ec=;
        b=A4uxkAtMfuXZg8gnB/LkNTJPBjzYjXrBAu1Q9OmTfLske6rnBlRW99zlg+T3wf9Njb
         wmyupiAck9Arjv7wjo08zJIwD28JQ1A1zJKEZqDG032fPLLAYwOWHcSlkMz62KOt5zyB
         aklySu8q9v4uYNLygt0tZq2fUd9kC7nR3NRpzdwsgoEBcMcey1Jm7HnTt/jZRvUJGU4g
         crxxxa5/BfuIBuEuhuZat1pQEV7yml4TiLL0Pwuf8eL3Cga/Q516cFt3vZRtlPn4uxgL
         RYbA307x6uxTbMDXR7lXrAUWZNqf13aY8T6izpLPoETZ8qiwasptSIc8J5cdnXbAZQy9
         EEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=U5N9NRe+aarCaMPvgWomO4spTpGm8g7FmpQ6Wwxj0Ec=;
        b=oRuq1gd7nDoXGN7wq/gbvkoS/98CqQVddDY/8qJ30TpT2VLjiAoniw2YBKhcu++vQn
         as8GLyspbUVmClj73buk7c3gI4I86DY0+1j1HzDEZAn0Bsx4fvDKMF21p1rblGTtL5cy
         fU7NiUefg7t8sSjuTk5Xf5tcLD0ZWIWCAqHmmLkZ/7Vc8dTdH5vzHgNDD5aeiLG7Qlej
         kIwbjRir0LNa6Rq28rMzGiIVRwXvhzL4L7s4lUNruFqsO0bMvWFTPV9EJuV74PyWc4YJ
         Iu29wdzBog1MPlqN5dJu8SDaskY+5psWP30GCc85WimzQ8ES0Z76yRBkMivNbfH36TST
         Bt0w==
X-Gm-Message-State: AJIora/oM+Ai/P4ztnb5DA3+pnZgFpUKbaBJVK0vnmr0bEhhEYFADMgN
        ZxC1E8/pO/jsGV2O3/gjdPw=
X-Google-Smtp-Source: AGRyM1uOUlKx7fBRdBFHJa8xYeDNvkh9UirCJO4JvVwjt0+70qyCMuYlvn/y0H472lwD8+AcArb4Ug==
X-Received: by 2002:a05:600c:2049:b0:3a0:536b:c01b with SMTP id p9-20020a05600c204900b003a0536bc01bmr3589496wmg.151.1657188539215;
        Thu, 07 Jul 2022 03:08:59 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v7-20020adfa1c7000000b0021d6924b777sm11754085wrv.115.2022.07.07.03.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 03:08:58 -0700 (PDT)
Message-ID: <a0b81490-619b-6e80-472d-8e83ee4a1b86@gmail.com>
Date:   Thu, 7 Jul 2022 12:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] Add mt8186 mutex support for mdp3
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220705122627.2273-1-allen-kh.cheng@mediatek.com>
 <8b70f376-5f83-a713-c5de-ed5bba68c937@gmail.com>
In-Reply-To: <8b70f376-5f83-a713-c5de-ed5bba68c937@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 06/07/2022 16:17, Matthias Brugger wrote:
> 
> 
> On 05/07/2022 14:26, Allen-KH Cheng wrote:
>> This series are based on matthias.bgg/linux.git, for-next and provide
>> mt8186 mutex support for Media Data Path 3 (MDP3).
>>
>> Allen-KH Cheng (2):
>>    dt-bindings: soc: mediatek: add mdp3 mutex support for mt8186
>>    soc: mediatek: mutex: add mt8186 mutex mod settings for mdp3
> 
> Whole series applied to v5.19-next/soc
> 

We would need clarification if the HW block for MDP3 mutex is different from the 
one used for the disp mutex. It does not seem so. In this case we can just add a 
node on the corresponding address in the DTS.

Regards,
Matthias

> Thanks
> 
>>
>>   .../bindings/soc/mediatek/mediatek,mutex.yaml |  1 +
>>   drivers/soc/mediatek/mtk-mutex.c              | 23 +++++++++++++++++++
>>   include/linux/soc/mediatek/mtk-mutex.h        |  2 ++
>>   3 files changed, 26 insertions(+)
>>
