Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE474BEB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiBUSvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:51:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiBUStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:49:06 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696DFD87
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:48:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vz16so35641133ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vrA7knS+1mH335VFNHAwLVaOZ0ABUiEx8O7DVSOsX/s=;
        b=nXiGzwnFJcabMOTlYk5USDFPUydtGqYwR8cUqnO2d/7zYnhGtWg8xS8uaxL88YCk9+
         egKGQUy+wqdntUqlnOiJxAvSIVvufLAY+c+B0n0EZx1+BQ5mMlHL3GBM8Pu7c9D9v1RI
         e29ubqi7say0HZM7Qc4TmbBfXT4kN/lz0GidnZmIhIjLWCerpvwjoL2jmmMCzvCwMnGh
         7I4BDdTso5G1XLz1/I5RGiDMNxzl0m45PnGuxeTN/ypUmDsa1CHYJFi4UePPgbYOGhnk
         +WoMkMBuK0gLtGlyYgx4YEHagOaAgkctLL1hwY9rMIPYwKxFvmFbq+Nh1142sgcJgmTc
         gjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vrA7knS+1mH335VFNHAwLVaOZ0ABUiEx8O7DVSOsX/s=;
        b=hocStsmtFlv/C+rMqDymRn2pvA0klotpGdPg6bj25aTT+uK0F2Q/Vb5f1qVBFjGiBV
         MVkJCYtj4SO07X+/sRyPsI8wz6t+/bkk+e5IT0SptPa+2TYXiJgGX7k2TKGnqa+rw05M
         J37xwrdz5KowwFhwJtf/H9+xVSgEZtP6pN/NeSm8bH4DXkXbs5BMoEb5ler/5GFaUoHK
         mjMKd9RQCV+Fd1vs5mJPJqCUnbVLfuR1PD7YAPhWUGojN3swMEd55a8t5dwpOzW7aV5C
         /CKfNLkdWeUJj5nM59FoNi2YDliu/gjqdpg+I6N3+rgPNJXxWZdjFWnsdLH64n3Yh7VZ
         m1fg==
X-Gm-Message-State: AOAM530F+7E8/urcEhm0u3j9EOWM+W7QM2NjM3LLyiH9Ojnq2QRssfqG
        L+b6OPrJdXbhFnw95OpKBZE=
X-Google-Smtp-Source: ABdhPJzwj+WUqtLBnZx/7AVxQv1trxO08byXV7PaSlvqNfgaiXgyKzDN/XWpOU4TziEy1iaC3bPmCQ==
X-Received: by 2002:a17:906:4ad6:b0:6b8:33e5:c3a1 with SMTP id u22-20020a1709064ad600b006b833e5c3a1mr16916742ejt.472.1645469303934;
        Mon, 21 Feb 2022 10:48:23 -0800 (PST)
Received: from [192.168.0.253] (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id p4sm5431949ejm.47.2022.02.21.10.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 10:48:23 -0800 (PST)
Message-ID: <fc8e4d44-fa64-f8bf-a442-87c1437978fa@gmail.com>
Date:   Mon, 21 Feb 2022 19:48:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/5] staging: r8188eu: odm cleanups
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220221073306.16636-1-straube.linux@gmail.com>
 <YhPIOp/k/u9GUv73@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YhPIOp/k/u9GUv73@kroah.com>
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

On 2/21/22 18:13, Greg KH wrote:
> On Mon, Feb 21, 2022 at 08:33:01AM +0100, Michael Straube wrote:
>> This set removes two more functions from the unwanted hal/odm layer.
>> Tested on x86_64 with Inter-Tech DMG-02.
>>
>> v2:
>> Fixed a typo in the commit message of patch 2/5.
>> unsed -> used
>>
>> Michael Straube (5):
>>    staging: r8188eu: remove ODM_CmnInfoHook()
>>    staging: r8188eu: convert two u8 variables to bool
>>    staging: r8188eu: remove enum odm_bw
>>    staging: r8188eu: convert type of pBandWidth in odm_dm_struct
>>    staging: r8188eu: remove ODM_CmnInfoUpdate()
>>
>>   drivers/staging/r8188eu/hal/odm.c             | 56 +------------------
>>   drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 19 ++++---
>>   drivers/staging/r8188eu/include/odm.h         | 29 +---------
>>   drivers/staging/r8188eu/include/rtw_mlme.h    |  2 +-
>>   drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 +-
>>   5 files changed, 16 insertions(+), 92 deletions(-)
>>
>> -- 
>> 2.35.1
>>
>>
> 
> This patch series does not apply to my tree.  Please rebase and resend.
> 

Hi Greg,

looks like you already applied v1 of this series.
The only change in v2 was fixing a typo in a commit message..

regards,

Michael


