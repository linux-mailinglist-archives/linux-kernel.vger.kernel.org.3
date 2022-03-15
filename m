Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024F84D99ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347803AbiCOLGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347828AbiCOLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:06:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5064C7B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:05:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso2070314pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=kuK4I2tojx5UmkgwIWGWy7dBaK7RpGnhCg0EIQSmGxw=;
        b=qrx7ZR9ndfJG3lJpJBz/HJZ9Ap9HB1jiHmW+Yf9ayVXtZ+5iVwMyYWMNpvOp6TXiGR
         L7zUbiJ/prSfJZfnwV5vkWPFV9Hpx4ISpf8pRXKFrGBHz3j/OJTHsGRWOHj6MZaC+acY
         scMv8RNLAw9oEzrojECbS7FpI0+JYvXd6X2PWp0CPTk6MA8PVGuoWqnqkuOy2mU8PhRU
         ocqww9WBDEbxrWrRmEUfm2dKL9Dp4MbeqxN75bPu4ex2uCZYBh4nBh8WtxY7yRkDleb7
         HI4rkOj37DL6db7N6oMcVOMhEvvmU5m4WdhpN3p+1WWymVThvUCzN5R+4e+omsVcRAAI
         uMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kuK4I2tojx5UmkgwIWGWy7dBaK7RpGnhCg0EIQSmGxw=;
        b=6vyjP129ndzWl8OyT6DQ52gUYyL8LyfN+hVmPPbTf4ax4s3w/hbAlBLuIyvQvJCbwW
         TXbqdQ9bhHiAcwEpaeTRU1gwyfQj+h01oTNjGt0UPfLAh9eaBe7RLwxewSl///JUIDLI
         0fyBOYiHFkZpT6CqRatpInP2r9j6yd/3UlKQFuHWB5pjYGDrGiHXA94QzDADe1o3kMf8
         tQnLh5AmXv6f6ABHACe6P4ZTd07n7BwODQMQXAt5D9CakIR22Pl9cBU0rJD9j6rubNhd
         J820fvHhTHBJdi6UUKWg711+tBVs0VoZSKl7qDt3t9uPH95veXNjBiphtIiAbZTuFW/K
         Sx4A==
X-Gm-Message-State: AOAM532erAFU049AsGir/fuCWHn1Z2edgC3weMf+gAr0+Nx9r035o7u3
        qZUjEv7ls6qiNZmeyVB56p4=
X-Google-Smtp-Source: ABdhPJypZlFCeCodjEQKPkdy0A15ZfdulIZDg/AcsnNrzl7o3ou5sEUVcNOUj3lYdGf68D4r8WAGjw==
X-Received: by 2002:a17:902:e848:b0:151:e3a5:b609 with SMTP id t8-20020a170902e84800b00151e3a5b609mr27320794plg.137.1647342335590;
        Tue, 15 Mar 2022 04:05:35 -0700 (PDT)
Received: from [127.0.0.1] ([103.97.175.139])
        by smtp.gmail.com with ESMTPSA id lr9-20020a17090b4b8900b001c645bf9a0bsm1798544pjb.1.2022.03.15.04.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 04:05:35 -0700 (PDT)
Message-ID: <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
Date:   Tue, 15 Mar 2022 19:05:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-erofs@lists.ozlabs.org,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
 <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
From:   Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
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

在 2022/3/15 18:55, Gao Xiang 写道:
> On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
>> 在 2022/3/15 15:51, Dongliang Mu 写道:
>>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>>
>>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
>>> is triggered by injecting fault in kobject_init_and_add of
>>> erofs_unregister_sysfs.
>>>
>>> Fix this by remembering if kobject_init_and_add is successful.
>>>
>>> Note that I've tested the patch and the crash does not occur any more.
>>>
>>> Reported-by: syzkaller <syzkaller@googlegroups.com>
>>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>>> ---
>>>    fs/erofs/internal.h | 1 +
>>>    fs/erofs/sysfs.c    | 9 ++++++---
>>>    2 files changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index 5aa2cf2c2f80..9e20665e3f68 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
>>>    	u32 feature_incompat;
>>>    	/* sysfs support */
>>> +	bool s_sysfs_inited;
>> Hi Dongliang,
>>
>> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra member in
>> sbi ?
> Ok, I have no tendency of these (I'm fine with either ways).
> I've seen some usage like:
>
> static inline int device_is_registered(struct device *dev)
> {
>          return dev->kobj.state_in_sysfs;
> }
>
> But I'm still not sure if we need to rely on such internal
> interface.. More thoughts?

Yeah... It seems that it is better to use some of the interfaces 
provided by kobject,
otherwise we should still maintain this state in sbi.

Thanks,
Jianan

> Thanks,
> Gao Xiang
>> Thanks,
>> Jianan
>>
>>>    	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>>>    	struct completion s_kobj_unregister;
>>>    };
>>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>>> index dac252bc9228..2b48a4df19b4 100644
>>> --- a/fs/erofs/sysfs.c
>>> +++ b/fs/erofs/sysfs.c
>>> @@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
>>>    				   "%s", sb->s_id);
>>>    	if (err)
>>>    		goto put_sb_kobj;
>>> +	sbi->s_sysfs_inited = true;
>>>    	return 0;
>>>    put_sb_kobj:
>>> @@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
>>>    {
>>>    	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>> -	kobject_del(&sbi->s_kobj);
>>> -	kobject_put(&sbi->s_kobj);
>>> -	wait_for_completion(&sbi->s_kobj_unregister);
>>> +	if (sbi->s_sysfs_inited) {
>>> +		kobject_del(&sbi->s_kobj);
>>> +		kobject_put(&sbi->s_kobj);
>>> +		wait_for_completion(&sbi->s_kobj_unregister);
>>> +	}
>>>    }
>>>    int __init erofs_init_sysfs(void)

