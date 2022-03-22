Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A14D4E3E89
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiCVMeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiCVMeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:34:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923DB6D867;
        Tue, 22 Mar 2022 05:32:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so2158997wms.2;
        Tue, 22 Mar 2022 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s1JUJCCgG5/o2Zp0PVl1hbmBjO3D2+rLg6kaSAKktV8=;
        b=jS7+/KvA3Oefko2h/dqc+VGDYDUNth7fCiYMN8PX6Lz/S+7YSFxWSEJJfZu9s+IJFw
         S+JbKyv8XGzyVks7u1FfvWcQ7ouvh6zhHNmGqhDIOKYFa8V+apBh/8k5uIfOsxAbdOyT
         7EUZjVTbH6yht5hwz2sYu/V6wxdg5wBARwT7S8MGZk3AAHa4F0RxSmiFukGdI7N+N3Ij
         cXP8FN48ttB/nvs8at1ToUaDlmeHxl850SdFIevuAml7yrSIFKpMfgLRxXaW2NE3sSHL
         OwEqLtiMVTocIWwcE2EoV4pSd5AILb6uSJJDxp6Anubs+t7wF5paBMhMHVH5z4ZJBSKN
         eyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s1JUJCCgG5/o2Zp0PVl1hbmBjO3D2+rLg6kaSAKktV8=;
        b=oQgGosI1ucISnKhJA0LPvqas0OMqccAw1s8x3dSxzFxvVVs3+ctMn4Ad2D+YNPbrws
         203AoXfztIExYsWHzl0w4IoBV63CIgPtGAWUc+aTggBYHvWRuJFaQ+amX1a8w2ge3QCy
         yZ8LSsDytxi0M2vdpmIITrd+oeVkkfr3RoqE3Hv4QsvX3gxmQs62SfiAf69mark8oy6Z
         PKEra6xPnLcmabDe+eW4npUZ9iJ6EupiB1sfj4Ux4PWNklWyyN/DfZeuZWx+DMTWiv/Z
         N6u4jTYSnqLRIQ4B2K4HeD5d6gBzEJLkTmnIp+G9bYocHeT8hPxdeIOiI2587YKosKua
         Gtxg==
X-Gm-Message-State: AOAM532FODC0Dh+pI9RoTjX0jyxeBYDYcJoAaTPTkZsT1IxDsH84LEbP
        MR87tn0NjoQWKX9IiVxXnVo=
X-Google-Smtp-Source: ABdhPJyNcGl6JSE0x09iKOEbNKdNrkLeqPqFsPCjCCBQzi8KOxj8+oPuUCqlvq63ocVlyaAJzBJM2A==
X-Received: by 2002:a05:600c:ad1:b0:38c:8bf6:7d6b with SMTP id c17-20020a05600c0ad100b0038c8bf67d6bmr3710820wmr.84.1647952355154;
        Tue, 22 Mar 2022 05:32:35 -0700 (PDT)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d47ce000000b00203e0a21c16sm18518776wrc.3.2022.03.22.05.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 05:32:34 -0700 (PDT)
Message-ID: <a2380fac-d173-50e3-963a-d7fc22b2da5d@gmail.com>
Date:   Tue, 22 Mar 2022 13:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ioctl_userfaultfd.2: Corrections for returned .ioctls
 members
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Ian Abbott <abbotti@mev.co.uk>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
References: <20220318191343.72812-1-abbotti@mev.co.uk>
 <YjgW7L77+Y2fylcR@xz-m1.local>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <YjgW7L77+Y2fylcR@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian and Peter,

On 3/21/22 07:10, Peter Xu wrote:
> On Fri, Mar 18, 2022 at 07:13:43PM +0000, Ian Abbott wrote:
>> Support for the `UFFDIO_WRITEPROTECT` operation is not indicated in the
>> `ioctls` member of `struct uffdio_api`.  It is indicated in the `ioctls`
>> member of `struct uffdio_register` along with indications of support for
>> the `UFFDIO_COPY`, `UFFDIO_WAKE` and `UFFDIO_ZEROPAGE` operations (and
>> also the `UFFDIO_CONTINUE` operation supported since Linux 5.13 but
>> that is not documented by this man page yet.)
> 
> I thought it should have landed but indeed it's not.  Copying Axel.
> 
>>
>> Fixes: f559fa36a678 ("ioctl_userfaultfd.2: Add write-protect mode docs")
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

Patch applied.

> 
> The patch looks correct to me, thanks for fixing it.
> 
> Acked-by: Peter Xu <peterx@redhat.com>

And tag appended.

Thank you both!

Alex

> 
>> ---
>>   man2/ioctl_userfaultfd.2 | 27 ++++++++++++++++++++-------
>>   1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
>> index 504f61d4b..e930af520 100644
>> --- a/man2/ioctl_userfaultfd.2
>> +++ b/man2/ioctl_userfaultfd.2
>> @@ -235,11 +235,6 @@ operation is supported.
>>   The
>>   .B UFFDIO_UNREGISTER
>>   operation is supported.
>> -.TP
>> -.B 1 << _UFFDIO_WRITEPROTECT
>> -The
>> -.B UFFDIO_WRITEPROTECT
>> -operation is supported.
>>   .PP
>>   This
>>   .BR ioctl (2)
>> @@ -333,8 +328,26 @@ If the operation is successful, the kernel modifies the
>>   bit-mask field to indicate which
>>   .BR ioctl (2)
>>   operations are available for the specified range.
>> -This returned bit mask is as for
>> -.BR UFFDIO_API .
>> +This returned bit mask can contain the following bits:
>> +.TP
>> +.B 1 << _UFFDIO_COPY
>> +The
>> +.B UFFDIO_COPY
>> +operation is supported.
>> +.TP
>> +.B 1 << _UFFDIO_WAKE
>> +The
>> +.B UFFDIO_WAKE
>> +operation is supported.
>> +.TP
>> +.B 1 << _UFFDIO_WRITEPROTECT
>> +The
>> +.B UFFDIO_WRITEPROTECT
>> +.TP
>> +.B 1 << _UFFDIO_ZEROPAGE
>> +The
>> +.B UFFDIO_ZEROPAGE
>> +operation is supported.
>>   .PP
>>   This
>>   .BR ioctl (2)
>> -- 
> 

-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
