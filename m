Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35E54D808F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbiCNLUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237211AbiCNLUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:20:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C6638BC3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:18:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id rm8-20020a17090b3ec800b001c55791fdb1so6361126pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dpq2jd5nmzdPBxLx2tXJQXsCy3Tj/t5W3K7mDTr0mRA=;
        b=jh/Cnw1mFIfgU+lkoZrJoF0z6Z6W9mFhDXhB5+RnCHYuKE5YhSDNj9/g7UVKLRN/3y
         ngf5XPbBFRBYJxq9ucd7l+r91HkUvWYN4cffHl68Z07pcKMUiJWixniIYPdiQ6hpT/0t
         Sk91booBlv/neFQH87+V1m+zaEqXSoKwW0A+/lUVKmEo5F4Q690hCPa1tBS3sjW4e6os
         YBGI+5KSwBwLdwjdOT4iCLqCd9Bd+nxcf1ba3jN4nh+e6Gdl4ZzrOE6RsKyU8OtWULP4
         rbMjgyE8AL/rPY7Sxe5PlylhulojeITZgBlCAUN1fD9AYPShvUTV3vpgpIdUNzxrZDuz
         UWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dpq2jd5nmzdPBxLx2tXJQXsCy3Tj/t5W3K7mDTr0mRA=;
        b=0f9vvzbfFyqM0L98DRAa1m/9dfjCsRZQMDGk2UBlLWrESCrGciTlMN7A/yQ8WRA7UK
         O0gb2cWgwf+TDdpUpPpfw3yadSnLgS/J7LRMl3esRpE2a0fxdTm+Dv676QQDLgbEGL0J
         Cq2ep96AaEnFhZVVD0NBuBLbuU6ZY7/4AvkJqhPDu7o5X4sfCwl72P/HVJLFwmVSciSO
         /h1PH08ulrDz6GKD6pidJNXFOHiGvrM1DRPv6qshCMzhvA0tZs81L9UT+S7dH44rQmjD
         tQhNqXAmVzUc4s4rAtMkh/TbqdtZ0VNV+DTO5sY1kTabKkV/evazpglBhltpj1Y9xFOt
         dwwg==
X-Gm-Message-State: AOAM530VTKI55/omeyApPXdk0c7azXd0X1+pTcQDhprWDf3x6Ol8TI5v
        cBUqB6/j9t8xvtZk6+UA5oU=
X-Google-Smtp-Source: ABdhPJw7TrZDmVqj0LeEGjx3ITiP3HqPpbBotW11n2lnXv64Cc62Cb792fcZnNvgCutVVrheuog0iw==
X-Received: by 2002:a17:90b:1e47:b0:1bf:6d79:b1fd with SMTP id pi7-20020a17090b1e4700b001bf6d79b1fdmr35927360pjb.49.1647256734337;
        Mon, 14 Mar 2022 04:18:54 -0700 (PDT)
Received: from [192.168.1.102] ([45.250.64.116])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090ab38400b001bf9519fe8bsm20757369pjr.38.2022.03.14.04.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 04:18:53 -0700 (PDT)
Message-ID: <85279e7c-bc63-5ee0-0a4b-443b4b1a87c9@gmail.com>
Date:   Mon, 14 Mar 2022 16:48:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 const keyword Warning found by checkpatch.pl script.
Content-Language: en-US
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20220312204128.3942-1-shaikhkamal2012@gmail.com>
 <19a139d0dde6fadfce79c10d40c9810b50702fb1.camel@perches.com>
From:   shaikh kamaluddin <shaikhkamal2012@gmail.com>
In-Reply-To: <19a139d0dde6fadfce79c10d40c9810b50702fb1.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/2022 2:57 AM, Joe Perches wrote:
> On Sun, 2022-03-13 at 03:11 +0530, shaikh kamal wrote:
> []
>> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> []
>> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>>   
>>   static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>>   {
>> -	static struct file_operations vmfile_fops;
>> +	static const struct file_operations vmfile_fops;
> 
> Make sure to compile any files modified by your suggested patches
> _before_ sending the patches.
> 
> 

Thanks for your suggestion, Kernel build is failing.
