Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E338353EE39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiFFS5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiFFS5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:57:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B49220D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:57:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w20so3110577lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nIz93hX2PQ4fhuhp1jMpyp0wJt0SBYcIreMeL3lWdNY=;
        b=PRIGkpN6xE0WkLxBRa2NL7ikMvENhq0/W55wukWNbpiU5svpBNZQqC3XEupJcPPfWc
         8oppZyUKGVgquZiSnv7aXlI71ZyA1ATmq3KM6WsUkuXABCAhWKZgSHOmOsT4/8+npwnV
         dm1E6BMsMN8PeZlNbmP2wTeSsOYhopNqqKCjafSDXtQgKgvFDV8TnCLqvTVYHJQqCgiw
         UnfNTnPTzdEFtr9VD2VM3K1a/ylB90PlmfekQovRqINRFzVjmOJVDycsUy0URUX0P+Io
         MVdDg8BuazsCqpyUpeO3UtMWBfNuLkCaFmWyhwje5onPTPKLjkC67pyPAQYWfiQmYOdD
         rebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nIz93hX2PQ4fhuhp1jMpyp0wJt0SBYcIreMeL3lWdNY=;
        b=CrJDyJdMsWcRNDqwQxiwe9N/z4QHclIwB31QiJUb77ATtmBz8DM/USz6wgBqONgeZo
         rhrbn5UabDdww0Cr2yIXr4kBZ6xmW5Bdst+VSl/UBzpJEfiYaSp0RO9dvEFU87PCxRZL
         d6tPK2hfhB1CEgPoeCk8eA5i4g4qYKc6ve9VppAEXEtQ9moNM+beiCfTfCM7rQEBknty
         FG9r0IdyH/7kxmVd6lvb/EY3gorM1WHjfp2buYUKdc7SErMTr0bYVnb6Sr6wA/nrZXKr
         3rKHfmiZPrhpaiqG8WZNvGTPWguse7+4stW7opDR8zViukATLS8ez99fW01WmDmlJXFB
         yVxw==
X-Gm-Message-State: AOAM530iTsZn+mRX7gOAxb9CV2PuUSNtbR5eu30JKyoJBnCo7Bzj2ZYU
        jedpSER0PSYhxT8cVxHLMhg=
X-Google-Smtp-Source: ABdhPJzx4OHSkLUGA6dbuYoqvNRaBXgj04jBulDxf8sYwpXbDWn+W3PyS0m2Ljm3XH7+T+DHSX6jhw==
X-Received: by 2002:a05:6512:e90:b0:477:cc44:9813 with SMTP id bi16-20020a0565120e9000b00477cc449813mr16943484lfb.226.1654541855259;
        Mon, 06 Jun 2022 11:57:35 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id w10-20020ac2442a000000b0047255d211b2sm2953285lfl.225.2022.06.06.11.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 11:57:34 -0700 (PDT)
Message-ID: <5d57d0f5-06bd-5e3a-2cb9-d8ae531e453e@gmail.com>
Date:   Mon, 6 Jun 2022 21:57:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/4] staging: r8188eu: add error handling of rtw_read8
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <cover.1652994483.git.paskripkin@gmail.com>
 <541ab3341093a8f6bff1cf8e8aa0c7e247ff4833.1652994483.git.paskripkin@gmail.com>
 <Yp2VMecmrET9Mu3P@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <Yp2VMecmrET9Mu3P@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 6/6/22 08:48, Greg KH wrote:
>> -	rtw_read8(padapter, REG_FMETHR);
>> +	/* FIXME: should this read be removed? */
>> +	res = rtw_read8(padapter, REG_FMETHR, &reg);
>> +	(void)res;
> 
> What is that?  We don't do "empty" lines like this in the kernel for no
> good reason.  If the return value must be checked, then that's fine, but
> don't do it this way.  Shouldn't the function itself return an error?
> 
> And reading a value is sometimes required by hardware in order to have
> the write call go through.  But that's for PCI devices, not normally USB
> devices, but we could be wrong.  I wouldn't put a FIXME in here unless
> you have some plan for how to eventually solve it, otherwise someone
> might just drop it without knowing why the FIXME was ever added.
> 
> 

Ok, I will just make this function return an error. Thanks

[snip]

>>  
>> diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
>> index b944c8071a3b..a5b7980dfcee 100644
>> --- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
>> +++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
>> @@ -463,6 +463,7 @@ void _PHY_SaveADDARegisters(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup
>>  	}
>>  }
>>  
>> +/* FIXME: return an error to caller */
> 
> When are these FIXME going to be resolved?  I don't like adding them for
> no good reason.
> 

After this series will go in. I really don't want to make this series 
huge, since ideally read errors should be passed up to callers. This 
driver has a lot of very deep call-chains, so fixing them in one series 
is just unreal

I have a plan to address these FIXMEs, that's why I've planted them.


thanks for review,


With regards,
Pavel Skripkin
