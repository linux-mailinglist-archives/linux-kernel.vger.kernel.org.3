Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAE54F8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382713AbiFQOK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382694AbiFQOKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:10:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C47B515B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:10:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n1so5680077wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8EeHIO2f2uac1WGfWnHhOthQIjOqpWzUnb/yusYd5Eo=;
        b=fYJZ2xlJH+zGGG5d7j0jNT920bWUhQ/MSKihYcR6D0n+I/J6YBcyVwpkBY6Mut/aL7
         tRvdRoptP8aK6h5v0BBaqlL7/El87mRXZkyCPD8egLw/xjz91ek3hylRn7iS64Pj/JXT
         9ufuuPZc5aKsjzdYfeAi54ITPeAyvrRPs06EHkntrmN90OP6JF44PpHz4TDJaLSf/G1s
         mgV4XBTQPmtIk/RYXM/qfxMmJyhkXuyXcT3rfL+EWvb0VPgdv83/UTSv6F+NcvLkJlh/
         lvwNYKaBFGalg6kfoTALdZ8JfSnDsBfCvSfka/NewJUh6qF3/GGJNo6Alw7c/2Qlybai
         Yp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8EeHIO2f2uac1WGfWnHhOthQIjOqpWzUnb/yusYd5Eo=;
        b=uWhw2ogwp2CYu5Y851LFgemr5JNToMmZrq9yJ3HvUaMlQfwPFLhexls2WlmbZf1us0
         klTyh/Nk0+QwQB2oq+BWWBoT4ow+lQ1fY1yGoL6DATehYC6i6mny+4HopvoiZlGjACti
         rlhEDMLdkkLjyvZO5yS+fUKq/pnmIecTTOvtZIcgHt+iZ8yFGQRElM388a29Yp5wh6up
         O2RIM2+pMgzagx6DWTy0xb4XPbUrMg0QVk3x2/TzhFruS2cOf6IEaWcLr88kvqsq1LGu
         N+Ps7avr0P1BysYCsuszM+qg0errnpUI8AyCQHbdtuuPDo9PfWE3/myA2LiGJG6T2lfG
         40cA==
X-Gm-Message-State: AJIora/lldmahQvFp3wBTQ5BZmj1z2z/PrBvIF+g0Gvy5VHPCt3BtWHM
        B26uztemfnN/licV5p5PsfYFBSKBpWzDPi4r
X-Google-Smtp-Source: AGRyM1tzF8x7/l1zBh6ZS19NjX7FANIe3zlmc83iNe5NxLwfOharnCi3Rxj8l7qi3TipgKZXD6WIAQ==
X-Received: by 2002:a05:6000:242:b0:210:354e:c89a with SMTP id m2-20020a056000024200b00210354ec89amr9715076wrz.136.1655475022140;
        Fri, 17 Jun 2022 07:10:22 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id r66-20020a1c2b45000000b0039c97cc82fbsm9226685wmr.15.2022.06.17.07.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 07:10:21 -0700 (PDT)
Message-ID: <c3286fc9-06ed-d1e1-a731-94cdefdf7fab@gmail.com>
Date:   Fri, 17 Jun 2022 16:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] arm64: dts: mt8183: Add panel rotation
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
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
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAJMQK-jw+sgunEwgEQAw-V8DAbybZ7WVnZJ6vwOdzQ+-SX_bQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi Wang,

On 06/06/2022 17:29, Hsin-Yi Wang wrote:
> On Mon, May 30, 2022 at 7:30 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>
>> krane, kakadu, and kodama boards have a default panel rotation.
>>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
> 
> Hi Matthias,
> 
> The series ("Add a panel API to return panel orientation") might land
> in drm-misc. With this series applied, we can add this patch to give
> the correct default orientation for mt8183 kukui devices.
> I didn't send this patch again with the series, since they might land
> in different trees.
> 

I had a look on Linux next (next-20220617) and wasn't able to find the mtk_dsi.c 
changes. What is the status of this?

Regards,
Matthias

> Thanks.
> 
>>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> index 8d5bf73a9099..f0dd5a06629d 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> @@ -276,6 +276,7 @@ panel: panel@0 {
>>                  avee-supply = <&ppvarp_lcd>;
>>                  pp1800-supply = <&pp1800_lcd>;
>>                  backlight = <&backlight_lcd0>;
>> +               rotation = <270>;
>>                  port {
>>                          panel_in: endpoint {
>>                                  remote-endpoint = <&dsi_out>;
>> --
>> 2.36.1.124.g0e6072fb45-goog
>>
