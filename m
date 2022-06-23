Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AFF5575B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiFWIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiFWIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:40:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40A46171;
        Thu, 23 Jun 2022 01:40:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u15so11843041ejc.10;
        Thu, 23 Jun 2022 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Gxfs28NCgaT1KK7q9k8b2039RiscWCWCivTIgFrxDBU=;
        b=gxSk4u8ysJxAOXacJuZwJkB7czs3FmWyuVLgoH6HI7RH5vA4ScAG+rSgzqy3OmO+KU
         p01q1KOyD1SaEjkIZssgsr3QqVe/5NGk2Jis2SssiX/U0v/9izrbUwjgd337D2rM37lL
         KNicf4UodEQEmxaRKUcoV+s22UP9/z7RuE2L6jwwJMn3vjpmxiw7ZSPTX9YCwBaVmccs
         wUouTR7FM+e/v76tZSxnB2C0jc6rjKqBltqDQLE7Cn3KR+To2ilooaNdT8dNabQlKliJ
         9IXFTbYfAcTzKRswjgw+CSi3XIgk1/VqmAvwwUTsK30QOXZut5uO1wo/m2Jy0qLQ32FJ
         +K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gxfs28NCgaT1KK7q9k8b2039RiscWCWCivTIgFrxDBU=;
        b=s+Z6MH3ts7g8adfesWM6aSZXm8//s6oajPvDciS/GO2lUtTRotR7awlM5i3BTyMdO4
         BSw43F/FcyGxnl+xsEdL4It1DP6vbHMBfWmZ938m2uFIxSEU1sbgyHDrpPaYqoLBslAC
         izHGBV6V4Me0/Y2hP5puILeJZd4Ne/LPtuz4DEk1OGiFPcRij7dTRnHNAuUVc2SSB3oS
         PpOq0fK0W89W46+HlcKXh1i9KjxkISEFmv/olinzCCLnPTxQbJlpv7zNssgG4Y3Aej/Q
         Ay7HDcgyFe2NI5e6o4m/y7JmPRwb7NrkhaHjaZCqeYpdmqxK+wsYqpApcuJSU/YVjgIz
         sDfw==
X-Gm-Message-State: AJIora88Ckzp9Eip4aHC/IBNmuSnStBHfzj681r31rFx/SBJbXnZxSNl
        v8X961z7IIxcr0DDPwRqwGE=
X-Google-Smtp-Source: AGRyM1tDbJPC0thCEd0Mm2R7mqhy16EEbGVrGjVD/VqQdJFu4VirGqvM30RF4GV1gecpSuYPryYCyA==
X-Received: by 2002:a17:907:2ce3:b0:722:e1b0:68b7 with SMTP id hz3-20020a1709072ce300b00722e1b068b7mr6968740ejc.14.1655973642047;
        Thu, 23 Jun 2022 01:40:42 -0700 (PDT)
Received: from [192.168.1.143] (host-87-242-32-154.prtelecom.hu. [87.242.32.154])
        by smtp.gmail.com with ESMTPSA id d21-20020a056402517500b00435640c141esm14007129ede.93.2022.06.23.01.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 01:40:41 -0700 (PDT)
Message-ID: <20080287-29d1-3f91-9406-29c56ac945cb@gmail.com>
Date:   Thu, 23 Jun 2022 10:40:40 +0200
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
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <bbfeb862-9e1f-79c2-89dd-7db9515471e4@gmail.com>
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

2022. 06. 23. 10:38 keltezéssel, Böszörményi Zoltán írta:
> 2022. 06. 23. 10:22 keltezéssel, Damien Le Moal írta:
>> On 6/23/22 16:47, Böszörményi Zoltán wrote:
>>> 2022. 02. 08. 9:07 keltezéssel, Damien Le Moal írta:
>>>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>>>> From: Zoltán Böszörményi <zboszor@gmail.com>
>>>>>
>>>>> This device is a CF card, or possibly an SSD in CF form factor.
>>>>> It supports NCQ and high speed DMA.
>>>>>
>>>>> While it also advertises TRIM support, I/O errors are reported
>>>>> when the discard mount option fstrim is used. TRIM also fails
>>>>> when disabling NCQ and not just as an NCQ command.
>>>>>
>>>>> TRIM must be disabled for this device.
>>>>>
>>>>> Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
>>>>> ---
>>>>>    drivers/ata/libata-core.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>>> index 67f88027680a..4a7f58fcc411 100644
>>>>> --- a/drivers/ata/libata-core.c
>>>>> +++ b/drivers/ata/libata-core.c
>>>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_device_blacklist 
>>>>> [] = {
>>>>>           /* devices that don't properly handle TRIM commands */
>>>>>        { "SuperSSpeed S238*",        NULL, ATA_HORKAGE_NOTRIM, },
>>>>> +    { "M88V29*",            NULL,    ATA_HORKAGE_NOTRIM, },
>>>>>           /*
>>>>>         * As defined, the DRAT (Deterministic Read After Trim) and RZAT
>>>> Applied to for-5.17-fixes. Thanks !
>>> Thank you. However, I have second thoughts about this patch.
>>> The device advertises this:
>>>
>>> # hdparm -iI /dev/sda
>>> ...
>>>    Enabled Supported
>>>       *    Data Set Management TRIM supported (limit 1 block)
>>> ...
>>>
>>> but the I/O failures always reported higher number of blocks,
>>> IIRC the attempted number of block was 8 or so.
>>>
>>> Can the kernel limit or split TRIM commands according to the
>>> advertised limit? If not (or not yet) then the quirk is good for now.
>> Yes, the kernel does that. See the sysfs queue attributes
>> discard_max_bytes and discard_max_hw_bytes. What are the values for your
>> device ? I think that the "limit 1 block" indicated by hdparm is simply to
>> say that the DSM command (to trim the device) accept only at most a 1
>> block (512 B) list of sectors to trim. That is not the actual trim limit
>> for each sector range in that list.
>
> With the quirk in effect (TRIM disabled) I have these:
>
> [root@chef queue]# pwd
> /sys/block/sda/queue
> [root@chef queue]# cat discard_granularity
> 0
> [root@chef queue]# cat discard_max_bytes
> 0
> [root@chef queue]# cat discard_max_hw_bytes
> 0

And also this, which seems to match the sector limit:

[root@chef queue]# cat max_discard_segments
1

>
>>
>>> Best regards,
>>> Zoltán Böszörményi
>>>
>>
>

