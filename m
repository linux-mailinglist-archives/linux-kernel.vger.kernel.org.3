Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5944578B66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiGRUBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiGRUBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:01:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BD61277A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:01:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so7972922wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=juywSF6kivPVUCDC/3oKIs3f7hUcTtSz7n8yKgroz60=;
        b=ZvIYtRO+ujX46pjEvyB7XnyOdQeKac4TxCgDWEn/vnwhJndWwMvo/lHoJiWYKHCaVe
         QIAqdcg/9E+mc3lXM2mfr+S1kIT9OxDuTe68b5ibo2AWP8EdCjByWcVPTheIUoO1Ds95
         l2GphB6de49/b0l18CM1srazpj+m6DpVKlGm4Y+6MBRjJg3ntjnZ7nsxobi4wlTiRZpo
         xgNEYwQF0vofUDHhSSkCZii8FNwJPJxcrp2WpduwD94EGdsyBU1JlJRQal56vDAjzL5L
         REwthKiBkyphAnJi2jo+6F0qLPS+dQT+7AFXoLbBc045anv+ng2tM1DBq9MHDEWkL7Kt
         1aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=juywSF6kivPVUCDC/3oKIs3f7hUcTtSz7n8yKgroz60=;
        b=8MVPO2dQ+i01zr113zx26c/D1WX76XIPYnlqrZsEoV3cz/0Divczd6SmsMjE14lwxu
         vew7j9uA6yFHX7CapkKw93XOEXOon7xCys+hbuWlit9r59+5Ir7mHAQTxKp+C0RCrP6T
         27RCbL0hYZmayiPyR90iHVriE7AozALEQYCusquQ+9NP6BSjSBVdk5jLNXWBxfYLCtSa
         C+u+1oflVHoykZQVAIdMo98BGGfXYTXXzX7xZzVgokehRfEujzMfU0eZuDqFiIGdDSxm
         t4nJW1yp0bMW6jSKN4ESV9xm4D4BKQviT7Kno8oUAWjHBBNwIXcbSSgBR4g6gXz8bbet
         W7LA==
X-Gm-Message-State: AJIora/dQglFn77S3NazA/DTQykEf7gsYkLm6nKGbmehVChkFNP9OViE
        M2D+fZ1dXh17vV/ws6IHi84=
X-Google-Smtp-Source: AGRyM1tUpgqlD9Quxxx+3N1IOfEiChOCwJTSHv8j3ZpMTvj1v3U1oxi0x66tQclQ08tbw3gJLwY7zQ==
X-Received: by 2002:a05:600c:2d09:b0:3a3:1062:ce61 with SMTP id x9-20020a05600c2d0900b003a31062ce61mr14389529wmf.138.1658174461318;
        Mon, 18 Jul 2022 13:01:01 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6999:b072:faf1:1e0f:8765? (p200300c78f2e6999b072faf11e0f8765.dip0.t-ipconnect.de. [2003:c7:8f2e:6999:b072:faf1:1e0f:8765])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003a320b6d5eesm1676674wmd.15.2022.07.18.13.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 13:01:00 -0700 (PDT)
Message-ID: <71368760-0399-52f2-ca6e-ad8f4daf8003@gmail.com>
Date:   Mon, 18 Jul 2022 22:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] staging: vt6655: Replace MACvReceive1 with function
 vt6655_mac_dma_ctl
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
 <c433e54f0fae051fc8ba9050aa094d6f7141e8d4.1658094708.git.philipp.g.hortmann@gmail.com>
 <20220718124136.GE2338@kadam>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220718124136.GE2338@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 14:41, Dan Carpenter wrote:
> On Mon, Jul 18, 2022 at 12:20:25AM +0200, Philipp Hortmann wrote:
>> checkpatch.pl does not accept multiline macros.
>>
> 
> What?  Really?
You are right. It does not really complain about multiline macros but 
you cannot have a clean checkpatch check when using more than one macro 
containing the same variable. Find more info below.
> 
> I tested this to see if was true and it just complained about potential
> side effects on iobase.
> 
> regads,
> dan carpenter
> 
>> diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
>> index 5747de436911..129a6602f6f0 100644
>> --- a/drivers/staging/vt6655/mac.h
>> +++ b/drivers/staging/vt6655/mac.h
>> @@ -537,16 +537,6 @@
>>   
>>   /*---------------------  Export Macros ------------------------------*/
>>   
>> -#define MACvReceive1(iobase)						\
>> -do {									\
>> -	unsigned long reg_value;					\
>> -	reg_value = ioread32(iobase + MAC_REG_RXDMACTL1);		\
>> -	if (reg_value & DMACTL_RUN)					\
>> -		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL1);	\
>> -	else								\
>> -		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL1);	\
>> -} while (0)
>> -
>>   #define MACvTransmit0(iobase)						\
>>   do {									\
>>   	unsigned long reg_value;					\
> 

I was asking in kernelnewbies what to do with multi line macros as 
checkpatch.pl warnings cannot be totally avoided.

Greg replied to make functions out of them.

Please find the full email under:

https://www.mail-archive.com/kernelnewbies@kernelnewbies.org/msg22042.html

In this case I really like the static function solution much more than 
the macros.

Thanks for your support.
