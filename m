Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C199525C84
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377875AbiEMHtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377872AbiEMHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:49:36 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41B51134E1D;
        Fri, 13 May 2022 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=I1PW+
        UgrxtpOrGKAmIK6mKmMXNBZW3K0uImlgxDg5uk=; b=LomQvD4CK/f2fzw6gLHeW
        9p3/uY6i69F9rBDSzSdN0wmUuQC5KcOIG+B8yEJtJnxOblL4sgXEghC7MLiUzA2F
        CaIdcukEgvSzMC0bin2E1nzvRZ2cJFhonh51eyS5wC3KqjjKQ6HVvBxFZraZCjey
        8QXsvnC3KnjlkrCrYxbGso=
Received: from [192.168.3.102] (unknown [218.201.129.19])
        by smtp14 (Coremail) with SMTP id EsCowABnVAViDX5iXlrTCA--.56204S2;
        Fri, 13 May 2022 15:48:50 +0800 (CST)
Message-ID: <1352b9d7-5219-af09-948b-6462def39ea5@163.com>
Date:   Fri, 13 May 2022 15:48:50 +0800
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
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <20220513073849.cu4jzykefat2sepg@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABnVAViDX5iXlrTCA--.56204S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1DZF13AF45KrykXr4Utwb_yoW8Cr4rp3
        yxuF4DCrs7WF1rKry2grWUJry7AFyrWr4jqF15Gw1rJrn8XF9rtrn3KwnakrZ8Xr4fGw40
        vrW8ur97Ww4DZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGQ6XUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbB2AIA7WBHKY57KgAAsm
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/13 15:38, Maxime Ripard 写道:
> Hi,
>
> On Thu, May 12, 2022 at 03:18:58PM +0800, qianfanguijin@163.com wrote:
>> From: qianfan Zhao <qianfanguijin@163.com>
>>
>> sun8i-r40 actived cpufreq feature now, let's add "cpu-supply" node on
>> board.
>>
>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>> ---
>>   arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 4 ++++
>>   arch/arm/boot/dts/sun8i-r40-feta40i.dtsi          | 4 ++++
>>   arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts          | 4 ++++
>>   arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 4 ++++
>>   4 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>> index a6a1087a0c9b..4f30018ec4a2 100644
>> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>> @@ -113,6 +113,10 @@ &ahci {
>>   	status = "okay";
>>   };
>>   
>> +&cpu0 {
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
> This will break bisection on those boards. Indeed, you added the OPPs on
> the first patch, and if you only apply that patch, the boards in the
> second patch will be missing their CPU regulator. The kernel will then
> ramp up the frequency to the highest OPP, but will not change the
> voltage, resulting in a crash.
This is a good point and I will merge those two patch.
>
> There's a similar issue for all the boards that don't have a regulator
> in the first place.
>
> The way we worked around this for the other SoCs is to have a DTSI with
> the OPPs with a frequency higher than what U-Boot boots with (1008MHz?),
> and only include that DTSI on boards that have a CPU regulator hooked in.
Is this really necessary? It seems like every board based on sun8i-r40
have a cpu regulator.
>
> Maxime

