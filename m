Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7824CB971
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiCCIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:45:58 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364815C9DA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:45:12 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r11so296617ioh.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DVg37NvL0FxxCIk/TWwqMGeq7ngn7lphNV2El16k5BU=;
        b=ehsoqOztK3ilWC3rju1xEzQIHlU4ZTvJFKi1eMiCRoXzmRKSWCMHQnR+0oTh0XORAO
         Y+nvOG6a67z3aXZmzChArJKvZjfdLYx+w6//BZwsV7q7tLqfuZ4/oqtMCKQM//uzCn+m
         14+fMxrAxaDicTQLqsGKjULIuZsVFmHjbcCjolw981NAJs6JMiXKhSt7vrQRnIcPDmrM
         w0TeUho+jLSKdkNm/ugrfexGzIZAnMzhclkHoDUaO+a5f4h1IPDsgrOtCvxjQKkNsUzf
         6Z6th5xYIkhKf0+OPnZyviAsdkRkd8tXmYJWutrnEo1q4BJFTj2iZOUvnh/FuxGcX7mv
         ffsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DVg37NvL0FxxCIk/TWwqMGeq7ngn7lphNV2El16k5BU=;
        b=3PVcirswfuRk9tg4NJFX+IuBUYMO9+IG69mT3KiURpWReI2TeUdTVyv0XpXjE0WxvE
         0d/bEtqQBvLRLg3KpZYw0GjuOXRijB3TWIm9JYz63GD5t/arz6Kk2BWn9oCRcNSKQGfc
         K/2w9+tRVEx+FXLOyhytq+FFFSco8hDO/Qif2cTpEQUVhThFLA1DnkXWzqkCsH6KhlLC
         9dHnqdsLIAHP6ij+hwSrFJWzxLGMLTgNM4y25NINlFEA3VKSzOzBM9UXcJvv6HEqFkPn
         cN0Izn947gdJNnm6jdwnczTx+kqe18lQEVZv5KqBFbhvk3Mph07lKVVWZ25feZNSfm5H
         wiDQ==
X-Gm-Message-State: AOAM532nFFwlcKh76HGhFcnv//G9oyYTKwxW26dGF9CuHzBppuFHAAx2
        yLTzFyqgmT/bAapjL22G5KO+rk3uEeQWKQ==
X-Google-Smtp-Source: ABdhPJwOY1F0aYW+UMy5atCtxyh2icFmbGf7b1ROvA7VrcGHdfj1BGMYA676JzwH/DmDo7/+adO/KA==
X-Received: by 2002:a6b:8ed2:0:b0:641:3d13:47ad with SMTP id q201-20020a6b8ed2000000b006413d1347admr26064004iod.168.1646297111698;
        Thu, 03 Mar 2022 00:45:11 -0800 (PST)
Received: from [192.168.1.46] (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id r3-20020a92ac03000000b002c3dfcb9a6csm1392073ilh.77.2022.03.03.00.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:45:11 -0800 (PST)
Message-ID: <4f3310b4-beab-9b5f-0cd4-f530559aa470@gmail.com>
Date:   Thu, 3 Mar 2022 16:45:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RESEND] samples/kobject: Use sysfs_emit instead of
 snprintf
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220302120759.380932-1-phind.uet@gmail.com>
 <Yh+EdGcsoF+lBjfX@kroah.com> <32164620-9ba6-db62-bc61-95c7f255d087@gmail.com>
 <Yh/SGeW1KPcbH4ob@kroah.com>
From:   Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <Yh/SGeW1KPcbH4ob@kroah.com>
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

On 3/3/2022 4:22 AM, Greg KH wrote:
> On Thu, Mar 03, 2022 at 02:11:36AM +0800, Phi Nguyen wrote:
>> On 3/2/2022 10:51 PM, Greg KH wrote:
>>> On Wed, Mar 02, 2022 at 08:07:59PM +0800, Nguyen Dinh Phi wrote:
>>>> Convert sprintf() to sysfs_emit() in order to check buffer overrun on sysfs
>>>> outputs.
>>>
>>> There are no such buffer overruns on these sysfs files.
>>>
>> I don't want to duplicate the title so I use the description of sysfs_emit()
>> as the patch message. I have just realized that the title is also incorrect,
>> sorry for my mistake.
>>
>>>>
>>>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>> ---
>>>>    samples/kobject/kobject-example.c | 4 ++--
>>>>    samples/kobject/kset-example.c    | 4 ++--
>>>>    2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> Why is this a resend?  What happened to the first version?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> There is no response for the first version. Actually, there is no Maintainer
>> is associated with these two files (in MAINTAINERS files), hence, my first
>> patch was only sent to the linux-kernel mailing list.
> 
> You need to give reviewers a hint as to what is going on when you do
> this, we can't read minds :)
> 
> thanks,
> 
> greg k-h
Hi Greg,

Am I right in thinking that you are the maintainer of these files? Can I 
send a patch to add an entry to /linux/MAINTAINERS file?

BR,
Phi.
