Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A34525D52
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378213AbiEMIYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351221AbiEMIY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:24:29 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 936A62A76A2;
        Fri, 13 May 2022 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=1wq4x
        +GCdYKq7VSZUcMOO2GqRgSu1qPIqNZNKgKe78o=; b=aGsvRiKodBfXXrQubvrmS
        eNaI5SHRoxDxCWaYRIFOL0XFsdCTJuktUokDSniA34TYvI8srQh30tyJ9TWbM8jI
        lxOuOLA8XtgwGgdS0M1LYm33GJSaddvaBUQLXrNYbyp9MyMZGTjSwqlVHSNuJWFu
        A5KmFokyy5XONgBDiMi4is=
Received: from [192.168.3.102] (unknown [218.201.129.19])
        by smtp7 (Coremail) with SMTP id C8CowAA3GrB4FX5i05E+CQ--.22485S2;
        Fri, 13 May 2022 16:23:21 +0800 (CST)
Message-ID: <666ead08-af1e-81f5-6fe1-e5e3370e6d6f@163.com>
Date:   Fri, 13 May 2022 16:23:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 2/2] ARM: dts: sun8i-r40: Add "cpu-supply" node for
 sun8i-r40 based board
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220512071858.10805-1-qianfanguijin@163.com>
 <20220512071858.10805-2-qianfanguijin@163.com>
 <20220513073849.cu4jzykefat2sepg@houat>
 <1352b9d7-5219-af09-948b-6462def39ea5@163.com>
 <20220513081556.knd3tf6pangfblh3@houat>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <20220513081556.knd3tf6pangfblh3@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAA3GrB4FX5i05E+CQ--.22485S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF1ktF47Kw4DXw1DCw4kJFb_yoW5GFyDp3
        y7uF4DCF4kGFyrtry2gFWUJrySy34rWr4UXFn8Kw1rJrn8XF9rtrs5K3WFkFZ8Wr4fGw40
        vrWUWrn7Wws8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpWlPUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGh0A7VaEBkJFWgABsi
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/13 16:15, Maxime Ripard 写道:
> On Fri, May 13, 2022 at 03:48:50PM +0800, qianfan wrote:
>>
>> 在 2022/5/13 15:38, Maxime Ripard 写道:
>>> Hi,
>>>
>>> On Thu, May 12, 2022 at 03:18:58PM +0800, qianfanguijin@163.com wrote:
>>>> From: qianfan Zhao <qianfanguijin@163.com>
>>>>
>>>> sun8i-r40 actived cpufreq feature now, let's add "cpu-supply" node on
>>>> board.
>>>>
>>>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>>>> ---
>>>>    arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 4 ++++
>>>>    arch/arm/boot/dts/sun8i-r40-feta40i.dtsi          | 4 ++++
>>>>    arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts          | 4 ++++
>>>>    arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 4 ++++
>>>>    4 files changed, 16 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>>>> index a6a1087a0c9b..4f30018ec4a2 100644
>>>> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>>>> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>>>> @@ -113,6 +113,10 @@ &ahci {
>>>>    	status = "okay";
>>>>    };
>>>> +&cpu0 {
>>>> +	cpu-supply = <&reg_dcdc2>;
>>>> +};
>>>> +
>>> This will break bisection on those boards. Indeed, you added the OPPs on
>>> the first patch, and if you only apply that patch, the boards in the
>>> second patch will be missing their CPU regulator. The kernel will then
>>> ramp up the frequency to the highest OPP, but will not change the
>>> voltage, resulting in a crash.
>> This is a good point and I will merge those two patch.
> That's not what I meant to say. Those two patches are great separated.
> You can invert them though.
haha, invert them, so interesting. good idea.
>
>>> There's a similar issue for all the boards that don't have a regulator
>>> in the first place.
>>>
>>> The way we worked around this for the other SoCs is to have a DTSI with
>>> the OPPs with a frequency higher than what U-Boot boots with (1008MHz?),
>>> and only include that DTSI on boards that have a CPU regulator hooked in.
>> Is this really necessary? It seems like every board based on sun8i-r40
>> have a cpu regulator.
> This probably won't be the case whenever someone starts a new design,
> and then they'll face random crashes for no apparent reason, and waste a
> lot of time in the process.
>
> Whereas the alternative is that you would be missing some OPPs,
> something that is fairly easy to figure out.
How about remove the OPPs which greate that 1.08G in sun8i-r40.dtsi,
If some boards want to run at a higher frequency, can add them byself
in the board's file.
>
> Maxime

