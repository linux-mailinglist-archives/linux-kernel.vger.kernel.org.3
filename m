Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2E150807D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354940AbiDTFXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiDTFXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:23:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C116E340E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:20:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 12so776604pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=JZkx/n/p7b6ySTx2ldt9RivXk5pNmCw4WRsx44qY0Ws=;
        b=Tq4vABg+4hyQP54GofN1qIh6eoKGlrApJrWSp3c3KgoVqCbsc+EgHE+3aTb7V60l7Q
         RU5DVDjnrc55YfCFkrN1YuzJkt3ipeXVnq2GfXeycdHMLS5ae06o8vszL3cg487IbFEa
         ufzH7R2UutbjcXgVFZZuFoo0WMQCDQ7ZcujZZYEGyPVpqtwvah3L2ct71Fz6hKZdN3ZX
         U2j54ZiTjbxCQHg8myxq0s1UC61b28itChxyBqrUWRvQv6aSuoe+t7p3tC7Q87gwedWv
         /YHy7X6ZSLN1/Wnk85F+0PKkNOjUUcAcWReN2bqIRdhbdUgMlY7RBglrKUzPzPFTRJOe
         tkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=JZkx/n/p7b6ySTx2ldt9RivXk5pNmCw4WRsx44qY0Ws=;
        b=kV5AO3X0V3U8RuAO1ohs/x7p++KU5yjTVqUw8dqBoqJavqvNegNXlruVNHCsm9LtC9
         FUK/TeM289xzirp4AWHdr9BpFeXHf1G/+4vIjj+bIyBBr2t4QUhuoDJQvVsN0UoCtbuO
         sWwVNo9QzBGbQ/a5ZQaTe4GbJYaBTUW30hWjm976emdpc4cYQnq1sQyG1GRuv9siMnuH
         Q0y1bgCWgFyKtoLPnZWRfL0FQGx8jrx7YBzeqA8TFMSHN4bpzta434dlfzsLhi56Cjyp
         I+eOStTibhR0G10mjIzcCJFcg86AZB0tdThBA6PXdayVIyft8RnW0s2WR/CzoVLqppb9
         U1PQ==
X-Gm-Message-State: AOAM532IxS8cTKesVTVNcqOzYX7BtVmbHZKFIsqhUtaJLPNA/Z9GGlxI
        Rl2YrPmdKkzZsjvI8GHOkhfHoy+wSYw=
X-Google-Smtp-Source: ABdhPJxfDJjqoSntvyEMjUAZrtP48TBzoup54jMkCX4yPAvO1JZrKy7Lkd+kOaTYzitnmqwBworCWQ==
X-Received: by 2002:a17:902:cece:b0:158:d875:e6d6 with SMTP id d14-20020a170902cece00b00158d875e6d6mr18136030plg.165.1650432026222;
        Tue, 19 Apr 2022 22:20:26 -0700 (PDT)
Received: from [192.168.1.3] (fp76ee264d.knge102.ap.nuro.jp. [118.238.38.77])
        by smtp.gmail.com with ESMTPSA id w20-20020a17090a529400b001d2f1a8e191sm2090941pjh.22.2022.04.19.22.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 22:20:25 -0700 (PDT)
From:   Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Message-ID: <140aa0dd-edd0-f241-672d-d48afe29ef8b@gmail.com>
Date:   Wed, 20 Apr 2022 14:20:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>, Tudor.Ambarus@microchip.com
Cc:     michael@walle.cc, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com,
        Takahiro.Kuwano@infineon.com
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-7-tudor.ambarus@microchip.com>
 <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
 <e21b0d76bf778f78f432ba27a673222d@walle.cc>
 <f318dbd9-d4bf-301a-b5c9-556d04d5bfe6@microchip.com>
 <20220419123245.zu4hypebz77ckygn@ti.com>
 <996f36b1303d191e472f56393aa6398e@walle.cc>
 <89083a31-b862-de50-fdca-d427fb908a08@microchip.com>
 <20220420043425.l77hmc4zm7cwfwdn@ti.com>
In-Reply-To: <20220420043425.l77hmc4zm7cwfwdn@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/2022 1:34 PM, Pratyush Yadav wrote:
> On 19/04/22 12:56PM, Tudor.Ambarus@microchip.com wrote:
>> On 4/19/22 15:46, Michael Walle wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> Am 2022-04-19 14:32, schrieb Pratyush Yadav:
>>>> On 19/04/22 12:08PM, Tudor.Ambarus@microchip.com wrote:
>>>>> On 4/19/22 14:46, Michael Walle wrote:
>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>>>
>>>>>> Am 2022-04-19 13:19, schrieb Michael Walle:
>>>>>>> Am 2022-04-11 11:10, schrieb Tudor Ambarus:
>>>>>>>> There are manufacturers that use registers indexed by address. Some of
>>>>>>>> them support "read/write any register" opcodes. Provide core methods
>>>>>>>> that
>>>>>>>> can be used by all manufacturers. SPI NOR controller ops are
>>>>>>>> intentionally
>>>>>>>> not supported as we intend to move all the SPI NOR controller drivers
>>>>>>>> under the SPI subsystem.
>>>>>>>>
>>>>>>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>>>>>> Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>>>>> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
>>>>>>>
>>>>>>> I still don't like it because the function doesn't do
>>>>>>> anything what the function name might suggest. The read
>>>>>>> just executes an op, the write executes an op with a
>>>>>>> write enable before. All the behavior is determined by the
>>>>>>> 'op' argument.
>>>>>>>
>>>>>>> Anyway,
>>>>>>> Reviewed-by: Michael Walle <michael@walle.cc>
>>>>>>>
>>>>>>>> ---
>>>>>>>> v3: no changes
>>>>>>>>
>>>>>>>>   drivers/mtd/spi-nor/core.c | 41
>>>>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>>>>   drivers/mtd/spi-nor/core.h |  4 ++++
>>>>>>>>   2 files changed, 45 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>>>>>> index 6165dc7bfd17..42794328d3b6 100644
>>>>>>>> --- a/drivers/mtd/spi-nor/core.c
>>>>>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>>>>>> @@ -307,6 +307,47 @@ ssize_t spi_nor_write_data(struct spi_nor *nor,
>>>>>>>> loff_t to, size_t len,
>>>>>>>>       return nor->controller_ops->write(nor, to, len, buf);
>>>>>>>>   }
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * spi_nor_read_reg() - read register to flash memory
>>>>>>>> + * @nor:        pointer to 'struct spi_nor'.
>>>>>>>> + * @op:             SPI memory operation. op->data.buf must be DMA-able.
>>>>>>>> + * @proto:  SPI protocol to use for the register operation.
>>>>>>>> + *
>>>>>>>> + * Return: zero on success, -errno otherwise
>>>>>>>> + */
>>>>>>>> +int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
>>>>>>>> +                 enum spi_nor_protocol proto)
>>>>>>>> +{
>>>>>>>> +    if (!nor->spimem)
>>>>>>>> +            return -EOPNOTSUPP;
>>>>>>>> +
>>>>>>>> +    spi_nor_spimem_setup_op(nor, op, proto);
>>>>>>>> +    return spi_nor_spimem_exec_op(nor, op);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * spi_nor_write_reg() - write register to flash memory
>>>>>>>> + * @nor:        pointer to 'struct spi_nor'
>>>>>>>> + * @op:             SPI memory operation. op->data.buf must be DMA-able.
>>>>>>>> + * @proto:  SPI protocol to use for the register operation.
>>>>>>>> + *
>>>>>>>> + * Return: zero on success, -errno otherwise
>>>>>>>> + */
>>>>>>>> +int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
>>>>>>>> +                  enum spi_nor_protocol proto)
>>>>>>>> +{
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    if (!nor->spimem)
>>>>>>>> +            return -EOPNOTSUPP;
>>>>>>>> +
>>>>>>>> +    ret = spi_nor_write_enable(nor);
>>>>>>>> +    if (ret)
>>>>>>>> +            return ret;
>>>>>>>> +    spi_nor_spimem_setup_op(nor, op, proto);
>>>>>>>> +    return spi_nor_spimem_exec_op(nor, op);
>>>>>>
>>>>>> After seeing your next two patches. Shouldn't the
>>>>>> spi_nor_wait_until_ready() call be here too?
>>>>>>
>>>>>
>>>>> I thought of this too, but seems that for a reason that I don't
>>>>> remember, we don't call for spi_nor_wait_until_ready after we
>>>>> write the octal DTR bit. Pratyush, do you remember why?
>>>>
>>>> We are not sure the protocol changed correctly so we can't rely on
>>>> spi_nor_wait_until_ready(). We read the ID instead to be sure.
>>>
>>> So besides the fact that the write_reg only works with the 'correct'
>>> op parameter, it is also tailored to the special use case. For real
>>> write_reg(), the user would actually has to poll the status bit
>>> afterwards? :(
>>>
>> Don't be sad :D. Are the octal DTR methods an exception?
>> If yes, let's add the call to spi_nor_wait_until_ready() in the
>> read/write_any_reg() methods, and let the octal methods handle
>> the specific write themselves, without calling for ready()
> 
> It has been a while, but IIRC I asked Cypress about this, because I was 
> worried about reading ID while the switch to 8D mode was still in 
> progress. They said that volatile register writes are instant and do not 
> need any status polling. So the switch to 8D-8D-8D mode would be instant 
> and there is no need to wait for anything.
> 
Yes, it is correct.

> The Cypress S28 flash datasheet does not say this explicitly. It does 
It is what we (Infineon) need to solve...

> say that writing to non-volatile registers takes time and you need to 
> wait for ready for those, but makes no mention of volatile registers. We 
> don't ever want to write non-volatile registers so we can ignore that 
> problem.
> 
> I see the Micron MT35 datasheet say this explicitly, that changes to 
> volatile registers are instant.
> 
> So I would say that based on my limited sample size, volatile register 
> writes for Cypress and Micron flashes do _not_ need 
> spi_nor_wait_until_ready().
> 

Thanks,
Takahiro Kuwano
