Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3F58422D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiG1Ova (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiG1Ov2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:51:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9227C5D0C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:51:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c185so2657961oia.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FrPSJfIUXBW1VaA/gZ9xkTwpWNsJzuC25QAAGkfH378=;
        b=bwuMMJjRKv5aroYf0Q2/p+CX6DvLsYFbKRSaxlKC0FrUSB2QmGkm78mabnmpWiCy/e
         tFfJ0JiYtj6k9RxFWz9M5Gs4XVsdRoRlqTFrQPhW1MT/GRd6+Isv28fh3qOqExrazt2Z
         pIrlgDYkwsIbqnMrhpXbIqXuvNydtdrkGCN+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FrPSJfIUXBW1VaA/gZ9xkTwpWNsJzuC25QAAGkfH378=;
        b=h7/zZYxe6P+m0FsdjygDURU0KDfnxK2FCASZgiWtSz2YRhV3G1RQcrufOaNHL71lmi
         AmEi0fgGSUvhShoLgKZJqhLWVNWCqcgN2A0IhF13eoYmMXElKldEtye1KTjx8X5pH6zh
         wRtWG4dSWmqVmPWc6ez1/QpNRYvrTE3SZ49yeRlY275Vd/7FBb0gMxadPOz4HDTeak/V
         4Lmo3vr3pzpVl6nnsUMSCHsRX3+Ce4CIzVbP4Qmn72bfSASnSGKWC+dedmVCEUrnOUFY
         FinibqAhydypG9BY1PmiHTFcKs51zqtkxJ0NQuIWq8Tt7QMZzCQzOrERuK6RtHmfkAT/
         UJpw==
X-Gm-Message-State: AJIora9v/2n25SvQ+Ls45Y08+QyaoizE3NPtVMS7vOoH8cgry8tBVFju
        ufRSotmsWhCVd8i82py4xiY5WA==
X-Google-Smtp-Source: AGRyM1suzPB2DZps2WrrfQwh3qI2p7pnrAYFGYOTE5iLwD+VQVRb/DQSQYk8rckUW9uzOFGvP6gpHg==
X-Received: by 2002:a05:6808:2107:b0:33a:85df:5be1 with SMTP id r7-20020a056808210700b0033a85df5be1mr4149933oiw.197.1659019885707;
        Thu, 28 Jul 2022 07:51:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q31-20020a056871081f00b0010d75440f41sm433425oap.45.2022.07.28.07.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 07:51:25 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/62] 4.19.254-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220727161004.175638564@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7b86f5a4-cbcf-aedb-7475-4a38d97cea9a@linuxfoundation.org>
Date:   Thu, 28 Jul 2022 08:51:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220727161004.175638564@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 10:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.254 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 29 Jul 2022 16:09:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.254-rc1.gz
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
