Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8247B61D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhLTXSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhLTXSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:18:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081BCC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:18:18 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id j6so7381886ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pox1RC5WSO1kXxEQqYY2EJ3dpzzFatAucKbW3L7gPAM=;
        b=R/Z/vIcayj1vP09PrYjV/ysdZNjKVc/Yf4ZqagAKw6OdIYJc4OJsfDzIwmhuCz16PT
         Br4e2N6t+8R1NaqDbCP4pa1CGwd5fP+x/28qn+5NdayJ4FMbKODllG2d2txmJDUBIFQb
         wNr6tcVpLDDTqixKBU7iydXIdQGM0suWq/aDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pox1RC5WSO1kXxEQqYY2EJ3dpzzFatAucKbW3L7gPAM=;
        b=e191G/J3XBX2u84CcR3D9NJrtF+rvzjm8CmKeQOEFiFVTHiSdaUJo88Oqf86TxKmRX
         vAL7/JIX6e3ywkk7stJ6KXuioD+Ipjto2OLCDLt6BRaYL82SQvUI95eLPxi/TJSHOvK1
         PN46De/bb1iW+eP4E9YCM7y+za5nC8FqyppzRHAPR+zSeHCCEQ75qihAQ8eMvoJ0L0h/
         nNZ3fsEOP7AnHdaZZfRXGRrufuVQbRkcCyX+MsTNDqQtln9iXaxvObO4SeDu9pDaRroW
         ZqMUc9IA1smmkHfNDFsYY0kVohjXhkx3O/4JgfaRvrtx3PvWAHb14cyO6FHkBvG1vUF/
         2vWw==
X-Gm-Message-State: AOAM533L6joDfkp2Gp3lqLYIFkQh46LSRlNLMeD9/9AItEWS9tXX+477
        FhhBpF1AcOCffFMXCViWXdaJIQ==
X-Google-Smtp-Source: ABdhPJx2Pvg+bub1Aj+HCxeK5dmr/EQfZba6CU4H0Kgd3CvdMOMUMFSdtPaxfT83UHyKytN0t/u6Gw==
X-Received: by 2002:a92:3608:: with SMTP id d8mr165096ila.322.1640042297442;
        Mon, 20 Dec 2021 15:18:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r1sm9196037ilo.38.2021.12.20.15.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 15:18:17 -0800 (PST)
Subject: Re: [PATCH 5.4 00/71] 5.4.168-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211220143025.683747691@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3d7b3466-164c-4f66-f423-032c9622f966@linuxfoundation.org>
Date:   Mon, 20 Dec 2021 16:18:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211220143025.683747691@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 7:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.168 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Dec 2021 14:30:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.168-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
