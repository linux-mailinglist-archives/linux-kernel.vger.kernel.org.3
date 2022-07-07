Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203AC56A63F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiGGOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiGGOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:54:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EE72711
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:53:26 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id v185so17040734ioe.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7RZhPlwt1IWmYSR6QIVRvM1HZdmbksMxnLZ6G0dxCYQ=;
        b=dbVWNRlsTl7pk7ptifukmXY/Z4krWR8gWS1OPftdqSoHwDjWWnGVMVy30wrrJmPKKM
         m0ZjLpTxKOMe2z/X6TWznoYb3kbkXITLAxeWjACt51IJ9WoapHp2v1xGaRa9UDPSfk7X
         GpEOzxaenVdYrb//0k6tqNyS2ahPCcwz9r6jjuTurfbgqiOUgMcHkoLGNCx80BPAwRkb
         cqxPGv08JM1nzHaSW8paawSNd7Zk81EwVEk0stflMy7AX3tTrPs4FAgk+NK+wQg+euEt
         BYzYXF1shibZRX60BLl6dzud3s0hIauMRUtUgOp2j6JbGhDl4wOG53FHmw1ki6dzr9De
         07dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7RZhPlwt1IWmYSR6QIVRvM1HZdmbksMxnLZ6G0dxCYQ=;
        b=WOj8ZTj0pfqkDJTIDFKRJc4+1b/TeXfIqnF1zSugPUdV/JO0sk23ysAQ88n6GUfofn
         szUENSUq9GSLEHejI6RzqfZG6txLiTA0EL8Gu24dsO4wCNSMwDJDyC5ZyVnVbCbj6T8g
         F8V6bh9VH5VXnTHEK5tL4OwshGzAtCOq0lBpeS2/sIbsCyaLsDwfwu0jTae5BTLX9eID
         R6TwhNdSEqGrP7ho2SzMDxDat8Ye8Y59IKY/X1NZb8n/4mCmDhjWo5/YScYR3W1kB92P
         9hhW8nRF80kQerHWjERuP80utOGgMjJSPpPE6OoQYql2oyJFDADCodC05I1P+R+a/6Pp
         pS+A==
X-Gm-Message-State: AJIora9Dg8rgBWmhGLBQg06E75NRldA+EWsCXqfWAL0ZjVze7wCgZJdx
        edYp7YW3z8BUn/quiJKT4bA=
X-Google-Smtp-Source: AGRyM1trLe7RvY+9Rq0/Nq/y6Bbr3vIvsEr0rsX6bbBeVsNbTLy47V5SXuWGN+FGfuJ/2U+3fJpyLw==
X-Received: by 2002:a05:6602:154b:b0:675:8bce:8a5 with SMTP id h11-20020a056602154b00b006758bce08a5mr24784705iow.108.1657205605448;
        Thu, 07 Jul 2022 07:53:25 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w1-20020a5ed601000000b00675305c58bdsm14794205iom.18.2022.07.07.07.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:53:24 -0700 (PDT)
Message-ID: <15fe441c-205e-2953-44b4-d3c377cba7b1@gmail.com>
Date:   Thu, 7 Jul 2022 16:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] arm64: dts: mt8183: Add panel rotation
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220530113033.124072-1-hsinyi@chromium.org>
 <20220530113033.124072-2-hsinyi@chromium.org>
 <CAJMQK-jw+sgunEwgEQAw-V8DAbybZ7WVnZJ6vwOdzQ+-SX_bQg@mail.gmail.com>
 <c3286fc9-06ed-d1e1-a731-94cdefdf7fab@gmail.com>
 <CAJMQK-gJ4AoNQtLeKoOO=GLLtjDRhCdVnYuPJSBD4ZnFWJ5qrw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAJMQK-gJ4AoNQtLeKoOO=GLLtjDRhCdVnYuPJSBD4ZnFWJ5qrw@mail.gmail.com>
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



On 17/06/2022 16:25, Hsin-Yi Wang wrote:
> On Fri, Jun 17, 2022 at 10:10 PM Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>>
>> Hi Hsin-Yi Wang,
>>
>> On 06/06/2022 17:29, Hsin-Yi Wang wrote:
>>> On Mon, May 30, 2022 at 7:30 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>>>
>>>> krane, kakadu, and kodama boards have a default panel rotation.
>>>>
>>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>
>>> Hi Matthias,
>>>
>>> The series ("Add a panel API to return panel orientation") might land
>>> in drm-misc. With this series applied, we can add this patch to give
>>> the correct default orientation for mt8183 kukui devices.
>>> I didn't send this patch again with the series, since they might land
>>> in different trees.
>>>
>>
>> I had a look on Linux next (next-20220617) and wasn't able to find the mtk_dsi.c
>> changes. What is the status of this?
>>
> The mtk_dsi change got dropped. The latest is this series:
> https://lore.kernel.org/lkml/20220609072722.3488207-1-hsinyi@chromium.org/,
> still waiting to be picked or others' comments.
> 

I saw this got merged, so merging this patch now.

Thanks!

> If the dts patch is picked without the drm series, there will be a
> WARN, but won't affect boot or display up.
> 
> 
>> Regards,
>> Matthias
>>
>>> Thanks.
>>>
>>>>    arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>>>> index 8d5bf73a9099..f0dd5a06629d 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>>>> @@ -276,6 +276,7 @@ panel: panel@0 {
>>>>                   avee-supply = <&ppvarp_lcd>;
>>>>                   pp1800-supply = <&pp1800_lcd>;
>>>>                   backlight = <&backlight_lcd0>;
>>>> +               rotation = <270>;
>>>>                   port {
>>>>                           panel_in: endpoint {
>>>>                                   remote-endpoint = <&dsi_out>;
>>>> --
>>>> 2.36.1.124.g0e6072fb45-goog
>>>>
