Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F24B841E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiBPJZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:25:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiBPJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:25:05 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B387C2409E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:24:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i14so2351249wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V+Dapxg0zXsnnEigvZU2ISzguu1Pd88G1037+TPTAbA=;
        b=mlV5YhZKni19khJnRvdvs88UGrr7RgQN6+l7ejDoM76aHyySgrj94BCh8rR19WeXPE
         5vBA9d12mDgKl2D9sXgbSUF9BmJ5r2YDpTlrHx52EvhYlsP1SQBnGS5M3wyWWXwAJrRg
         Lg9k0V/19BX+gMbDAP8jS5cwjH1OfK0p5QAYOcLVCAhrjKrLNXRfFPz0dbrZJR5tSVz+
         JaVKxt2diIRDQodkr2l1/AFiNTKa8qm8FIw9jNa5e6MoAZ7PR1F1/QEc/P0Xx8uUHcQ8
         0HzHc+z5SkQ6YfoQFetHX1b86hxJirvzMpG3K9ZY/kKmCtYOQY5YgZTiNuXcLW2BMrCu
         5clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V+Dapxg0zXsnnEigvZU2ISzguu1Pd88G1037+TPTAbA=;
        b=alpSERi68iYeYga9qOI2vCP1syrUX3EwSN+UHzGvBdHpuBbQ+PrkizTWGxrYzcXQiP
         zfyty59j8GZZEzldRy4XTFSAPrJQ1yM7Y3e25en7T9vN8t+PCnjr2AUvQhbxP/Pg0bOi
         so2EFhR6rlznvmeh+QbC1M4JwSjk4ijFhGejPxJmBf7wyIWTVJGVf5z524QIPI9UlfoD
         4Kw+GCdNiZt57hvCr/discRbkW3Op0kRkP9UrsFJ1RY5j0oYWciOz8mJZmEvrTBddRXp
         sLMu4edl0GtRfmadU2maWQH4T/9kjXx3e3wZpJAu85EZFvjJ0O7TTPQxFrjjnKATu5UP
         tqhQ==
X-Gm-Message-State: AOAM532gFsCi5upEuecO6qXDW2Y2rbb7tGdaiEnNn0L44zFrZMZngyYc
        vEk+c+O6LOezkC9PX5FHoDGfCg==
X-Google-Smtp-Source: ABdhPJybB8+4N/87FZcXi+gpJe9ffIOdlO3j5vjlHAoq7uc1KvxqRzDFyZNTBT7eHPbfeFYtJoCFnQ==
X-Received: by 2002:a5d:4b52:0:b0:1e4:ab83:9b8b with SMTP id w18-20020a5d4b52000000b001e4ab839b8bmr1625238wrs.38.1645003472009;
        Wed, 16 Feb 2022 01:24:32 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id o13sm17681070wmq.45.2022.02.16.01.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 01:24:31 -0800 (PST)
Message-ID: <d1000482-5385-c6f1-d10e-e5396218e0ea@linaro.org>
Date:   Wed, 16 Feb 2022 09:24:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] mtd: core: Fix a conflict between MTD and NVMEM on
 wp-gpios property
Content-Language: en-US
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, chenshumin86@sina.com,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Khouloud Touil <ktouil@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
 <20220131095755.8981-5-christophe.kerello@foss.st.com>
 <20220131144309.0ffe7cc8@xps13> <20220201104727.7xvcyexf3yucegcb@ti.com>
 <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
 <20220202115327.53oqg5n7tx6b6q7u@ti.com>
 <f6687807-607c-f672-2394-ad463735d597@foss.st.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <f6687807-607c-f672-2394-ad463735d597@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/02/2022 08:46, Christophe Kerello wrote:
> Hi Miquel, Pratyush, Srinivas,
> 
> On 2/2/22 12:53, Pratyush Yadav wrote:
>> + Khouloud, Linus, Bartosz
>>
>> On 02/02/22 11:44AM, Christophe Kerello wrote:
>>> Hi,
>>>
>>> On 2/1/22 11:47, Pratyush Yadav wrote:
>>>> On 31/01/22 02:43PM, Miquel Raynal wrote:
>>>>> Hi Vignesh, Tudory, Pratyush,
>>>>>
>>>>> + Tudor and Pratyush
>>>>>
>>>>> christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55 
>>>>> +0100:
>>>>>
>>>>>> Wp-gpios property can be used on NVMEM nodes and the same property 
>>>>>> can
>>>>>> be also used on MTD NAND nodes. In case of the wp-gpios property is
>>>>>> defined at NAND level node, the GPIO management is done at NAND 
>>>>>> driver
>>>>>> level. Write protect is disabled when the driver is probed or resumed
>>>>>> and is enabled when the driver is released or suspended.
>>>>>>
>>>>>> When no partitions are defined in the NAND DT node, then the NAND 
>>>>>> DT node
>>>>>> will be passed to NVMEM framework. If wp-gpios property is defined in
>>>>>> this node, the GPIO resource is taken twice and the NAND controller
>>>>>> driver fails to probe.
>>>>>>
>>>>>> A new Boolean flag named skip_wp_gpio has been added in nvmem_config.
>>>>>> In case skip_wp_gpio is set, it means that the GPIO is handled by the
>>>>>> provider. Lets set this flag in MTD layer to avoid the conflict on
>>>>>> wp_gpios property.
>>>>>>
>>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>>>>>> ---
>>>>>>    drivers/mtd/mtdcore.c | 2 ++
>>>>>>    1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>>>>>> index 70f492dce158..e6d251594def 100644
>>>>>> --- a/drivers/mtd/mtdcore.c
>>>>>> +++ b/drivers/mtd/mtdcore.c
>>>>>> @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>>>>>>        config.stride = 1;
>>>>>>        config.read_only = true;
>>>>>>        config.root_only = true;
>>>>>> +    config.skip_wp_gpio = true;
>>>>>>        config.no_of_node = !of_device_is_compatible(node, 
>>>>>> "nvmem-cells");
>>>>>>        config.priv = mtd;
>>>>>> @@ -833,6 +834,7 @@ static struct nvmem_device 
>>>>>> *mtd_otp_nvmem_register(struct mtd_info *mtd,
>>>>>>        config.owner = THIS_MODULE;
>>>>>>        config.type = NVMEM_TYPE_OTP;
>>>>>>        config.root_only = true;
>>>>>> +    config.skip_wp_gpio = true;
>>>>>>        config.reg_read = reg_read;
>>>>>>        config.size = size;
>>>>>>        config.of_node = np;
>>>>>
>>>>> TLDR: There is a conflict between MTD and NVMEM, who should handle the
>>>>> WP pin when there is one? At least for raw NAND devices, I don't want
>>>>> the NVMEM core to handle the wp pin. So we've introduced this
>>>>> skip_wp_gpio nvmem config option. But there are two places where this
>>>>> boolean can be set and one of these is for otp regions (see above). In
>>>>> this case, I don't know if it is safe or if CFI/SPI-NOR rely on the
>>>>> nvmem protection. Please tell us if you think this is fine for you.
>>>>
>>>> Why does NVMEM touch hardware write protection in the first place? The
>>>> purpose of the framework is to provide a way to retrieve config stored
>>>> in memory. It has no business dealing with details of the chip like the
>>>> WP line. That should be MTD's job (which it should delegate to SPI NOR,
>>>> SPI NAND, etc.). If you want to write protect a cell then do it in
>>>> software. I don't see why NVMEM should be dealing with hardware 
>>>> directly
>>>> at all.
>>>>
>>>> That is my mental model of how things _should_ work. I have not spent
>>>> much time digging into how things actually work currently.
>>>>
>>>
>>> Wp-gpios property management was added in MVMEM framework in January 
>>> 2020 =>
>>> sha1: 2a127da461a9d8d97782d6e82b227041393eb4d2
>>> "
>>>      nvmem: add support for the write-protect pin
>>>
>>>      The write-protect pin handling looks like a standard property that
>>>      could benefit other users if available in the core nvmem framework.
>>>
>>>      Instead of modifying all the memory drivers to check this pin, make
>>>      the NVMEM subsystem check if the write-protect GPIO being passed
>>>      through the nvmem_config or defined in the device tree and pull it
>>>      low whenever writing to the memory.
>>> "
>>>
>>> And this modification was done for EEPROMs flashes => sha1:
>>> 1c89074bf85068d1b86f2e0f0c2110fdd9b83c9f
>>> "
>>>      eeprom: at24: remove the write-protect pin support
>>>
>>>      NVMEM framework is an interface for the at24 EEPROMs as well as for
>>>      other drivers, instead of passing the wp-gpios over the different
>>>      drivers each time, it would be better to pass it over the NVMEM
>>>      subsystem once and for all.
>>>
>>>      Removing the support for the write-protect pin after adding it to
>>>      the NVMEM subsystem.
>>> "
>>>
>>> Current NVMEM framework implementation toggles the WP GPIO when 
>>> reg_write
>>> nvmem_config API is defined. In case of MTD framework, reg_write is not
>>> defined in nvmem_config.
>>
>> Thanks for digging these up. I think this was the wrong decision to
>> make. NVMEM should just provide the APIs for handling read/write, and
>> leave the rest to the drivers.
>>
>> It might be convenient for some drivers to put the WP GPIO handling to
>> NVMEM core but I just don't think it is the job of the framework to deal
>> with this, and it just does not know enough about the device to deal
>> with correctly and completely anyway. For example, wp-gpio is only one
>> of the ways to write protect a chip. SPI NOR flashes have a WP# pin that
>> is often toggled via the SPI controller. There could also be registers
>> that do the write protection.
>>
>> One would have to make strong justifications for making nvmem directly
>> deal with hardware level details to convince me it is a good idea. IMHO
>> if AT24 EEPROM is the only driver relying on this as of now then we
>> should just revert the patches and not have to deal with the
>> skip_wp_gpio hackery.
>>
> 
> Based on the  bindings documentation, AT24 EEPROM driver is not the only
> driver relying on this implementation. At least, AT25 EEPROM driver will
> have to be modified to handle the Write Protect management, and there is
> probably others drivers relying on this implementation.
> 
> So, should we keep the legacy and apply the proposal patch to fix this
> conflict (I can send a V3 with a fixes tag on patch 3 and 4 as
> recommended by Miquel)?
> Or should we revert the Write Protect management in NVMEM framework
> but in this case I will not be able to handle such modifications (I am
> not able to test those drivers).

Firstly sorry for such a long delay to reply this thread as I was in travel.

I agree with comments from Pratyush but I see no harm in handling simple 
usecases of write-protect gpio in nvmem core. In fact wp-gpios and 
read-only are part of nvmem provider bindings.

But usecases like the ones described in this patch series which do not 
want nvmem core to deal with this pin should set this new flag. I think 
this is a balanced choice.

reverting the wp-gpio patch is going to break other providers that are 
using this bindings.

--srini


> 
> Regards,
> Christophe Kerello.
> 
>>>
>>> Based on the comments made, it seems that we also agree that this write
>>> protection should be handled by MTD subsystems or associated drivers 
>>> and not
>>> by MVMEN framework for MTD use cases.
>>>
>>> The proposal implementation should solve this conflict for MTD framework
>>> without breaking anything for others NVMEM users (EEPROMs flashes for
>>> example).
>>
