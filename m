Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4F56B47B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbiGHI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiGHI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:28:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C608362CB;
        Fri,  8 Jul 2022 01:28:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D2A366016BD;
        Fri,  8 Jul 2022 09:28:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657268909;
        bh=eiEwqY/zQ39+iog6TzycknMj2PVHRqGNoVvlat2MSJo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gcPcj3NtQ1QbAMFAEbJKKq7fKiSLQ6b+L9tPXomFZ6tbfvr+KpllZx25q0ZOnlJnu
         YM4a6zLE5VH5OzqmVzyhqkdIWV9YTBdCNUCUr8RWS8/LQyyuzMxvtHrDL325JgXDoc
         cF9BXXtQLGEMCPxW5G+l9Gtk0mNSrn6K0A+jDwoFc3Dpo0lVPgHoyt4f52oxmCJlrd
         h5S3tZutHTqiv/yCfaIUD6RpKCVpM+o0jLWZv4ZqJZ1DgD+XnWI3fyu/Wc+yoLKMr7
         erdBtphYHQx5xzbf7mespvAg+B1zkk0k97gWdLfQ4WjDMQ1ey5EUONUCGuNfbDiP2d
         RXJOEgd1c9AvQ==
Message-ID: <2b25912b-85d7-8804-b973-6239545d19ff@collabora.com>
Date:   Fri, 8 Jul 2022 10:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: add mdp3 mutex support
 for mt8186
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Xiandong Wang <xiandong.wang@mediatek.com>
References: <20220705122627.2273-1-allen-kh.cheng@mediatek.com>
 <20220705122627.2273-2-allen-kh.cheng@mediatek.com>
 <5916c91b-41a1-c97a-84b4-7d48739a0639@collabora.com>
 <640c1a9b-f8b5-aa89-19af-7d6f5c55eb12@gmail.com>
 <243b30ca-a552-3cb7-8a4e-6e54a56ff60a@collabora.com>
 <55fafa62684e077f75c3b8b192a59df62ad01692.camel@mediatek.com>
 <2f2f8bfe-4c7f-d81c-30bf-bcd60b42e245@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2f2f8bfe-4c7f-d81c-30bf-bcd60b42e245@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/07/22 10:19, Matthias Brugger ha scritto:
> 
> 
> On 08/07/2022 10:14, allen-kh.cheng wrote:
>> Hi Angelo,
>>
>> On Thu, 2022-07-07 at 12:59 +0200, AngeloGioacchino Del Regno wrote:
>>> Il 07/07/22 12:41, Matthias Brugger ha scritto:
>>>>
>>>>
>>>> On 07/07/2022 10:52, AngeloGioacchino Del Regno wrote:
>>>>> Il 05/07/22 14:26, Allen-KH Cheng ha scritto:
>>>>>> Add mdp3 mutex compatible for mt8186 SoC.
>>>>>>
>>>>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>>>>> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
>>>>>
>>>>>
>>>>> Please drop this commit. Adding a mdp3-mutex compatible is not
>>>>> needed here.
>>>>>
>>>>
>>>> Thanks for checking. We probably would need a fallback compatible.
>>>> We can only know
>>>> from the HW engineers that can confirm if the IP block is the same
>>>> as the disp
>>>> mutex or a different one.
>>>>
>>>> I'll drop both patches for now until things got clear.
>>>>
>>>
>>> They're located in a different iospace from each other, but either
>>> the platform
>>> data needs to *not be* joined together, or if they're together, I
>>> would not like
>>> having two different compatible strings for essentially the same
>>> thing.
>>>
>>> I would at this point prefer dropping '-disp' from 'mediatek,mt8186-
>>> disp-mutex'
>>> so that we would be able to declare two 'mediatek,mt8186-mutex' in
>>> devicetree...
>>> ...or simply have two mediatek,mt8186-disp-mutex (although logically
>>> incorrect?).
>>>
>>> Cheers,
>>> Angelo
>>>
>>
>> Thanks for your opinion.
>>
>> They are two different hardwares for different address spaces.
>>
>> I think we drop '-disp' from 'mediatek,mt8186-disp-mutex' will be
>> excessive because we also need to modify mutex node in all exited dts
>> files.
>>
>> I prefer havingg two mediatek,mt8186-disp-mutex.
>>
>> ex:
>> mutex: mutex@14001000 {
>>     compatible = "mediatek,mt8186-disp-mutex";
>>     ..
>> }
>>
>> mdp3_mutex0: mutex@1b001000 {
>>     compatible = "mediatek,mt8186-disp-mutex";
>>     ...
>> }
>>
>> What do you think?
> 
> I think that's an acceptable solution.
> 

I'm a bit undecided instead, now... because from what I understand now,
the platform data fields

	.mutex_mod  and  .mutex_sof

are *not valid* for mutex at 0x1b001000 but only for the instance at 0x14001000.

If we go this way, at this point, we would be free (and allowed by the driver)
to try to set these for 0x1b001000, and to try to set MDP3 table paths on
0x14001000, which is something that shouldn't be logically allowed, as the
hardware does *not* support that.

Unless I got that wrong, and these fields for MUTEX_MOD_DISP_xxxx do exist in
the mutex instance at 0xb001000, in which case, I fully agree with Matthias.

But otherwise, I have my doubts.

Cheers,
Angelo

> Regards,
> Matthias
> 
>>
>> Best regards,
>> Allen
>>
>>>> Regards,
>>>> Matthias
>>>>
>>>>>> ---
>>>>>> .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>>>>>>    | 1 +
>>>>>>    1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex
>>>>>> .yaml
>>>>>> b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex
>>>>>> .yaml
>>>>>> index 627dcc3e8b32..234fa5dc07c2 100644
>>>>>> ---
>>>>>> a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex
>>>>>> .yaml
>>>>>> +++
>>>>>> b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex
>>>>>> .yaml
>>>>>> @@ -30,6 +30,7 @@ properties:
>>>>>>          - mediatek,mt8173-disp-mutex
>>>>>>          - mediatek,mt8183-disp-mutex
>>>>>>          - mediatek,mt8186-disp-mutex
>>>>>> +      - mediatek,mt8186-mdp3-mutex
>>>>>>          - mediatek,mt8192-disp-mutex
>>>>>>          - mediatek,mt8195-disp-mutex
>>>>>
>>>>>
>>>>>
>>>
>>>
>>
