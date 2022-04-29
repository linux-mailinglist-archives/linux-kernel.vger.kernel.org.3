Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F93515662
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379231AbiD2VIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiD2VIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:08:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A38D3DBC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:04:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a21so10401116edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8eQTSMEoSGParygVoj3+ymgdpI1EExa13g8W+3smNRQ=;
        b=Pe6qjHiq/KndCD4eNCz7kgpWna8U8HFs4oQuyqdwSECfPbK42UoiO8vMZbFqqH+ZFg
         jyUBKsaAZY0adoytfGsJKMDo5/6AVezc6dPFFuq2bKU7VW8260VdWtxP056DXmYHO3rk
         n1wg+eJ/mCLDnynsUGLnAXMgGA2m+ET6Gh+i+FIhmR4ORZ34AtoRrcihsqOUVr1FhaqX
         g8xvNVIrgIQA4qQq4UQk8rVV5WCAXN2cflPr31mkTRuEvToE/9CGCJ/Q4acnFRwLpOoQ
         e7bx9/+8clMWtH8lhR44fQNPgleL/6GkFTAbzxdYfnZJFfgN86KpjHz5e/l1R5ahaJJ/
         gN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8eQTSMEoSGParygVoj3+ymgdpI1EExa13g8W+3smNRQ=;
        b=ZUj4m6Eux8Vwe6SYIKR2NfN3kqCywoTCYOQxQVKk6cTJbrQk5VtJDqg1ZxpmbWodl2
         c0TD/Dm0oeLwnspC9TTZvCMQ8SzguFhiXWPfnt3/xpFY4bNXGFYg7xQljY1tYfbqaFXE
         iwANpsxdTE3oOEKC3MJAblPTNflG5u5qpxOH7HgjxRXyEtoQIB7F36cis+7pvjd+uVJC
         qt8BemrQ5BgyiG+9y1Gigf+yX0FO1zMGh2nH5vmJTgTd6jnPBmD0dV004mR3JVYhJH5D
         tvVKmf8814OMc0xncaRFRfVT9AkxqFcdKGxBmXr+TBbzGa5uJhipNnO8wlAb7B422x3w
         HSPA==
X-Gm-Message-State: AOAM532yK1cruiWUX0z/ASIS/bv7+qtVrdLBie9AFQSqWfZy299G0QWi
        9Yc3DE/EET3DvwZUcyuy1rYeIos51zHJyQ==
X-Google-Smtp-Source: ABdhPJxESK6FmohgVL7cp3cjAcet0xca07E/Xf1MtSyRGC6+6faU4Gf+oVV2j+Tmg4a6pxRJDU49aA==
X-Received: by 2002:a50:f69b:0:b0:425:e693:5d1f with SMTP id d27-20020a50f69b000000b00425e6935d1fmr1194047edn.272.1651266296123;
        Fri, 29 Apr 2022 14:04:56 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f1b:f037:a74b:9b9a:fe0c:be7d? (p200300c78f1bf037a74b9b9afe0cbe7d.dip0.t-ipconnect.de. [2003:c7:8f1b:f037:a74b:9b9a:fe0c:be7d])
        by smtp.gmail.com with ESMTPSA id zd7-20020a17090698c700b006f3ef214dfesm988062ejb.100.2022.04.29.14.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 14:04:55 -0700 (PDT)
Message-ID: <6ecca4d7-8b1f-7476-da4b-b1d94995b0e8@gmail.com>
Date:   Fri, 29 Apr 2022 23:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with ioread32
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
 <7a5f7f98379fb2af2741f613f5ddda53e5d4813e.1651036713.git.philipp.g.hortmann@gmail.com>
 <Ymjaxby2vDJYz6KA@kroah.com> <b3d6b773-4ca1-a72e-933b-455c5d2b91c9@gmail.com>
 <YmwDZi3mmWRHzKAT@kroah.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <YmwDZi3mmWRHzKAT@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 17:25, Greg Kroah-Hartman wrote:
> On Fri, Apr 29, 2022 at 05:18:28PM +0200, Philipp Hortmann wrote:
>> On 4/27/22 07:55, Greg Kroah-Hartman wrote:
>>>> MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
>>>>    	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
>>>> @@ -753,8 +754,9 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
>>>>    	}
>>>>    	if (ww == W_MAX_TIMEOUT)
>>>>    		return false;
>>>> -	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
>>>> -	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
>>>> +	low = ioread32(iobase + MAC_REG_TSFCNTR);
>>>> +	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
>>>> +	*pqwCurrTSF = low + ((u64)high << 32);
>>> Are you_sure_  this is doing the same thing?
>>>
>> To compare I used the following code:
>> VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
>> VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
>> dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF: %llx",
>> *pqwCurrTSF);
>> low = ioread32(iobase + MAC_REG_TSFCNTR);
>> high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
>> dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF low/high: %llx", low +
>> ((u64)high << 32));
>>
>> Output:
>> vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 1155ba
>> vt6655 0000:01:05.0: CARDbGetCurrentTSF low/high:    1155ba
>> vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 35d7cbd7c
>> vt6655 0000:01:05.0: CARDbGetCurrentTSF low/high:    35d7cbd7c
>> vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 35d7cbd8a
>> vt6655 0000:01:05.0: CARDbGetCurrentTSF low/high:    35d7cbd8a
>>
>> So no different results for numbers larger than 32 Bit.
> And for a big endian system?  Do you get the same result?
> 

Using ioread32be to simulate output of the big endian computer.

Code:
	u32 *temp = (u32 *)pqwCurrTSF;	
	
	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF: 
0x%016llx", *pqwCurrTSF);

	temp++;
	*temp = ioread32be(iobase + MAC_REG_TSFCNTR);
	temp--;
	*temp = ioread32be(iobase + MAC_REG_TSFCNTR + 4);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF big-endian: 
0x%016llx", *pqwCurrTSF);

	*temp = ioread32(iobase + MAC_REG_TSFCNTR);
	temp++;
	*temp = ioread32(iobase + MAC_REG_TSFCNTR + 4);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF little endian: 
0x%016llx", *pqwCurrTSF);

Output:
[21250.521826] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 
0x00 00 00 05 f8 55 1d 9b
[21250.521831] vt6655 0000:01:05.0: CARDbGetCurrentTSF big-endian: 
0x9b 1d 55 f8 05 00 00 00
[21250.521835] vt6655 0000:01:05.0: CARDbGetCurrentTSF little endian: 
0x00 00 00 05 f8 55 1d 9b

Code 2:
	u32 high, low;
	
	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF: 
0x%016llx", *pqwCurrTSF);

	low = ioread32be(iobase + MAC_REG_TSFCNTR);
	high = ioread32be(iobase + MAC_REG_TSFCNTR + 4);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF big-endian: 
0x%016llx", high + ((u64)low << 32));

	low = ioread32(iobase + MAC_REG_TSFCNTR);
	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF little endian: 
0x%016llx", low + ((u64)high << 32));

Output 2:
[21996.659694] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 
0x00 00 00 06 24 cd 8d 91
[21996.659698] vt6655 0000:01:05.0: CARDbGetCurrentTSF big-endian: 
0x91 8d cd 24 06 00 00 00
[21996.659701] vt6655 0000:01:05.0: CARDbGetCurrentTSF little endian: 
0x00 00 00 06 24 cd 8d 91

[22453.448296] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 
0x00 00 00 06 40 07 dd a3
[22453.448300] vt6655 0000:01:05.0: CARDbGetCurrentTSF big-endian: 
0xa3 dd 07 40 06 00 00 00
[22453.448304] vt6655 0000:01:05.0: CARDbGetCurrentTSF little endian: 
0x00 00 00 06 40 07 dd a3

I am assuming that in case the big endian computer is used the ioread32 
will be automatically converted to ioread32be. So I have only to care 
about the u32 to be exchanged. That is easier with the second example.

Code:
	low = ioread32(iobase + MAC_REG_TSFCNTR);
	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);

#ifdef __BIG_ENDIAN
	*pqwCurrTSF = high + ((u64)low << 32);
#else
	*pqwCurrTSF = low + ((u64)high << 32);
#endif

Comments are welcome.

This is the article that helped me a lot:
https://en.wikipedia.org/wiki/Endianness#Bit_endianness
Especially the "Endian example" picture

Thanks,
Bye Philipp
