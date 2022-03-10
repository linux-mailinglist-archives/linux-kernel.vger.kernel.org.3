Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22D54D40A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiCJFUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:20:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7912D917
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=I5fXJGQkMH35BKw8WxHJoQ7Dvw1gejcJG/9YD2unMMU=; b=MUPOh2t2otoFAM/ZGkst5wdMJi
        JtGQ0pe89Bnk6Cz5vUqRqzpRFmvUsdkKpP/3hmUxKO0jp8YQ3Us4qaCNOTrBY/YYY1AY96rl3r7iJ
        YrnjNi1XE22Xx9tzVgYhvY3He1KRVW7S8xov12cJ6xPGrIWfe9lm3Uvr2e69451NPbj4P5AFeOfoM
        pj3HKXtDo2lnGvPIJukFDfWbwun85NxzjWPlwJRTovYsSAgIgk/aEbAL49rNZqTDb9bLuzM9rpwmR
        lBzAS/Q9bb7r2uhzy3znOaxJuoAr6gB7iPVOdVXhNGZPmRhOqqZLYlk2qaZEjGoYS4jGnj39k0CMw
        nuzXdjhA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSBCt-00H1ZO-Vf; Thu, 10 Mar 2022 05:19:24 +0000
Message-ID: <daa82c42-d677-c007-3295-e3f533a28b87@infradead.org>
Date:   Wed, 9 Mar 2022 21:19:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3] drivers: ddcci: upstream DDCCI driver
Content-Language: en-US
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        gregkh <gregkh@linuxfoundation.org>, javier@javigon.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220310004433.5713-1-yusisamerican@gmail.com>
 <3179f015-58d9-6786-c2c4-6a54088c9221@infradead.org>
 <CAJoG2+9EN9uP0-S+vpfgiRzu_ZXx017vXEZMY7wcuZ+5BZoEYQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJoG2+9EN9uP0-S+vpfgiRzu_ZXx017vXEZMY7wcuZ+5BZoEYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/22 21:01, Yusuf Khan wrote:
> Thanks for the feedback!
> 
> (2) Where would I place that documentation then,
> documentation/devicetree/bindings/?

I like the way that you have all the info in one place, but the
current way Documentation is organized has /sysfs interfaces in
Documentation/ABI/. Then I would put the rest of the doc info in
Documentation/driver-api/ddcci.rst.

> (4) A quick look at bootlin shows a symbol called
> "modalias referenced 176 times.
> 

Well, bootlin is not a kernel driver.
I see places in generic ACPI or generic (other) firmware code
or SPI bus working with modalias strings. Maybe it's OK --
just seems odd to me.

> 
> On Wed, Mar 9, 2022 at 6:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi--
>>
>> On 3/9/22 16:44, Yusuf Khan wrote:
>>> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
>>> index 740811893c57..c7aa439d23e7 100644
>>> --- a/drivers/char/Kconfig
>>> +++ b/drivers/char/Kconfig
>>> @@ -451,4 +451,13 @@ config RANDOM_TRUST_BOOTLOADER
>>>       pool. Otherwise, say N here so it will be regarded as device input that
>>>       only mixes the entropy pool.
>>>
>>> +config DDCCI
>>> +     tristate "DDCCI display protocol support"
>>> +     help
>>> +       Display Data Channel Command Interface is a
>>
>>                                                  is an
>>
>> Also, the line above ends with a space. Please check the entire patch
>> for lines that end with SPACE and remove the trailing spaces.
>>
>>> +       interface that allows the kernel to "talk"
>>> +       to most displays made after 2005. Check your
>>> +       display's specification to see if it has
>>> +       support for this.
>>> +
>>>  endmenu
>>
>> (2) ddcci appears to be a char driver, not a misc driver,
>> so its documentation probably should not be in Documentation/misc-devices/.
>>
>> (3) The documentation file ends with:
>>
>> +options ddcci dyndbg
>> +options ddcci-backlight dyndbg
>> \ No newline at end of file
>>
>> so please add a newline at the end of the last line.
>>
>> (4) What is the modalias stuff about?
>> Does the kernel have other drivers that play modalias games
>> like this?
>>
>>
>> (5) This standalone comment might need some more text.
>> Doesn't make much sense by itself.
>>
>> +       /* Special case: sender to 0x6E is always 0x51 */
>>
>> Does that mean something like "reply to 0x6E is always 0x51" ?
>>
>>
>> (6) Be a bit more generous with spaces around operators (kernel style).
>> And be consistent.  This first line is OK, second line not so much.
>>
>> +       xor ^= ((p_flag << 7) | len);
>> +       *(ptr++) = (p_flag << 7)|len;
>>
>> This line could also be improved with some spaces:
>>
>> +       ret = payload_len+3+((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE)?1:0);
>>
>> (e.g. -- I expect that there are others.)
>>
>>
>> (7) Too much use of likely() and unlikely().
>>
>> (8) I don't see anything in the Kconfig entries such as
>>         depends on I2C
>>
>> so do these 2 drivers work without I2C being enabled in a kernel?
>>
>> Oh, if I build ddcci without CONFIG_I2C:
>>
>> ../drivers/char/ddcci.c: In function ‘__ddcci_write_bytewise’:
>> ../drivers/char/ddcci.c:104:8: error: implicit declaration of function ‘i2c_smbus_write_byte’ [-Werror=implicit-function-declaration]
>>   ret = i2c_smbus_write_byte(client, addr);
>>         ^~~~~~~~~~~~~~~~~~~~
>>   CC      kernel/delayacct.o
>> ../drivers/char/ddcci.c: In function ‘__ddcci_write_block’:
>> ../drivers/char/ddcci.c:165:9: error: implicit declaration of function ‘i2c_master_send’; did you mean ‘i2c_match_id’? [-Werror=implicit-function-declaration]
>>   return i2c_master_send(client, sendbuf, ptr - sendbuf + 1);
>>          ^~~~~~~~~~~~~~~
>>          i2c_match_id
>> ../drivers/char/ddcci.c: In function ‘__ddcci_read’:
>> ../drivers/char/ddcci.c:216:8: error: implicit declaration of function ‘i2c_master_recv’; did you mean ‘i2c_match_id’? [-Werror=implicit-function-declaration]
>>   ret = i2c_master_recv(client, buf, len);
>>         ^~~~~~~~~~~~~~~
>>         i2c_match_id
>> ../drivers/char/ddcci.c: In function ‘ddcci_identify_device’:
>> ../drivers/char/ddcci.c:413:10: error: implicit declaration of function ‘i2c_check_functionality’; did you mean ‘in_lock_functions’? [-Werror=implicit-function-declaration]
>>        && i2c_check_functionality(client->adapter,
>>           ^~~~~~~~~~~~~~~~~~~~~~~
>>           in_lock_functions
>> ../drivers/char/ddcci.c: In function ‘ddcci_module_init’:
>> ../drivers/char/ddcci.c:1835:8: error: implicit declaration of function ‘i2c_add_driver’; did you mean ‘ddcci_add_driver’? [-Werror=implicit-function-declaration]
>>   ret = i2c_add_driver(&ddcci_driver);
>>         ^~~~~~~~~~~~~~
>>         ddcci_add_driver
>> ../drivers/char/ddcci.c: In function ‘ddcci_module_exit’:
>> ../drivers/char/ddcci.c:1868:2: error: implicit declaration of function ‘i2c_del_driver’; did you mean ‘ddcci_del_driver’? [-Werror=implicit-function-declaration]
>>   i2c_del_driver(&ddcci_driver);
>>   ^~~~~~~~~~~~~~
>>   ddcci_del_driver
>>
>>
>>
>> --
>> ~Randy

-- 
~Randy
