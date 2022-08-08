Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F158C5C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiHHJkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiHHJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:40:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D15010C6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:40:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u6so3849832ljk.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jzQCeQzK/z2ziiZ85EHCo+LQwjQf8yM8fO70yS7S3mY=;
        b=aJ33SGVv3zJ5x6IbLuz/X8sbsCMX05NZMt/w+pQnD/9POpmCMCQzEJPLNyzriq2F/b
         HPzQQ8udkoR6ThjaeWhKAyxlKRe06XVz83s7q2wdaJ9Y3lA8+G93avNeygiLd3EK4sQJ
         AucIBWd/3zX1/ORNIitoV0gnbMlW115lMwc//a/yFNWJVis5tSrtysX6hmZZNJ13vk9e
         IhBJ50USTjo5BXJLgfck9tLWohBAhoDzAICXOok4hd86N3VgX238KHjTeq55yMxgx4nN
         8yIvH9oDVKKx4m5fxxB6HtdJF6g4qzD42puzuFmOUhVn0/aWi0b0b7W8viOXgFoFktBf
         1spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jzQCeQzK/z2ziiZ85EHCo+LQwjQf8yM8fO70yS7S3mY=;
        b=qSFhkIFpZObfiuyftedx55D0dMUkWayk+3TRukJejRDkx1KE0ql0u+xoAvxWIKUtjZ
         7tq8sgpFx35NnyRfe1OWH0PZecBFPxC9zDlMi4rRW/Dny7uSEbmHCMjuNeIJxt1TBiww
         uxxwJPQtNQE7RYPPZRNIuV0hW3UBQTsczK2tmyeLxUBKzho3gU+NS87KJ7vAEq9ZXm6G
         JMZ+8b6Vxx8pK9OxI/Rhq3Fof3i3P2yc/TVyN6RygSAGBb06ePjnGeYJRGm39UFRMYs3
         80DzdZT5yP9xw23qKgTpbzbZCQnearwUHc8ISIHg6iXwFqhLn0DTVsDPE0Wz7AtTxlTN
         6dVA==
X-Gm-Message-State: ACgBeo2bvl7g8NOdiqHVu5Iv6ooE6ycBK98KJB+Cb4nkKMkrbj7l4LwF
        x5xyolqZdxBFlsUpGfoLEIpP07Haft+OSCCz
X-Google-Smtp-Source: AA6agR7WLbgFwVjA/ymihQczoZK2cQ5claVhqrToENvPaPxybFoFLHUGgAFZVtf8HXX0Mrfd6pqrBg==
X-Received: by 2002:a2e:87cc:0:b0:25e:4425:54e2 with SMTP id v12-20020a2e87cc000000b0025e442554e2mr5731584ljj.72.1659951619216;
        Mon, 08 Aug 2022 02:40:19 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id be10-20020a056512250a00b0048af7e58c9dsm1363565lfb.278.2022.08.08.02.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:40:18 -0700 (PDT)
Message-ID: <eb2f574d-0dd8-e2b2-ee2b-d6f60f14bdc9@linaro.org>
Date:   Mon, 8 Aug 2022 12:40:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai.pt@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
 <20220728125435.3336618-3-potin.lai.pt@gmail.com>
 <20220731130959.50826fc4@jic23-huawei>
 <4ea235d1-46c1-87de-760f-dc4775007ae0@gmail.com>
 <CAHp75VcZqTpmvVV=u4t=fdx=ffzksoWVDFZmq6Lfr6DrFrB2aA@mail.gmail.com>
 <Yuf7UAVrIJCnO40X@heinlein.stwcx.org.github.beta.tailscale.net>
 <CAHp75Vfe33oJAf1j27B-pTd84kX5JNPd+e16ygLYgZjCs=ZJfQ@mail.gmail.com>
 <CAHp75VfOPgDbTdt1EXJ5+exGXCZeT9VdtcOUDt_g4fn20S2Qwg@mail.gmail.com>
 <20220806181252.7633f19d@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220806181252.7633f19d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2022 20:12, Jonathan Cameron wrote:
> On Mon, 1 Aug 2022 18:30:16 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Mon, Aug 1, 2022 at 6:26 PM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Mon, Aug 1, 2022 at 6:12 PM Patrick Williams <patrick@stwcx.xyz> wrote:  
>>>> On Mon, Aug 01, 2022 at 10:22:16AM +0200, Andy Shevchenko wrote:  
>>>>> On Mon, Aug 1, 2022 at 3:52 AM Potin Lai <potin.lai.pt@gmail.com> wrote:  
>>>>>> On 7/31/22 20:09, Jonathan Cameron wrote:
>>>>>> In our hardware board, we have "ti,hdc1080" as main source, and "silabs,si7020"
>>>>>> for 2nd source. This two chip are locate at same bus and same slave address,
>>>>>> and we want to use multiple compatibles to support both chips with single device
>>>>>> node in device tree.
>>>>>>
>>>>>> Ex:
>>>>>> compatible = "ti,hdc1099", "silabs,si7020";  
>>>>>
>>>>> This is simply broken DT, you must not put incompatible hardware on
>>>>> the same compatible string. DT is by definition the description of a
>>>>> certain platform. What you showed is a combination of incompatible
>>>>> chips in a single DT.  
>>>>
>>>> We were mistaken that this is the appropriate way to specify this
>>>> behavior, partially because it works as long as the probe functions
>>>> return an error the next matching driver from the compatible will probe.
>>>> It does seem that specifying two different compatibles like this would
>>>> violate the intention of the DT spec:
>>>>
>>>>     The property value consists of a concatenated list of null terminated
>>>>     strings, from most specific to most general. They allow a device to
>>>>     express its compatibility with a family of similar devices, potentially
>>>>     allowing a single device driver to match against several devices.
>>>>  
>>>>>  
>>>>>> In order to support this, I need to add ID checking mechanism into the current
>>>>>> hdc100x driver, so the si7020 chip will fail to probe with hdc100x driver
>>>>>> (because the ID checking is not failed), then success probe with si7020.
>>>>>>
>>>>>> Base on you explanation, it looks multiple compatibles is not suitable in this
>>>>>> case? Would you mind advise us what would be the better approach for our case?  
>>>>>
>>>>> If I may advise... fix your DT by dropping the wrong compatible item.  
>>>>
>>>> This doesn't really give any helpful advice.  
>>>
>>> Sorry to hear this, but it's the best and correct solution to your
>>> problem. Believe me, many Linux people will tell you the same.
>>>  
>>>> The reality is that these two chips are pin compatible and function
>>>> compatible but not driver compatible.

There is no such thing as driver compatible, in the terms of Devicetree.
Implementation does not matter. The compatibles and binding should
reflect the hardware (and its programming model).

>  Boards have been manufactured
>>>> which are identical except for this chip replaced, due various to chip
>>>> shortages.

The question is - whether the programming model (e.g. all I2C registers)
are similar or exactly the same?

>>>>
>>>> Making probe fail so that the next 'compatible' is chosen sounds like it
>>>> isn't desired. 

Yes, it is not desired because any probe failure is indication of test
failures in automated systems, so you do not develop a system which in
normal conditions has a failure.

I don't understand why you cannot include in this driver support for
second device?
Or if second device is so different, why you want to support different
hardware with the same device node. This contradicts the very basic of
Devicetree - description of hardware.

Best regards,
Krzysztof
