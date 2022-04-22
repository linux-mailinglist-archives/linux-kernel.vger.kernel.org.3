Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D89F50BBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiDVPne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiDVPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:43:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E9583A3;
        Fri, 22 Apr 2022 08:40:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso8201982wme.5;
        Fri, 22 Apr 2022 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ES0l6S93mE+Wb+3kqpTJgwQ5QqgD39UykyyH0mPFa1A=;
        b=eAJDeSA5ES65uo2n7FwOPrhjMXpb1/30wYGIYDKU1AzFS1Oqvazunp1Lgruo6FULJd
         N1IB7K2+Ifwa9kYQkwb3cmGFVMpYNerQIo6Xf5XWsYkCezu38OlPmhnwNMBTL/W5oCn2
         L75ox71Pu3LZ/UYtIbm1TWt+gVsRU+MzQneRGct7i/4SWy81zHrPejYrVdeI/YMaPpPx
         HmXn74qleRfqwuZZ2MVnbuefcR2uqjqw5yZFHI09alDi/A25qW1nE0me6ZBWB4tJciqf
         3h4tTceozSY5WFT6wJ/px99wf0HGPFeQ2Mvngrekpv9MRQunqTkTNZxTeL/FkV9IMbNe
         XHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ES0l6S93mE+Wb+3kqpTJgwQ5QqgD39UykyyH0mPFa1A=;
        b=i16dVesuOrpmaFQGvUc54Z+kr6riITFAKIMhsXtUq38VPU/jiAnuC0p67lmfmH+hTT
         nZ/OSly2xI/+AQLDyd7eO0kCd5BOPgTZv6wclepII+e++qfufcSG9kQXxuPALirEKSh+
         hcLc0i5rtYMIZcLJ0eW/oyJthe+LsTT6mC72cbPF1+kAEhnLqQ7duSGNhw0ALNxHXbqj
         V4IjG+wxwSy2Ccpic2K/ZmA/r1wcOJD+spsPuMINFIjJvN8OVYCseT25venDPjtcIi2w
         45MqVLegkUVZOzGBlyGf3GWIcOIOL5NkgfotNoUVRe+fih+xMi4qFB7s2WSV1nDJx3Q2
         a8OQ==
X-Gm-Message-State: AOAM532mA27PQIWb6T2ZmUB/6SJSICViHi3x98X/ztaPLlCZX82t0VDe
        LJeaACx1ozfa4i7c7cixY0g=
X-Google-Smtp-Source: ABdhPJyTYQRjuZT+Ec8SM434CWQGeFUn2UkQ3zQWg/RiYa7Z+9pAMLI2nF/jZpTCnEOzRThwH++fmg==
X-Received: by 2002:a05:600c:1e1e:b0:38e:baaa:aae0 with SMTP id ay30-20020a05600c1e1e00b0038ebaaaaae0mr4563460wmb.157.1650642029069;
        Fri, 22 Apr 2022 08:40:29 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y11-20020a056000168b00b0020a919422ccsm2434199wrd.109.2022.04.22.08.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:40:28 -0700 (PDT)
Message-ID: <9a766c52-f085-0ce4-5072-5a602e533740@gmail.com>
Date:   Fri, 22 Apr 2022 17:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/3] Fixes for Mediatek dt-bindings
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "N?colas F. R. A. Prado" <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20220225225854.81038-1-nfraprado@collabora.com>
 <20220404152256.mkksr4oqjt65ytlf@notapiano> <YmLGyIOStJJAGSJG@builder.lan>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <YmLGyIOStJJAGSJG@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/04/2022 17:16, Bjorn Andersson wrote:
> On Mon 04 Apr 10:22 CDT 2022, N?colas F. R. A. Prado wrote:
> 
>> Hi Matthias,
>>
>> Maybe you could pick this series through your tree? It addresses some dtc
>> warnings that are introduced with the new nodes in mt8192.dtsi that you just
>> picked up on your v5.18-next/dts64 branch.
>>
> 
> I don't see a reply from Matthias, so I've picked up this (the
> remoteproc) fix in our tree.
> 

That's totally fine. I'm reluctant to take random dt-binding patches as it can 
provoke merge conflicts when there are other patches on the same binding taken 
by the driver maintainer. Normally I leave it to the driver maintainer to take 
such kind of patches.

Regards,
Matthias

> Thanks,
> Bjorn
> 
>> Thanks,
>> Nícolas
>>
>> On Fri, Feb 25, 2022 at 05:58:51PM -0500, Nícolas F. R. A. Prado wrote:
>>>
>>> This series has some fixes for Mediatek dt-bindings. It solves some
>>> warnings printed by dtbs_check, both for already merged Devicetrees, as
>>> well as some that would be introduced by the changes to mt8192.dtsi in
>>> [1].
>>>
>>> [1] https://lore.kernel.org/all/20220218091633.9368-1-allen-kh.cheng@mediatek.com/
>>>
>>>
>>> Nícolas F. R. A. Prado (3):
>>>    dt-bindings: remoteproc: mediatek: Add interrupts property to mtk,scp
>>>    dt-bindings: usb: mtk-xhci: Allow wakeup interrupt-names to be
>>>      optional
>>>    media: dt-bindings: mtk-vcodec-encoder: Add power-domains property
>>>
>>>   .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml     | 3 +++
>>>   Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml      | 3 +++
>>>   Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml   | 1 +
>>>   3 files changed, 7 insertions(+)
>>>
>>> -- 
>>> 2.35.1
