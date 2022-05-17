Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C04529886
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiEQEM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiEQEMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:12:09 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C994248E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:12:08 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-ee1e7362caso22770369fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TlJCMH2FdCNPLWx49l55pMqLQ3UABJUlfuAXOJuTElk=;
        b=C5oFYvzH8Ig5w+3POqaqd1r6m6neJ/5MesAzXzSXLZiDCGZm5XBQD9Z64UtjmSHTT8
         E1Bz4NShHu87UB5nBgqKH6frsBhQKF78/PU/i4MCpAv+tnj5ha91GJ+HnRDxkm8Hi3QA
         tjCZEkWlnrrS8Ev1x2rxU2wU8yzQIO4UW0Wrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TlJCMH2FdCNPLWx49l55pMqLQ3UABJUlfuAXOJuTElk=;
        b=8LDbdDx9LKM9/flOxeASCDJVW5E9CZPem6KAj4B/GE2ItaFd1BmEb+P3bc2qNggxkt
         2y+v1W+2mwgFqrpivG3EPLz9Z8mxQWb9aZOiipeGsRtRjhCyaHx9E7BKEssVjY1WSvoO
         cd0xSLztEOBjQjWhQyaTZ7lBBEpw6GfFolgHuHkfI0vfHqAmZCNPsmtASzh4eS7vH3vB
         vMKZ1dlUD9PnFG/mKsyFipxVavGCXNgY7zN8sOgP3GtVP5EODMHLgpUqjUsQPt1zEGZ0
         RXJxJB6wtqOcKfEqL5jBtWDotwbTUoSZGbLGgml8yGUiaRPLNiRwui6FWMfvWb5Fg1pw
         qPZA==
X-Gm-Message-State: AOAM53208kXlGV1lyCT3UhQ5tmJRmA6Ep4ZJG29HSyYR3FdwhdCCwZbF
        +1EliaI1rPTLCkLk8Q1Udrt9IA==
X-Google-Smtp-Source: ABdhPJxI+RAcT5/CDIXDyKfSB5VLBbSqlC/fd7gcYi6FeMRFCjsE60eO6g94NhgvYUtZtGJlO1zEfg==
X-Received: by 2002:a05:6870:5707:b0:de:2cb8:7759 with SMTP id k7-20020a056870570700b000de2cb87759mr17401197oap.20.1652760727342;
        Mon, 16 May 2022 21:12:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e45-20020a9d01b0000000b0060603221281sm4545449ote.81.2022.05.16.21.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 21:12:07 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/43] 5.4.195-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220516193614.714657361@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <857df26a-b357-eec0-c994-9086173a03ba@linuxfoundation.org>
Date:   Mon, 16 May 2022 22:12:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220516193614.714657361@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 1:36 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.195 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 May 2022 19:36:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.195-rc1.gz
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
