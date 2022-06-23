Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE67E55778D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiFWKMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiFWKMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:12:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C13649F2F;
        Thu, 23 Jun 2022 03:12:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i206-20020a1c3bd7000000b003a0297a61ddso80510wma.2;
        Thu, 23 Jun 2022 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HflsXu0+hFG41N5XtEidC3FEoB2Xr5DfLY1Kx7PmluI=;
        b=HYsQCnzQUx+N2DoFsRsEg7J04yWNbJC0w/kjpDMBhaZsyHEsMYNd3hWmq5JuyB4dp2
         u6xcEKfI4/1O+U5+YmW/C2lSy6S1rgD6a4kthtIZssMQfzzNRuK9DpIrEaHF9/0O1bao
         ljFWg0BSxFVDdmvW8oMG8706yTBvo6fccZRU5T2bZ3CE/j8faQSPRzqYzz8JfRjbmbJ9
         6xYw3EDY72ylr5aRZ4Q4JzHIsQuK6YVN7X/x6xZgbn8dubbyluo1SZGmT2CSRb3q1hqt
         acnaHiRNAxevFg8pGHtFik2srunPSFW3vGDVdFyaqLUpVjwZkYUjimYs8+vFM7viGDNv
         vw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HflsXu0+hFG41N5XtEidC3FEoB2Xr5DfLY1Kx7PmluI=;
        b=UpcgZ+yfnrgkL+Qc8WAIq7FKGTEFuJgOo4c9UXMyIwthjj8r6/Z4yW8OY6dKLIiCX3
         6UgUwKEJJsXAd9//BIoBq6GnT3eeDJvPST2eMa0hl1+xIGLnjjv/f1ad4sTDUXKxR7IV
         TblJJiGi4RYaOE9eoPCnnrRO7EO77UVGPUrGWxbmUWPL93v80PUp3yAqm5n5tVwSDUzd
         j308qBZZmU4Gdkvs6oIlBS18DXyz7KWFP2/eshrkU/PPPamQmaYBcaJMEAvAm0hcnp8M
         I0kO4b/reKN6znLq+CeZTqhG+FHc4U9yqJtx0HaEa1/dqm5JQFsNTXYvovhD4jQJbmCu
         hm/A==
X-Gm-Message-State: AJIora+VgSutZoykCBeYj+3e4k6kbYL2sx3GngWO+K+avc/DuvjwSEWP
        8/7XMkUAQgR87DHOAmHC9x8=
X-Google-Smtp-Source: AGRyM1vRXeBDUdfUdZK6b6OXImBrsC5h18S1Z46lxpFit9dZRjjbWj8pb58+HtTPSavLubBBe0mpyA==
X-Received: by 2002:a05:600c:1f07:b0:39c:880f:4456 with SMTP id bd7-20020a05600c1f0700b0039c880f4456mr3225936wmb.79.1655979123770;
        Thu, 23 Jun 2022 03:12:03 -0700 (PDT)
Received: from [192.168.1.143] (host-87-242-32-154.prtelecom.hu. [87.242.32.154])
        by smtp.gmail.com with ESMTPSA id x13-20020a7bc20d000000b003a0323463absm1266121wmi.45.2022.06.23.03.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 03:12:03 -0700 (PDT)
Message-ID: <43061e32-3a00-d8a1-5946-656d38ff195c@gmail.com>
Date:   Thu, 23 Jun 2022 12:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] libata: add horkage for M88V29
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>, zboszor@pr.hu,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20220204125750.1771303-1-zboszor@pr.hu>
 <f726e9e1-bdad-ac8a-368b-aae423a00676@opensource.wdc.com>
 <78c29f43-3b67-8e70-0711-14e997f3efb1@gmail.com>
 <09091cc4-f652-0978-bb6a-b63f24fdcf49@opensource.wdc.com>
 <bbfeb862-9e1f-79c2-89dd-7db9515471e4@gmail.com>
 <7f086930-ff6c-da99-212b-46c4479247cb@opensource.wdc.com>
 <c678589c-cb30-35a3-cc7f-ad4065863640@gmail.com>
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <c678589c-cb30-35a3-cc7f-ad4065863640@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022. 06. 23. 11:32 keltezéssel, Böszörményi Zoltán írta:
> 2022. 06. 23. 10:46 keltezéssel, Damien Le Moal írta:
>> On 6/23/22 17:38, Böszörményi Zoltán wrote:
>>> 2022. 06. 23. 10:22 keltezéssel, Damien Le Moal írta:
>>>> On 6/23/22 16:47, Böszörményi Zoltán wrote:
>>>>> 2022. 02. 08. 9:07 keltezéssel, Damien Le Moal írta:
>>>>>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>>>>>> From: Zoltán Böszörményi <zboszor@gmail.com>
>>>>>>>
>>>>>>> This device is a CF card, or possibly an SSD in CF form factor.
>>>>>>> It supports NCQ and high speed DMA.
>>>>>>>
>>>>>>> While it also advertises TRIM support, I/O errors are reported
>>>>>>> when the discard mount option fstrim is used. TRIM also fails
>>>>>>> when disabling NCQ and not just as an NCQ command.
>>>>>>>
>>>>>>> TRIM must be disabled for this device.
>>>>>>>
>>>>>>> Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
>>>>>>> ---
>>>>>>>     drivers/ata/libata-core.c | 1 +
>>>>>>>     1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>>>>> index 67f88027680a..4a7f58fcc411 100644
>>>>>>> --- a/drivers/ata/libata-core.c
>>>>>>> +++ b/drivers/ata/libata-core.c
>>>>>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_device_blacklist 
>>>>>>> [] = {
>>>>>>>             /* devices that don't properly handle TRIM commands */
>>>>>>>         { "SuperSSpeed S238*",        NULL, ATA_HORKAGE_NOTRIM, },
>>>>>>> +    { "M88V29*",            NULL, ATA_HORKAGE_NOTRIM, },
>>>>>>>             /*
>>>>>>>          * As defined, the DRAT (Deterministic Read After Trim) and RZAT
>>>>>> Applied to for-5.17-fixes. Thanks !
>>>>> Thank you. However, I have second thoughts about this patch.
>>>>> The device advertises this:
>>>>>
>>>>> # hdparm -iI /dev/sda
>>>>> ...
>>>>>     Enabled Supported
>>>>>        *    Data Set Management TRIM supported (limit 1 block)
>>>>> ...
>>>>>
>>>>> but the I/O failures always reported higher number of blocks,
>>>>> IIRC the attempted number of block was 8 or so.
>>>>>
>>>>> Can the kernel limit or split TRIM commands according to the
>>>>> advertised limit? If not (or not yet) then the quirk is good for now.
>>>> Yes, the kernel does that. See the sysfs queue attributes
>>>> discard_max_bytes and discard_max_hw_bytes. What are the values for your
>>>> device ? I think that the "limit 1 block" indicated by hdparm is simply to
>>>> say that the DSM command (to trim the device) accept only at most a 1
>>>> block (512 B) list of sectors to trim. That is not the actual trim limit
>>>> for each sector range in that list.
>>> With the quirk in effect (TRIM disabled) I have these:
>>>
>>> [root@chef queue]# pwd
>>> /sys/block/sda/queue
>>> [root@chef queue]# cat discard_granularity
>>> 0
>>> [root@chef queue]# cat discard_max_bytes
>>> 0
>>> [root@chef queue]# cat discard_max_hw_bytes
>>> 0
>> Yes, expected. What are the values without the quirk applied ?
>
> I built 5.18.6 with removing the quirk.
>
> [root@chef queue]# pwd
> /sys/block/sda/queue/
> [root@chef queue]# cat discard_granularity
> 512
> [root@chef queue]# cat discard_max_bytes
> 2147450880
> [root@chef queue]# cat discard_max_hw_bytes
> 2147450880
> [root@chef queue]# cat max_discard_segments
> 1

"echo 512 >discard_max_hw_bytes" says permission denied.
"echo 512 >discard_max_bytes" can be set

But with or without libata.force=noncqtrim, running
"fstrim /boot" (which is ext4) goes into an infinite loop
dumping a lot of I/O errors into dmesg.

Interestingly, after setting discard_max_bytes=512,
in both cases (with or without libata.force=noncqrtim)
running "fstrim /" (which is f2fs) there is no error in
dmesg and fstrim returns after a small delay.

So I guess TRIM does work but ext4 seems to be misbehaving.

FWIW "mount" shows "discard" for the big f2fs partition but
it doesn't for ext4 but it's in the default mount option AFAIK.
"mount /boot -o remount.discard" doesn't make a difference.
the machine dumps a lot of errors into dmesg with "fstrim /boot".

>
>> With 5.19, you can use libata.force to disable/enable it. See
>> Documentation/admin-guide/kernel-parameters.txt for details.
>> You could try disabling DSM TRIM (queued trim) and see if the non-ncq trim
>> work.
>>
>

