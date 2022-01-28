Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43FC49F06E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344926AbiA1BSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344844AbiA1BSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:18:15 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B75CC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:18:15 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y84so5997890iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+H8wunlB+KMk8hGvmRPlou3cT/3wS0qqCOwk8Ymz0WE=;
        b=bAv0jAWRkzrTYSlXSdV4KVNd27JcVSTIRXvT7qk2OQNnea6bkcs1PU+xswBUrNBVEq
         bXhsF4a4wRa4dO5D7P4duA+a1r9NCZMQ0OA72oINrd/xzLqRol2BTGLHVWwGbBAdArad
         MIb0kcNtoaKwNUDkvWUEoaU8lV4G6NmZiSCW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+H8wunlB+KMk8hGvmRPlou3cT/3wS0qqCOwk8Ymz0WE=;
        b=o7h2g8k+ji7JXuXkN7jSpBg0ZkXJMySVDh+iNxB5O4Ph3F5/mDtsljT4A8RmdKk7VW
         uTyG5X1jfpox9cBOdNg5gSFXDjp1bF2OUJtY4fKTn1dNpODgXqMqcQ6cd9Uwpd0NEjcM
         oJnWIEpn7afmAj6EsyO4g9xiOscqtVcIr9tFfai3ikMllaw8srPm7te2i8fYAwT9gbU3
         WCgsYF63dPZ6rFH8E+ki1i9zrp4DEgXPMutgmmG7ELPm3NvL7oERlh2NisunRqK6K6Zk
         wwvCANT5+3DiTW2urRgyYvkVQS1B4IEaSs1pwLyJYq+5EUsIHGQV9/YrhlP3a/bdxzpx
         Lx2g==
X-Gm-Message-State: AOAM532YLgb8USJOoV+4npEM/vIFezZU6VuHIUfW7FuMYgipfSo5B0RU
        qkgGSCMPt6kp5IDSgAiWkDfDAw==
X-Google-Smtp-Source: ABdhPJzQYB/05ONpKodLeAhuBndT5CNVxmKA6r0wz/efS9gi78L+ktDemEjnzd7RjFaGeSRq7dlSUQ==
X-Received: by 2002:a5e:dd41:: with SMTP id u1mr3780676iop.217.1643332694748;
        Thu, 27 Jan 2022 17:18:14 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k5sm2829589ilr.7.2022.01.27.17.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 17:18:14 -0800 (PST)
Subject: Re: [PATCH 4.19 0/3] 4.19.227-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220127180256.837257619@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f782f224-e670-80ce-7b9f-24ebcd116cca@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 18:18:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220127180256.837257619@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 11:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.227 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Jan 2022 18:02:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.227-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
