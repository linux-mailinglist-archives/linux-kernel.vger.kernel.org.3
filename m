Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB614FC0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbiDKPba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiDKPb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:31:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C581164E8;
        Mon, 11 Apr 2022 08:29:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 51D3D1F41FB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649690949;
        bh=K+UrxZzlRRf172u4oF81TTba8jEf4wzm+exzEnr8SZw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WJSTsAGKjt0dI/Ht1XH1gscA0EhqfxLEhJL9JD3A6F5q2RlMNxcPaKVnMZPwIVXYz
         rapcrpRHBOAEHBi4KJJWgQxtLkzl04opDyNgc3WxUi5Hn3AZIJeWGT8ySdvxPPczwf
         R5OIYtwcHH4pXdtXdxQgnAkMZm7P5x2P5RtxLl5kt4eMHuZrqd54A64/D9lKmE8hfL
         7Ai3SxpY602oZOntT3/wRD6Lu7be7qjy5lnt10FMuTFjtspJsd/ZpJhlxAYzE+XXjD
         9Ifq9qrPLOqrrmM/eE7YJJv4kjz1TWPDl58mh0uqRUFXShYdbXAKlvwElUISibf3ZG
         JdDVZoXG1qhNg==
Message-ID: <57825f4a-8cfa-ef00-6462-fea37cd4d7be@collabora.com>
Date:   Mon, 11 Apr 2022 18:29:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-4-amhetre@nvidia.com>
 <3e044f9e-3200-bb26-897d-1977e3825c92@gmail.com>
 <81686bc4-c580-862b-1c29-51b34e419154@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <81686bc4-c580-862b-1c29-51b34e419154@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 18:02, Ashish Mhetre wrote:
> 
> 
> On 4/10/2022 7:51 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 06.04.2022 08:24, Ashish Mhetre пишет:
>>>           memory-controller@2c00000 {
>>>               compatible = "nvidia,tegra186-mc";
>>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast
>>> channel */
>>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>>> +            reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1",
>>> "mc2", "mc3";
>>
>> The "mc-" prefix feels redundant to me, I'd name the regs like this:
>>
>>    "sid", "broadcast", "ch0", "ch1", "ch2", "ch3"
>>
>>
>> You should also add validation of the regs/reg-names to the yaml based
>> on SoC version. I.e. it's not enough to only bump the maxItems.
> 
> Okay, I will add validation of reg-names as following:
> 
>   reg-names:
>     minItems: 0
>     maxItems: 6
>     items:
>       - const: sid
>       - const: broadcast
>       - const: ch0
>       - const: ch1
>       - const: ch2
>       - const: ch3
> 
> 
> We will have to keep minItems to 0 in order to make it compatible with
> old DT, right?

Bindings are about the latest DTs. In general older dtbs must be updated
and you must get error from the schema checker for older DTs. It's only
drivers that should care about older dtbs.
