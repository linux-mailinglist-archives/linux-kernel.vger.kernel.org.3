Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FC4D3B00
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiCIU0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiCIU0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:26:30 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F91C133
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:25:30 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id x4so4099527iom.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1XpTtFRyRBp8OjWhCm/MZGVaucnEvplhfd/lfZENsRc=;
        b=FFgTN+ZlkuPN4lQETJ5WTsJhZvWqPRMFJy/6B3Lqg0bgBfsysxvO9kfQ1/vOLyIv3p
         EDE7T9nadlXRohjxcfJPbrgZwjnNqWHDQ8JYRm7VnOK2TYlYclUBv8sfoY0gLkUdRs5K
         rpYWFMcblwrLXUEc8MLeXv7zrPcgvIo5/3VmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1XpTtFRyRBp8OjWhCm/MZGVaucnEvplhfd/lfZENsRc=;
        b=SDhf4qXXnveMxbgYCR1gg5MSISX9QLo1+ROSQNWoA6xirxrx6y9nuyrLUOAiX9jZk0
         svxohOG7IIb06vf6PnJ2DSf04TPBrtERw5GNWoKE/6J04XarhOFM6vjq2fzue/GcN0fG
         EvF4Dn2RsFbCRr5SMrdgoQAOPtoaE6vHIHpSIs9+gNNZcXrSRqFtiCc1HEpvgL+8Ysl9
         homSKZEqfi60z/tKHhQnWSf99jwClpM0LjDzKH+efuqawKewstI/HmcqzScFYow+VGx3
         Bcr1ehxpn/ZtKU+4MYX48Ksq7tuMcRVD4dn10xYvHrwomfDs8rAz01fh04jW4R8CTutK
         1WcQ==
X-Gm-Message-State: AOAM533fCPm3XyEHsQ9YUFjkROcOSbEK9ccyEZvrEa1nH+J3CGWA1XrZ
        FVOYpOH95GQT9Q4wS/jsdY+Qvg==
X-Google-Smtp-Source: ABdhPJyRaFN0D2zzyCfVq1M6oFEgS6+YAPCfYxjJlOH+h+E4PJxSAPZVpfXMI+w5RHMX1gN2Li7hkw==
X-Received: by 2002:a05:6638:2388:b0:314:1ec0:b012 with SMTP id q8-20020a056638238800b003141ec0b012mr1069604jat.224.1646857530362;
        Wed, 09 Mar 2022 12:25:30 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e21-20020a5d9255000000b0064160848e5dsm1510296iol.52.2022.03.09.12.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:25:30 -0800 (PST)
Subject: Re: [PATCH 4.19 00/18] 4.19.234-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220309155856.155540075@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e33dd043-a9d3-8cb5-5f2b-90843b342ab3@linuxfoundation.org>
Date:   Wed, 9 Mar 2022 13:25:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220309155856.155540075@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 8:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.234 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Mar 2022 15:58:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.234-rc1.gz
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
