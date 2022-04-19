Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C595060B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiDSAL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbiDSALP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:11:15 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C852E684
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:08:34 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d4so9518851iln.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lNAzY2P4qoSpqq5MpVpIsyS8FHHxIlJ7xvjtmQYAUQ8=;
        b=Fda8jXobiStro7ccCKgwd2kdhD1Zkl5pWRc6Y4HRg4iFVLlZqL/vF+SA7RfAfrKfl/
         Jag/VCP9RkpbnNAcN57QXpccxsajBlBErwZ3qMrGNtU68riNEMnmxcR2AV60hakWTlK3
         iwibyBVBsdkDx8f8iRIhLpeTPVgT+GWvPkpFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lNAzY2P4qoSpqq5MpVpIsyS8FHHxIlJ7xvjtmQYAUQ8=;
        b=pXyJX7pwDMQmLSaJ+pnyPdaBDwUqYx9AuSRf2Hiywk0miss+8Pue9Pugj0k620b+l/
         PxpuYTpPZSvGepKA/SP9OCjOPfOmYHpnxzH0Jrxzb3z99mc23+wX7pt52DZZwXbRt482
         uMAOp0P8KlhnvH0CP6+xTObXYLrNDWBHPS7hljkd6Gu7GX1MeviA2xmr7d5ST5E4djmp
         XmRsecXKn/yN84pcPutXIIysHZvNz5UoPKSzVJPAQuVg0MNGFQV9O1qHpkmVVSq0TnpK
         Rq3DzVZhlDLug0XECB6VejFvyjH+q9VHFfo9a1+hFEuQyGOlG2s+cFN36J1ItCTsEZst
         2YXA==
X-Gm-Message-State: AOAM532VaCFZEmRQuSVXSnh1RD9sIAjukhQkLqkeHPLq6jJdJMfdAmp8
        0FpSwX+iJgVcB1sRtn93QnlsqQ==
X-Google-Smtp-Source: ABdhPJxmE6xOqIq5H0DIcpdCJ8hj4dnDWfZdFoHGlGdJIw0Pbukk+MovEKFUPQqlU7esdtZlwsVSag==
X-Received: by 2002:a92:cac3:0:b0:2c9:a265:4cab with SMTP id m3-20020a92cac3000000b002c9a2654cabmr5682856ilq.241.1650326913759;
        Mon, 18 Apr 2022 17:08:33 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i11-20020a056e020d8b00b002c79690d56esm7932072ilj.10.2022.04.18.17.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:08:32 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/105] 5.10.112-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220418121145.140991388@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d723cdd1-32d4-a256-1267-5ed131eff983@linuxfoundation.org>
Date:   Mon, 18 Apr 2022 18:08:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220418121145.140991388@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 6:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.112 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Apr 2022 12:11:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.112-rc1.gz
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
