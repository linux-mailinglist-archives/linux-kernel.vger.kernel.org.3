Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5EC5575A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiFWIi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiFWIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:38:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A847AE9;
        Thu, 23 Jun 2022 01:38:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ge10so7980860ejb.7;
        Thu, 23 Jun 2022 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6E3ehNpx0NWWY9gd1tkugcXbrRZPU1QXCYb+zk96VGk=;
        b=hqJegAdcgPWiQc1gcxrCOewndbYP3nCj80JqoSzgBrO6sVU2DCjemsKhdnCSP/xOhp
         Z+srnEWnD8kyS9w/BFn+cAldMzgM1ls1XAS+zGBNQpmMxor6LQqwkW3am8CpLnJ1ZGPN
         ks0ukTColUEfyVT2tctWz9woDm4KJnFur7xudnuEdYu1+XOhlITIh/JJuhJbF8gxGCn2
         vWKVz2mfZQjDgt16otsrgZyLjVuDLelf6mh4EcHpAbuzQOGW5ceF/8aA6wVgBNJTBWsq
         wItJ+arxEtTYNHagXhpcedPzOeYU/CLwXsfzFz+ML+1lToaL7xRL4miE8z08M6h1q+Ou
         PdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6E3ehNpx0NWWY9gd1tkugcXbrRZPU1QXCYb+zk96VGk=;
        b=cXDx4BG4Gr4UeYDIa20ZPSfglMIhnaejaExqJ7enxJJfJEMJ1IYc5TwzERz5c31NW6
         TYz12AsWF3MlVX6nwPEwhZaUAo7Hh8pXRs61Pdav4AFyYdqaxhO9dF2gEr63y0s02KL+
         ko+9Dq8mGSCVE1qkSIkgw+Stm04lWon1uYmy4RMD1oZuYjLJtV9Y+83aYXeMSs03/YVW
         N9G7Dwo3Wb0XnTUpBzQup7ymG51q8a36LiCPKgsBELBPp2RUOMOsqBzbIXa/OHVO4CLN
         KY3Dk1Bus862L6N2TEdL+h6TA9XnuGx3nx0AF0Bq3xMxGI3safKuQ4datjTj40fbxqRS
         zVrg==
X-Gm-Message-State: AJIora+Kb8YeMrZLddMr5dPeDzPXyNFSnEnYoviQTTViWZ19HFTBeRKB
        R+QSkXjeofghwn/HatqUdb+XidIEE2Lrxg==
X-Google-Smtp-Source: AGRyM1tBD0P68nYrcwY7c/YtBqER4UedO2oXGltQDikSTMrirIdUbgFPx05DumzVDOcUMmRo7GwjMA==
X-Received: by 2002:a17:906:b1cb:b0:716:89ce:a708 with SMTP id bv11-20020a170906b1cb00b0071689cea708mr7021112ejb.667.1655973533304;
        Thu, 23 Jun 2022 01:38:53 -0700 (PDT)
Received: from [192.168.1.143] (host-87-242-32-154.prtelecom.hu. [87.242.32.154])
        by smtp.gmail.com with ESMTPSA id c5-20020a056402158500b004356b8ad003sm12624766edv.60.2022.06.23.01.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 01:38:52 -0700 (PDT)
Message-ID: <bbfeb862-9e1f-79c2-89dd-7db9515471e4@gmail.com>
Date:   Thu, 23 Jun 2022 10:38:51 +0200
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
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <09091cc4-f652-0978-bb6a-b63f24fdcf49@opensource.wdc.com>
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

2022. 06. 23. 10:22 keltezéssel, Damien Le Moal írta:
> On 6/23/22 16:47, Böszörményi Zoltán wrote:
>> 2022. 02. 08. 9:07 keltezéssel, Damien Le Moal írta:
>>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>>> From: Zoltán Böszörményi <zboszor@gmail.com>
>>>>
>>>> This device is a CF card, or possibly an SSD in CF form factor.
>>>> It supports NCQ and high speed DMA.
>>>>
>>>> While it also advertises TRIM support, I/O errors are reported
>>>> when the discard mount option fstrim is used. TRIM also fails
>>>> when disabling NCQ and not just as an NCQ command.
>>>>
>>>> TRIM must be disabled for this device.
>>>>
>>>> Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
>>>> ---
>>>>    drivers/ata/libata-core.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>> index 67f88027680a..4a7f58fcc411 100644
>>>> --- a/drivers/ata/libata-core.c
>>>> +++ b/drivers/ata/libata-core.c
>>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>>>    
>>>>    	/* devices that don't properly handle TRIM commands */
>>>>    	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
>>>> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
>>>>    
>>>>    	/*
>>>>    	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
>>> Applied to for-5.17-fixes. Thanks !
>> Thank you. However, I have second thoughts about this patch.
>> The device advertises this:
>>
>> # hdparm -iI /dev/sda
>> ...
>>    Enabled Supported
>>       *    Data Set Management TRIM supported (limit 1 block)
>> ...
>>
>> but the I/O failures always reported higher number of blocks,
>> IIRC the attempted number of block was 8 or so.
>>
>> Can the kernel limit or split TRIM commands according to the
>> advertised limit? If not (or not yet) then the quirk is good for now.
> Yes, the kernel does that. See the sysfs queue attributes
> discard_max_bytes and discard_max_hw_bytes. What are the values for your
> device ? I think that the "limit 1 block" indicated by hdparm is simply to
> say that the DSM command (to trim the device) accept only at most a 1
> block (512 B) list of sectors to trim. That is not the actual trim limit
> for each sector range in that list.

With the quirk in effect (TRIM disabled) I have these:

[root@chef queue]# pwd
/sys/block/sda/queue
[root@chef queue]# cat discard_granularity
0
[root@chef queue]# cat discard_max_bytes
0
[root@chef queue]# cat discard_max_hw_bytes
0

>
>> Best regards,
>> Zoltán Böszörményi
>>
>

