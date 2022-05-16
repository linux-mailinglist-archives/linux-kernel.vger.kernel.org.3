Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6863752806B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbiEPJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiEPJJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:09:03 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48A2C22B27;
        Mon, 16 May 2022 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=SJzeR
        opa97b+y4ikvwq8pQd3JkFOAJvJtPN1447zVMU=; b=OYFMch/JvS5zRHMSkFQy2
        6+npR9/hT5fhljyMlbai5peBOLYvad8xghCvHdv6UTqdplMHc6ZNiZm7w79DG5yq
        5Ela9Pwau9h4KnGD2tgptGrmXJq0K15Un486eThtgQ+3fZw1LxwcLth6EK4dxIM1
        9eRidqHRafP+X9Spj9aF8I=
Received: from [192.168.3.102] (unknown [218.201.129.19])
        by smtp7 (Coremail) with SMTP id C8CowAB3CplRFIJiwNRICw--.41526S2;
        Mon, 16 May 2022 17:07:30 +0800 (CST)
Message-ID: <145f9b94-1eb1-8a66-9f9b-36a8395bde70@163.com>
Date:   Mon, 16 May 2022 17:07:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 2/2] ARM: dts: sun8i-r40: add opp table for cpu
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220516021516.23216-1-qianfanguijin@163.com>
 <20220516021516.23216-3-qianfanguijin@163.com>
 <20220516085309.jp5yautmb3veocvl@houat>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <20220516085309.jp5yautmb3veocvl@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAB3CplRFIJiwNRICw--.41526S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWDuFWxKr4rKw1ftry5Jwb_yoW8tr1Upr
        ZrCr4Ykr4kWr17JrySgw1UJFn3uFWkuFyUGry7GFy8Jwn8Zr1DGFn7trnxKrW8Xr4fZ3y2
        9rnaqr9Fkw1DC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjtC7UUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXBID7VXl25gMPQAAsi
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/16 16:53, Maxime Ripard 写道:
> On Mon, May 16, 2022 at 10:15:16AM +0800, qianfanguijin@163.com wrote:
>> From: qianfan Zhao <qianfanguijin@163.com>
>>
>> OPP table value is get from allwinner lichee linux-3.10 kernel driver
>>
>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>> ---
>>   arch/arm/boot/dts/sun8i-r40.dtsi | 42 ++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
>> index 291f4784e86c..8949153eb0eb 100644
>> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
>> @@ -54,6 +54,36 @@ / {
>>   	#size-cells = <1>;
>>   	interrupt-parent = <&gic>;
>>   
>> +	cpu0_opp_table: opp_table0 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-720000000 {
>> +			opp-hz = /bits/ 64 <720000000>;
>> +			opp-microvolt = <1000000 1000000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-912000000 {
>> +			opp-hz = /bits/ 64 <912000000>;
>> +			opp-microvolt = <1100000 1100000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <1160000 1160000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		/* The opp table of the cpu frequency that exceeds 1G
>> +		 * is not defined here. They require higher operating
>> +		 * current, which may exceed the 500mA limited if the
>> +		 * system is powered by USB. You can add them to the
>> +		 * board's DTS is you make sure.
>> +		 */
> That's not the issue though. The issue is that the board is setup with a
> CPU voltage at 1160mV, and if we raise the frequency to a higher OPP
> without raising the voltage as well, the CPU will crash.
Yes, this is a issue and if the dts doesn't has "cpu-supply" node.
The comment above is found while testing. 100% cpu load @ 4x1.2G
will consume about 800mA@5V current, the board will reboot if it
is powered by USB. So I leave those comments.

I am thinking your suggestion to write the opp part to a dtsi like
A64. Should I adding all supported freq?

I am preparing a new version which including cpu cooling.
>
> Maxime

