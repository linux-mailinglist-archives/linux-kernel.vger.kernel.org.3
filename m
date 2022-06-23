Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA7557467
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiFWHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiFWHr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:47:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975FFBE7;
        Thu, 23 Jun 2022 00:47:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e40so14735919eda.2;
        Thu, 23 Jun 2022 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=vKeUYrOnHA0zZN0XQTl1zor+a3N2Xv1aslSC072Uq1I=;
        b=TXII47El0341dJhe7FFZgxqniHkSYpisMc6jisLwbHLuV4qMgCpcPQgLC8plLDp6mq
         WarKgq2HVtGHSELQ+GaC2dVL61FsxYlsaUrE3C7dHJrPw+QDh7XB4nENCPBwYKvDJqJI
         HQUjQheD3yEFcGDAAO4vca2g9fj1pmm5rHOiM0Ve+fyPit9hJkWg9oBJThLF3dhOODVm
         qT8QM+h08F5sDI0P71sU1NIhMMUO+oMLr3zjF0TPt8UDzFaE5OFTJh8+FPlRAtxWl87z
         tN71b+f1toYcsO95YQpRnaoqpzxgrw6dwC/8/hvnM2IBzG0XM9AnzMNN7dr+RVOKpMBI
         BGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vKeUYrOnHA0zZN0XQTl1zor+a3N2Xv1aslSC072Uq1I=;
        b=0aUvMwqoibPngYjRK+sVy2x/7F0TrdZO8pybsTBI3wNRJjzOy9fuVSR4U5MGfW88xA
         D6y2doNqWCzPNO+/o1qCLrfzlNdFt1y6V93tqciy7RZzb3nkTSAOWtQufVLCSFD4EKqq
         24q8YpvxRvt+G/SDnCZvE3QfAUvHPRp/LQSkY70uKOF1seg3X/dPTHos0XjJ/35lCVoQ
         saDtTKVwUq2juhLGxSPVRIDtftk2M9TXvI8BFtObgzda2cryhzpqpe1mzobaSWlsAW+5
         nMdZB1C6FyJSujBHFv3wWiVjvr/TeNxfp+yM11iuMnpos6tFgR82M29kjk0KzmYzkjwo
         wnNg==
X-Gm-Message-State: AJIora/feX8bQXk+4TPXS133Gu6ImPxduvxmf4jpK24Cay87OAIxOgwi
        UBL24Ph1td1Gq399gPcBGcvbY2LdeO6Nnw==
X-Google-Smtp-Source: AGRyM1v2kX0rI7PLKbmVWNz24SS4DsLoF7TT5ENboEO1fViJlxqGaVofGP38x2kD6f8+eLzWg0vO9A==
X-Received: by 2002:a05:6402:1a4d:b0:435:74ce:7b36 with SMTP id bf13-20020a0564021a4d00b0043574ce7b36mr8777906edb.94.1655970470785;
        Thu, 23 Jun 2022 00:47:50 -0700 (PDT)
Received: from [192.168.1.143] (host-87-242-32-154.prtelecom.hu. [87.242.32.154])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906349700b00709343c0017sm823560ejb.98.2022.06.23.00.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:47:50 -0700 (PDT)
Message-ID: <78c29f43-3b67-8e70-0711-14e997f3efb1@gmail.com>
Date:   Thu, 23 Jun 2022 09:47:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] libata: add horkage for M88V29
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>, zboszor@pr.hu,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20220204125750.1771303-1-zboszor@pr.hu>
 <f726e9e1-bdad-ac8a-368b-aae423a00676@opensource.wdc.com>
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <f726e9e1-bdad-ac8a-368b-aae423a00676@opensource.wdc.com>
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

2022. 02. 08. 9:07 keltezéssel, Damien Le Moal írta:
> On 2/4/22 21:57, zboszor@pr.hu wrote:
>> From: Zoltán Böszörményi <zboszor@gmail.com>
>>
>> This device is a CF card, or possibly an SSD in CF form factor.
>> It supports NCQ and high speed DMA.
>>
>> While it also advertises TRIM support, I/O errors are reported
>> when the discard mount option fstrim is used. TRIM also fails
>> when disabling NCQ and not just as an NCQ command.
>>
>> TRIM must be disabled for this device.
>>
>> Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
>> ---
>>   drivers/ata/libata-core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 67f88027680a..4a7f58fcc411 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>   
>>   	/* devices that don't properly handle TRIM commands */
>>   	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
>> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
>>   
>>   	/*
>>   	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
> Applied to for-5.17-fixes. Thanks !

Thank you. However, I have second thoughts about this patch.
The device advertises this:

# hdparm -iI /dev/sda
...
  Enabled Supported
     *    Data Set Management TRIM supported (limit 1 block)
...

but the I/O failures always reported higher number of blocks,
IIRC the attempted number of block was 8 or so.

Can the kernel limit or split TRIM commands according to the
advertised limit? If not (or not yet) then the quirk is good for now.

Best regards,
Zoltán Böszörményi

