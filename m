Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7C4D81E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbiCNL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbiCNL5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:57:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A160AE49
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:55:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e2so13290497pls.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KTvK/tAz5DZFZ3Kzshxhj1MZq5011xDi3PnkIqV+z7Y=;
        b=C2AHHDQQIiqrD/AwF/0JYGpuDv/xfIZDqkvxnaWi3sP8ONj8vNrzZsswi3ZIpJ+atv
         c4aQYR/L+VWpc3jNAuazuTGI1s+Gu3YaSUvn1GBt9vq061wX1vvTfvbwBsgWzIqUqF2u
         VXnbR+ayVV/2uPqmMSSphKMTaG63mfArsORumeDbc5fPOM8du8WxRKq9qH25iec6OrW6
         KGKPkT/T346K0rFucth/rJv2+8Cgvho0IUBLgNrz4okICFCzrfpuM+4LetNIpBxkqAyx
         Ykw2cSuPT1nr8rjrG1fx1Z+NcXRKcEq92Cz8r8Y/lks9NuHfVa7Qy/b8sweuqMD9DceY
         ENZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KTvK/tAz5DZFZ3Kzshxhj1MZq5011xDi3PnkIqV+z7Y=;
        b=sFolmx2Eh8iDONjaVWCV6/Dg0leX5YHi3jL7hxqC2HdwEJxzhkPZbwlvelyirTKDfw
         1S64/mB3XILZk7EHyO7pW5EswFLf95KPJUCVDHqUWsi8+ty5Gz7WcFlV32ys/hljkp5D
         02wFuvKyHEXZfORP7fRzVrWThW4ymOynw5KR73tXUxsMnscQRNURvagItc9KB+mzfZRw
         elStYO+UrHswmRbdVZP8L7iHMBg1tIBVVEcKKLfm36aYrqy95MtflE249HZLt3OlzlNT
         W1eQpN4nSVaA9yZXlHDUjxPOA6U3PAyLWBxTAfFoyXWetu1XUEi/5cC5c7q3UQM4qKmK
         E/Bw==
X-Gm-Message-State: AOAM532iNr1fSFTAMJustp1katUeCC2netPxmQL2aBJwEqOKcfZo7PaL
        12/pYxplyhEfe+otXceM0mc=
X-Google-Smtp-Source: ABdhPJyGcMgUVAsUijvdWNO1aFsGNt8yUNTBb7lptKjjJfkHLhF0x1sLyDOu+xd+UFiijxixlot6JA==
X-Received: by 2002:a17:903:183:b0:151:af32:890d with SMTP id z3-20020a170903018300b00151af32890dmr23648983plg.0.1647258949670;
        Mon, 14 Mar 2022 04:55:49 -0700 (PDT)
Received: from [192.168.1.102] ([45.250.64.116])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a2c0c00b001bc4cf0107esm17348655pjd.53.2022.03.14.04.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 04:55:49 -0700 (PDT)
Message-ID: <3ee0dda3-d80b-4058-49e7-88ceb6426459@gmail.com>
Date:   Mon, 14 Mar 2022 17:25:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 const keyword Warning found by checkpatch.pl script.
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOl?= =?UTF-8?Q?g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20220312204128.3942-1-shaikhkamal2012@gmail.com>
 <303ed0c8-8e2c-51a4-a4da-be973a25cdec@gmail.com>
 <bf27518d-4990-8b0e-c6ea-26a658ce2e54@gmail.com> <Yi8oFtMxfTkPF8/h@kroah.com>
From:   shaikh kamaluddin <shaikhkamal2012@gmail.com>
In-Reply-To: <Yi8oFtMxfTkPF8/h@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/2022 5:03 PM, Greg Kroah-Hartman wrote:
> On Mon, Mar 14, 2022 at 04:55:55PM +0530, shaikh kamaluddin wrote:
>> On 3/13/2022 3:13 AM, Pavel Skripkin wrote:
>>> Hi Shaikh,
>>>
>>> On 3/12/22 23:41, shaikh kamal wrote:
>>>> Signed-off-by: shaikh kamal <shaikhkamal2012@gmail.com>
>>>> ---
>>>>    drivers/staging/android/ashmem.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/staging/android/ashmem.c
>>>> b/drivers/staging/android/ashmem.c
>>>> index ddbde3f8430e..4c6b420fbf4d 100644
>>>> --- a/drivers/staging/android/ashmem.c
>>>> +++ b/drivers/staging/android/ashmem.c
>>>> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file
>>>> *file, unsigned long addr,
>>>>    static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>>>>    {
>>>> -    static struct file_operations vmfile_fops;
>>>> +    static const struct file_operations vmfile_fops;
>>>>        struct ashmem_area *asma = file->private_data;
>>>>        int ret = 0;
>>>
>>> Are you sure this patch compiles? vmfile_fops is overrided few lines below
>>>
>>> odd checkpatch.pl warning...
>>>
>>>
>>>
>>>
>>> With regards,
>>> Pavel Skripkin
>>
>> Thank you,yes vmfile_fops is overrided in below code.
>> Building the kernel - make -j4,
>> drivers/staging/android/ashmem.c: In function ‘ashmem_mmap’:
>> drivers/staging/android/ashmem.c:431:16: error: assignment of read-only
>> variable ‘vmfile_fops’
>>      vmfile_fops = *vmfile->f_op;
>>                  ^
>> drivers/staging/android/ashmem.c:432:21: error: assignment of member ‘mmap’
>> in read-only object
>>      vmfile_fops.mmap = ashmem_vmfile_mmap;
>>                       ^
>> drivers/staging/android/ashmem.c:433:34: error: assignment of member
>> ‘get_unmapped_area’ in read-only object
>>      vmfile_fops.get_unmapped_area =
>>                                    ^
>> scripts/Makefile.build:288: recipe for target
>> 'drivers/staging/android/ashmem.o' failed
>> make[3]: *** [drivers/staging/android/ashmem.o] Error 1
>> scripts/Makefile.build:550: recipe for target 'drivers/staging/android'
>> failed
>> make[2]: *** [drivers/staging/android] Error 2
>> scripts/Makefile.build:550: recipe for target 'drivers/staging' failed
>> make[1]: *** [drivers/staging] Error 2
>> Makefile:1831: recipe for target 'drivers' failed
> 
> As always, it is expected that when you submit a change to the kernel,
> at the very least you have test-built it to ensure that it does not
> break the build.  Please remember to do this next time.
> 
> thanks,
> 
> greg k-h


Thank you, I will do that.

Regards,
Shaikh Kamaluddin
