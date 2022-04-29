Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF8514F10
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378267AbiD2PVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377866AbiD2PVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:21:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B72D4C97
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:18:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e23so9426314eda.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L79R3XQb+oKIBDk5QLBANm8jHmQJdwsv7/GUkSR/Ukc=;
        b=T/U+K1XPO96WhjUEjO2ZLIKqq6qaepXAj+Le6156YlAJW/ifIOnb9lTvlIllFjEOdk
         ld4KvQVcGoDXhFH5pxmyBrPLLVS7oX95lB5AiuidrJDLiNk77H8X+oRsuOoxUf1dnaHH
         +37rbtz5HVmuNqi2Ku8urOyh4h13LuvFR+x5FMss7UinZOZi5REbjNlkssOo2OIh7mU/
         Ej5TQRjjIOOUArL1Aoe2RSl6VkgmB7OesmWlLETlqIKLL6L0IQgI6f+LWIEnN2OV50Eq
         OAeo40EXdw+2uYCs6Ewtn0rTVpD94+M425jg8UZsPP4mDlKZKfm1FulKgS6tK7O7CThX
         +Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L79R3XQb+oKIBDk5QLBANm8jHmQJdwsv7/GUkSR/Ukc=;
        b=vmdMBX5a1aawfYjbgq4QD0HdUAx7ED6MKlRCtDbEkolm8+AEUI03UwfYUu1RdeOUyI
         TUGPo9yqqkBJC/V1V5SgKuLnUES+osKG00n7SQDzPWIM5BKK0rP4XK+cYw6QcIS29fdz
         0NvLc0Vg709U8TApKRYoJN3uO8eepOGGxwSy03BrTXXomieeCaF52GX8tg0A5DNg+WI9
         LK0Obmy2SDIqDPa8r7r+pG8rAapxE3eU4sbHp9Dpj5gTmSAFSlv6fmCxtTdWBSXNw5OE
         rj2A+5/LmNI45QP7FENnmXktO6VAs2p9GJGurGbtaAEN248aSTDkKwHF3u2A/Kn9kLKM
         QFnw==
X-Gm-Message-State: AOAM532aNggX3MVp/V1Ve7Bx0hPlOhitatA0NwhjDTnMEfYwTPOMyNoQ
        MhfD581QSt4JB5581g+axek=
X-Google-Smtp-Source: ABdhPJy09sOXJ3F1bVAlPC+pNd5wtB3fBDT2vPPbBZVhhTO9lbw8Iz6+g872TvqG0WDb9Ir3J8I6zw==
X-Received: by 2002:a05:6402:d5:b0:41d:6518:86e4 with SMTP id i21-20020a05640200d500b0041d651886e4mr41847942edu.322.1651245510037;
        Fri, 29 Apr 2022 08:18:30 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f1b:f037:b0af:cce5:5488:7b95? (p200300c78f1bf037b0afcce554887b95.dip0.t-ipconnect.de. [2003:c7:8f1b:f037:b0af:cce5:5488:7b95])
        by smtp.gmail.com with ESMTPSA id g7-20020aa7d1c7000000b0042617ba63b1sm3093989edp.59.2022.04.29.08.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:18:29 -0700 (PDT)
Message-ID: <b3d6b773-4ca1-a72e-933b-455c5d2b91c9@gmail.com>
Date:   Fri, 29 Apr 2022 17:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with ioread32
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
 <7a5f7f98379fb2af2741f613f5ddda53e5d4813e.1651036713.git.philipp.g.hortmann@gmail.com>
 <Ymjaxby2vDJYz6KA@kroah.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Ymjaxby2vDJYz6KA@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 07:55, Greg Kroah-Hartman wrote:
>> MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
>>   	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
>> @@ -753,8 +754,9 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
>>   	}
>>   	if (ww == W_MAX_TIMEOUT)
>>   		return false;
>> -	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
>> -	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
>> +	low = ioread32(iobase + MAC_REG_TSFCNTR);
>> +	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
>> +	*pqwCurrTSF = low + ((u64)high << 32);
> Are you_sure_  this is doing the same thing?
> 

To compare I used the following code:
VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF: %llx", 
*pqwCurrTSF);
low = ioread32(iobase + MAC_REG_TSFCNTR);
high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF low/high: %llx", low + 
((u64)high << 32));

Output:
vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 1155ba
vt6655 0000:01:05.0: CARDbGetCurrentTSF low/high:    1155ba
vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 35d7cbd7c
vt6655 0000:01:05.0: CARDbGetCurrentTSF low/high:    35d7cbd7c
vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 35d7cbd8a
vt6655 0000:01:05.0: CARDbGetCurrentTSF low/high:    35d7cbd8a

So no different results for numbers larger than 32 Bit.

The pqwCurrTSF is a microsecond counter running in the WLAN Router:
At a later Measurement I got the following values:
269 seconds later: 0x3 6d89 fd91 -> 269.30 seconds
15 minutes later: 0x3 6d89 fd91 -> 15.54 minutes
8:38 hours later: 0xa 9787 ad91 -> 8.62 hours

So both methods work on a AMD64 processor.

> Adding 1 to a u64 pointer increments it by a full u64.  So I guess the
> cast to u32 * moves it only by a u32?  Hopefully?  That's messy.

That is the reason why I wanted to change this.

> Why not keep the current mess and do:
> 	pqwCurrTSF = ioread32(iobase + MAC_REG_TSFCNTR);
> 	((u32 *)pqwCurTSF + 1) = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> Or does that not compile?  

drivers/staging/vt6655/card.c:760:13: warning: assignment to ‘u64 *’ 
{aka ‘long long unsigned int *’} from ‘unsigned int’ makes pointer from 
integer without a cast [-Wint-conversion]
   760 |  pqwCurrTSF = ioread32(iobase + MAC_REG_TSFCNTR);
       |             ^
drivers/staging/vt6655/card.c:761:26: error: lvalue required as left 
operand of assignment
   761 |  ((u32 *)pqwCurrTSF + 1) = ioread32(iobase + MAC_REG_TSFCNTR + 4);
       |                          ^

This compiles:
	*(u32 *)pqwCurrTSF = ioread32(iobase + MAC_REG_TSFCNTR);
	*((u32 *)pqwCurrTSF + 1) = ioread32(iobase + MAC_REG_TSFCNTR + 4);

Log:
vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 178f41d90
vt6655 0000:01:05.0: CARDbGetCurrentTSF with ioread: 178f41d90

Ick, how about:
> 	u32 *temp = (u32 *)pqwCurTSF;
> 
> 	temp = ioread32(iobase + MAC_REG_TSFCNTR);
> 	temp++;
> 	temp = ioread32(iobase + MAC_REG_TSFCNTR + 4);

This is working:
	u32 *temp = (u32 *)pqwCurrTSF;

	*temp = ioread32(iobase + MAC_REG_TSFCNTR);
	temp++;
	*temp = ioread32(iobase + MAC_REG_TSFCNTR + 4);

> As that duplicates the current code a bit better.
> 
> I don't know, it's like polishing dirt, in the end, it's still dirt...
> 
> How about looking at the caller of this to see what it expects to do
> with this information?  Unwind the mess from there?
>

I will propose something for that.

> thanks,
> 
> greg k-h

Thanks

Bye Philipp
