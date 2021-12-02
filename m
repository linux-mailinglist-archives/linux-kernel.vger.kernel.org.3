Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF4466044
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356367AbhLBJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356342AbhLBJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:24:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94EC06174A;
        Thu,  2 Dec 2021 01:21:31 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so58227243wrw.10;
        Thu, 02 Dec 2021 01:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KKZao9CiLbhiWx03cZuFy3JM/YT6jjqmIPUi6bkIvrQ=;
        b=cfQoOIP8RiX+rQERLSfV6lsxYor4PbuSTsyqSuBpkKiSh6xiz9Pw9aifYY/1lky7yF
         oYQ7pbAYpQFcuZKAFNwqlBQ5a8HCiUpUGjs9LIbK/HFn6LYpksZ6U5AYV+pIrL83ovYt
         x47bu1dTU8saTiO+/JFZ+jPBZRzDf2A/a/O4H3pRA0ZHBeRaEPWx8bWCaAnIdNyN3x7P
         G+czQzUYtS3hmfUYyXYdyZzZW/ZkoO0VPW1Q4yp7PHIv2me7hrJsBEZW7L5Z+GjmKA6k
         CxgkldH5eAYFrFANET9nDxsqanBgAHGQKPna/SLnSX1VdUYYMc8crMFM+uggIfE5QB00
         kBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KKZao9CiLbhiWx03cZuFy3JM/YT6jjqmIPUi6bkIvrQ=;
        b=pKSbn/n59ICyByw8x464qqJrVBPA2FRPQS+9JKmKan2LuWFKwJBZ2e4aQsscp66U15
         qdMX2AdRAFuJhTEiZqmXjQDkGPpDRCz2JUPKq0nVG3ae2opmFKlToi030evL4uE5tDN/
         koutbDZU2MPLuMkqe1X2/aWD3+3qjRZGUakFAVoV6ZtEt9k+Z+jM3bKqhtTuq1PpOE9J
         FyTCXN/ARSpMYKonRVU4GCDR7L1c9V5putRrI49IlRpdyOl914RwuSWHBzsrvy0Auk3M
         81WISzDa5mz10Y3qB3KyfRLCCQqMEjAI7JVV7IOsVt2QPJkpNBOsTVay8dyJgTrH1lhO
         Tamw==
X-Gm-Message-State: AOAM532YB5r/81G2mF1kbDjJ51ZmVhwgvfSbUHKnh8tmFvBrcDfUnUBm
        T+uFPU14osl/H1JwjcKv6wg=
X-Google-Smtp-Source: ABdhPJxxlYg0SndEFVCf2IHHxdDwAyuiydOkj/gnN2pKjJ2Xq2lYoll6Mj/B18muFVzIov0fb2nflQ==
X-Received: by 2002:adf:9cc2:: with SMTP id h2mr13368623wre.464.1638436890301;
        Thu, 02 Dec 2021 01:21:30 -0800 (PST)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id m21sm2024566wrb.2.2021.12.02.01.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 01:21:29 -0800 (PST)
Message-ID: <be66d773-0441-0ccb-54fa-1d8f952b8f59@gmail.com>
Date:   Thu, 2 Dec 2021 09:21:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] x86/platform/uv: make const pointer dots a static const
 array
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>, Joe Perches <joe@perches.com>
Cc:     Colin Ian King <colin.i.king@googlemail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211127170320.77963-1-colin.i.king@gmail.com>
 <YaZ8vtajDKUVDCne@swahl-home.5wahls.com>
 <c5a827c2b690aeadf7d633c29edaf4db23d94fdb.camel@perches.com>
 <YafrrfwAMzxrPvWU@swahl-home.5wahls.com>
 <d642a431-41f9-fef5-0c7f-c4cf133c945e@redhat.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <d642a431-41f9-fef5-0c7f-c4cf133c945e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2021 09:10, Hans de Goede wrote:
> Hi,
> 
> On 12/1/21 22:39, Steve Wahl wrote:
>> On Tue, Nov 30, 2021 at 04:26:39PM -0800, Joe Perches wrote:
>>> On Tue, 2021-11-30 at 13:34 -0600, Steve Wahl wrote:
>>>> On Sat, Nov 27, 2021 at 05:03:20PM +0000, Colin Ian King wrote:
>>>>> Don't populate the const array dots on the stack
>>> []
>>>> Examination of the disassembly shows that the compiler actually
>>>> eliminates the creation of the pointer "dots" on the stack and just
>>>> passes the address of the string constant to the printk function.
>>>>
>>>> So this change should not have any actual effect (I don't know where
>>>> you got the "shrinks object code" from), and in my humble opinion
>>>> makes the code less clear.
>>>
>>> Probably shrinks an allmodconfig where the symbols are referenced.
>>> It probably doesn't do anything to a defconfig.
>>
>> OK, I looked. Under allmodconfig, the new code is one byte smaller.
>>
>> Defconfig doesn't include CONFIG_X86_UV and this file doesn't get
>> compiled.
>>
>> Using defconfig plus CONFIG_X86_UV and prerequisites, the new code is
>> 24 bytes larger, probably because of alignment added.
>>
>> allmodconfig:
>>
>>     text	   data	    bss	    dec	    hex	filename
>>    30827	  18358	   1472	  50657	   c5e1	uv_nmi.o
>>    30828	  18358	   1472	  50658	   c5e2	uv_nmi.orig.o
>>
>> default config + CONFIG_X86_UV:
>>
>>     text	   data	    bss	    dec	    hex	filename
>>     9918	    216	    160	  10294	   2836	uv_nmi.o
>>     9894	    216	    160	  10270	   281e	uv_nmi.orig.o
>>
>> So I still don't think this patch makes sense.
> 
> I agree, so I've dropped this patch from the queue.
> 
> Regards,
> 
> Hans
> 

+1.   Apologies for wasting your valuable time. I appreciate the 
detailed review.

Colin
