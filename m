Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFB559B61C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 21:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiHUTRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 15:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHUTRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 15:17:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8587D1CFCF;
        Sun, 21 Aug 2022 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661109428;
        bh=w9Oco7NMKS//9+T6Z5wgnNMKbJiFLo0nDjeIiWXYe8k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hHw03Hdca7yKDoQdXR0f/0XuDEibfi5dfz7VXMZD0DicamW1UxxedwF5oKBksEd3U
         o8DJXWKsgCM1q6hzoB1Sw7n02kCV32PCSR1WyhJYl5dh/HAtN2uPULVZ1ECtcxXdCK
         xeVaBL1f51m4O0MKdkqU2DIEnvtZscRAwo07WMdU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.21] ([141.30.226.119]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1pKiYB2kHD-00wC8j; Sun, 21
 Aug 2022 21:17:08 +0200
Subject: Re: [PATCH 3/3] hwmon: (dell-smm) Improve warning messages
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220821151713.11198-1-W_Armin@gmx.de>
 <20220821151713.11198-4-W_Armin@gmx.de>
 <20220821154610.e2fokkqzytoqm2ba@pali>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <54f18641-a7a3-65f8-1542-369b6652614c@gmx.de>
Date:   Sun, 21 Aug 2022 21:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220821154610.e2fokkqzytoqm2ba@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:UaOYNGQTQ0ePyD0xqH79UZwT6xU5jPFHN7syj+IphxUtV2vK9go
 PALxfgSV7fWTvOIeQ+N1uEnZDVOnfVxhwNi9HCGrBdcYvTIqFqw6ah6LSHJIN5BVFDH/IEz
 WGMic+ZPZ1PPCffaq+dLri47wNhrYdDAyZzXMeFv8wsDSHXb3GaUOfmB6SGGo5rZ9GMOvrF
 Qd/ipcD2bKvqQ2SzjwiEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fjykjFFon7Y=:k4zwiHnq+hpWfF7QSuo43a
 7311So0vkEjsOzMnQ8kstU9EzK619i2xkhs6mMe1BA9rrnNyOC8vMnmQ+hg6R4lg5YhziJ1Y6
 clrnK2lowcoZgvOg43ZsqGELpjSJNki+u2tqImPDoSZqrHG4Y1kKUCjwI8mPZ4r1Jsl95BnMy
 4y9Y71qQRg990LDDV19qHdtJfMgDFPLQXc+IS77nkCOEkgb/MZuQLhC6GiLIM/NSMy1gXAFfK
 6JyhDgDN89gWWxV7F4kdEe9n6/Gn1MH83hASYrQZ46oiAacLZC2OaAtvorgmEK6KxPLEjLMmF
 9RlftzCjqL133WJo44lJl7m6YcWeQboj8qOEifAA2Z6Nqp/tVLLdZkVEkypny7bV8qQHxzWdN
 8Bxkx2J7oGizjdbP36rx2BxxbEf+6abjp1tFFnefnvWP5YuktmJXagZaYtNeOQ4sOBTKXcSCp
 vTsdXfU8fTd/Ea5d5mvANaUmzjmt/mow0Y/8tIZPju2pOZW7ZAPkLbHqA5tXTQBBsY73BcATp
 xNt3Ai0VAtc/yar+omw7W1XvR8/z5NRMPlK2nt9piPiSVBNaHcApd726XweYFU42O50uaz0PD
 87NjYHmEPsTY0UtCQO4OMELJ56KNaXJA3c9NxG1AuPzRcpuw7QoehECIQY8Vl/E5tu+7YNIeX
 QpsweNvsp1Iojfk3E40xMGCoZy18hXuqilydEbqrgrHCs8nDIO/QYFpDtBfsfidvafuB+gmzP
 PwAG/1jiYm+cArM9ZhXK0L+kPFvtEu+t9PdSmMZYstXgIVV+NGr7L26OMU4BqpSPIIGei3L1H
 Qz1eIZL5XQKbPM6cxRQbKZ+Dvv0m+Wuw8XcwBwQCrRu16VjzDeI9hBCqWw+/w2HA+zHQBrGyC
 V5da/nlb92ZDY7Dr0fZAveAilErtsBsh1nstSdrbnfzN+h0klbB4uCfWL+ZHpIZiEaxGN0L+S
 dW5zQ6iRATtZW11M5uPhQL8cZfjus6JE2L+1v+bE20pDCmsGA75xlWoO4kfdxrd/Itd0vjJ52
 VqST9Z73mzUWI+dwncGJblm5Brs9PXretiFVvkmoe6zQ3+HV8ZsYyGOn4VZijcy+kveVn3Jol
 6XwVITWAzCse5QIs9McWlTKyf0K4CCVVsMua+KH6QWnHQ543+0UHzMrwg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.08.22 um 17:46 schrieb Pali Roh=C3=A1r:

> On Sunday 21 August 2022 17:17:13 Armin Wolf wrote:
>> When dell-smm-hwmon is loaded on a machine with a buggy BIOS
>> with the option "force" being enabled, it wrongly prints
>> what the buggy features where disabled. This may cause
>> users to wrongly assume that the driver still protects them
>> from these BIOS bugs even with "force" being enabled.
>> Change the warning message to avoid such a misunderstanding.
> Should not there be also FW_BUG too?

Since the driver itself is unable to detect if a buggy BIOS was fixed,
i would not use FW_BUG here since it may cause confusion if such a message
was printed on an already fixed BIOS.

> I'm thinking more about message, would not it be better to print also
> information if fan support and fan type call is allowed or disallowed
> (based on force argument) when broken BIOS is detected?

Something like "Disabling fan support due to BIOS bugs" and "Enabling fan =
support despite BIOS bugs"?
The first message could only be a notice message, while the second message=
 could be a warning message.

Armin Wolf

>> Tested on a Dell Inspiron 3505.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/hwmon/dell-smm-hwmon.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hw=
mon.c
>> index f7bab1a91b93..bf13852afe48 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -1354,13 +1354,13 @@ static int __init dell_smm_probe(struct platfor=
m_device *pdev)
>>   	platform_set_drvdata(pdev, data);
>>
>>   	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
>> -		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan suppor=
t\n");
>> +		dev_warn(&pdev->dev, "BIOS has broken fan support\n");
>>   		if (!force)
>>   			data->disallow_fan_support =3D true;
>>   	}
>>
>>   	if (dmi_check_system(i8k_blacklist_fan_type_dmi_table)) {
>> -		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan type c=
all\n");
>> +		dev_warn(&pdev->dev, "BIOS has broken fan type call\n");
>>   		if (!force)
>>   			data->disallow_fan_type_call =3D true;
>>   	}
>> --
>> 2.30.2
>>
