Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1657F143
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 22:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiGWUFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWUFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:05:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3EBC39
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:05:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j26so8975891lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3I2kmw70ab8Sogw9ISGUW++Hbm5TK7LsIWm3GHiAUaQ=;
        b=AXKBB5Rj/xYBPPRUJBU9H3C/UuoCoDGV21IjYFI5yEeYC0uIqYjrS6HTpePaDtxBoj
         +yvAS/CtpTMuyECK9BUskJlRvfUVAHWjOJbl7JHTLtc2qZN5NPEQIH+tOaWSMBrqCN8q
         4HgSpTNmPZmRGVGOqfb1+eZw6RP7Fx5QAa2hE4N4gqXEtjTUO6TDCgZZbGFkU0vvjU3s
         VD8UGGxyGOgPZhQglGfKf3uWDnZRaO747LPa5t0260xeFGTPbhLi0pNgQdqP34GIGA0L
         R20pYwytMaJwEBEk4SnB9r+Eka6/ZvpAvQZzpX9+M748n1ogTXBPqKbMkxZHyHM8Tryw
         XTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3I2kmw70ab8Sogw9ISGUW++Hbm5TK7LsIWm3GHiAUaQ=;
        b=mna54v9sjtXvTMY7JJYbi1YYeR5XsMA4ff5FCLfmWa+O3Mh0WcruVld3vHbEE8wvF6
         yk/TSRbp4dH4Wp14Y087zZGystVPOBzcKxt4uAUXfowlqqP4i2v5Mrl5WZyZMzS63WBq
         hssBkexilVsp4gdf50Ds3jySkAATV3OJWraOvuAti5sJYlk4WvjxiWsR+4Dq7PsD1SFA
         jtHvD3UMS5BPNfKYfwfUU6W9gygU5DnweApM7/auX9lHUvfH9x6xL1qoXgIghBOOW9Ck
         CXwLDMEmcQFPoQsb5PdioVmJLC17c4H0Ku/+EOJ99xePhyYz+uR5pqRAd5yYDNpYYFN/
         +wxg==
X-Gm-Message-State: AJIora+9YwFaSXih52IDTPYkrzgpU/mmM+6bO2gptRzKWAYIcSywi3p/
        yZ04IT6CgvDUr3sLjV7yWNQNJA==
X-Google-Smtp-Source: AGRyM1un+YOkOEREyXZGaDp+YVQkM6P1c7QgtXC/+R2hsX+NDmSLbuXrAnacfdA+4OXjgVqXLzWhHA==
X-Received: by 2002:a2e:bd89:0:b0:25a:86c8:93ca with SMTP id o9-20020a2ebd89000000b0025a86c893camr1760237ljq.419.1658606733295;
        Sat, 23 Jul 2022 13:05:33 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id z6-20020a0565120c0600b00489d15132eesm1794041lfu.306.2022.07.23.13.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 13:05:32 -0700 (PDT)
Message-ID: <34bed9a9-a995-c922-c197-062c7170f6f3@linaro.org>
Date:   Sat, 23 Jul 2022 22:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
Content-Language: en-US
To:     Mike Yang <reimu@sudomaker.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
 <487a93c4-3301-aefd-abba-aabf4cb8ec90@linaro.org>
 <37062a5d-9da3-fbaf-89bd-776f32be36d9@wanyeetech.com>
 <d1a0dd15-3621-14e9-b931-417cefaab017@linaro.org>
 <b5505a46-ce76-d0aa-009e-81d9ba16e1d5@sudomaker.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b5505a46-ce76-d0aa-009e-81d9ba16e1d5@sudomaker.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2022 20:47, Mike Yang wrote:
> On 7/24/22 01:43, Krzysztof Kozlowski wrote:
>> On 23/07/2022 18:50, Zhou Yanjie wrote:
>>> Hi Krzysztof,
>>>
>>> On 2022/7/23 上午1:46, Krzysztof Kozlowski wrote:
>>>> On 22/07/2022 18:48, 周琰杰 (Zhou Yanjie) wrote:
>>>>> Add the SFC bindings for the X1000 SoC, the X1600 SoC, the X1830 SoC,
>>>>> and the X2000 SoC from Ingenic.
>>>>>
>>>>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>>>>> ---
>>>>>   .../devicetree/bindings/spi/ingenic,sfc.yaml       | 64 ++++++++++++++++++++++
>>>>>   1 file changed, 64 insertions(+)
>>>>>   create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>>>> new file mode 100644
>>>>> index 00000000..b7c4cf4
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>>>> @@ -0,0 +1,64 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/spi/ingenic,sfc.yaml#
>>>> File name should be rather based on first compatible, so
>>>> ingenic,x1000-sfc.yaml
>>>
>>>
>>> No offense, does it really need to be named that way?
>>> I can't seem to find documentation with instructions on this :(
>>>
>>> The use of "ingenic,sfc.yaml" indicates that this is the documentation
>>> for the SFC module for all Ingenic SoCs, without misleading people into
>>> thinking it's only for a specific model of SoC. And there seem to be many
>>> other yaml documents that use similar names (eg. fsl,spi-fsl-qspi.yaml,
>>> spi-rockchip.yaml, spi-nxp-fspi.yaml, ingenic,spi.yaml, spi-sifive.yaml,
>>> omap-spi.yaml), maybe these yaml files that are not named with first
>>> compatible are also for the same consideration. :)
>>
>> We have many bad examples, many poor patterns and they are never an
>> argument to add one more bad pattern.
> 
> Zhou already mentioned he was unable find the naming guidelines of these .yaml files.
> 
> Apparently you think it's unacceptable for new contributors of a certain subsystem to use existing code as examples, and/or they're responsible for figuring out what's a good example and what's a bad one in the existing codebase.

It's everywhere in the kernel, what can I say? If you copy existing
code, you might copy poor code...

> 
>>
>> It might never grow to new devices (because they might be different), so
>> that is not really an argument.
> 
> It is an argument. A very valid one.
> 
> "they *might* be different". You may want to get your hands on real hardware and try another word. Or at least read the datasheets instead of believing your imagination.
> 
> I would enjoy duplicating the st,stm32-spi.yaml into st,stm32{f,h}{0..7}-spi.yaml if I'm bored at a Sunday afternoon.
> 
>>
>> All bindings are to follow this rule, so I don't understand why you
>> think it is an exception for you?
> 
> Zhou didn't ask you to make an exception. They have a valid point and they're asking why.

Hm, everyone has the same valid point and such recommendation is to
everyone, although it is nothing serious.

> You may want to avoid further incidents of this kind by stop being bossy and actually writing a guideline of naming these .yaml files and publish it somewhere online.

I did not see any incident here... Process of review includes comments
and there is nothing bad happening when you receive a comment. No
incident...

Best regards,
Krzysztof
