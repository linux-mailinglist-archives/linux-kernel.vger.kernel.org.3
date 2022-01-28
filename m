Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFAD49F061
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbiA1BQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbiA1BQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:16:14 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDFCC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:16:14 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id w5so4123019ilo.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T4r9iQpNnfhtQz4g7pFa2za97cn7ajU/3XoHIUu+lPE=;
        b=TI91/viVRDSa2GzChdvOf5Fdm36rJ2jhQCVr6iZuSePRH+bEegn6LNewQkTKyNfldm
         +LzyO3p5HlNDMBnjBzsIvxc5aD1YmBKXfLLStR4S4VOEI7PLqTCUeIrDTZNkt9CFZYTF
         1rQsNFSpaUUXwkwbfX+z339/W8MC9Tm1tbC/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T4r9iQpNnfhtQz4g7pFa2za97cn7ajU/3XoHIUu+lPE=;
        b=ax11msfA8jKGhoPi1qUlsPPAfoOTRnvpecDPt1VGirZDcMyTUZx1vuOiAj2bjWdoQ9
         XXz/p/XT7eMB9/ICVopoYKruQbHUOuQVdsaAbdimV2sxXG7/Ly1SRjFTZwqy7vezTjIf
         aDgmovSlHs1SM6e6mRJ66rRl+CX+UW6jIdlGDQQsrQH8asRrQudQPIR5sNd8d1He7l29
         CXNXH+ORwUkGWt+IjxqXYGZErNnG3zvsNn1ZcYo+uSDJhNwEphdwLsz2abcK6LzyEM5K
         LNO2/YaJi/CbOhbrI4PpzhKe+v9jn9yzRxPuxx6YNnaAWxMNYnBdHrrI0MAFkUZHnnvt
         uIFA==
X-Gm-Message-State: AOAM530EaG0l6DX6pTlQgYHrdj7JjlyzzLzD8ThuT2yXHsqc11joGLuU
        frYWhowKBPzNZPwY+Y/zNZJdCfOTVn2GyA==
X-Google-Smtp-Source: ABdhPJzg84tFWAHR0QQicrZgmq199Uga055enEO10P2wR3eJIBI0c6KYGb2Yk6IJOCb1BBHpIpoD3g==
X-Received: by 2002:a92:1901:: with SMTP id 1mr4182176ilz.70.1643332574115;
        Thu, 27 Jan 2022 17:16:14 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id x13sm11982992ilu.0.2022.01.27.17.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 17:16:13 -0800 (PST)
Subject: Re: [PATCH 5.16 0/9] 5.16.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220127180258.892788582@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8499e17b-ab2f-7ac0-4a79-f9370d6a88eb@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 18:16:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220127180258.892788582@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 11:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.4 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Jan 2022 18:02:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
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
