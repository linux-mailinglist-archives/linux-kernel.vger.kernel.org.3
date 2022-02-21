Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095FA4BECB8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiBUVjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:39:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiBUVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:39:45 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F122B3E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:39:21 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id s1-20020a056830148100b005acfdcb1f4bso8298364otq.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+F47GjWofK+D2yxzl8C/XVekcv94qlkF/gMnmdzkHDo=;
        b=aGtOIkoV6wtR7iRafXeFtqNGhrG/AxiknGXHkqhxxsQgFh4lveKgG5Py9Ef3gi56kZ
         jhy/Ehy/+du8oIeOPvf4qij4vvyVPY2aWhOhoNSIOSWXkUjZPmtLdACDA0EdMPDItHMO
         QLNXVeRKVXGcDM7C/N3jxaaj2WEK8EqS7Li2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+F47GjWofK+D2yxzl8C/XVekcv94qlkF/gMnmdzkHDo=;
        b=0V6y2U6EfEUZgAjV1O7z910q2GLboOcaOy8VACdoRxE7AVu0gXtvpI+BPo532fIPbI
         iK0lyuRmswSieMuKEkUl+/bAze0nQgDY0NAOwcrlIjR92ui/A9Hnaq9n25Q6ORG/PtWO
         LUQzOtY2NDSaLpbXkrfzD2rVLC1lgkT4eDtva/AN0HE6ATACmFmMsDNGNBi2rML/N8LJ
         9HULFyWCYtNWkD2k0RYbYc2K+ecCkBw3GIQj39OOlMErxWBueEs6PwGaiYf6Y9Yt0lSL
         zH9PAO0jMEFSX1wNPfKBS2RVBByBvJiltnHetwfn+XXLRcBEX9kOUdb4nVeU7KZ0dT0K
         bRig==
X-Gm-Message-State: AOAM530CjhLBTjONXpdOgISjsJ6XubySsmjhbrs8+ZDyua+vGNU9GQrF
        bQKCuRbbTKwKw6W1cNZoepZzEg==
X-Google-Smtp-Source: ABdhPJzvJzU/9J6gTidrRfk15ZKrTgFtPbJiXn+AqPNOuAWJZ/cXtID0+rCkOr0levDDJPStCYVtSQ==
X-Received: by 2002:a9d:ec2:0:b0:592:badf:cd7c with SMTP id 60-20020a9d0ec2000000b00592badfcd7cmr7170205otj.67.1645479560673;
        Mon, 21 Feb 2022 13:39:20 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e9sm4548706oos.19.2022.02.21.13.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 13:39:20 -0800 (PST)
Subject: Re: [PATCH 5.10 000/121] 5.10.102-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220221084921.147454846@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e28959fd-d836-900e-941d-0100b6e91620@linuxfoundation.org>
Date:   Mon, 21 Feb 2022 14:39:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220221084921.147454846@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 1:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.102 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Feb 2022 08:48:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.102-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
