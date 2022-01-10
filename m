Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0F48A34D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbiAJW5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbiAJW5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:57:44 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49BFC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:57:44 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e8so12784070ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=olwjzzolkxTZm6VoWqPk/AeFvkT22BoZEg2TAOI6eFE=;
        b=aYlJzOla5lf6n2hsOcoQt0qkmbz0fribuscBOwZAWabXqODKR6KnSDSZVxAF6Z+vxQ
         R7SYoSxbFl6ARYuqvdDxilArVfzGf6HlS9pdFXRsybtwkoC6VYW2tdjg7WFovO7plfOK
         o71KmNMPwV2PkfmDv1X2daRfiFBC9Tk+z3tTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=olwjzzolkxTZm6VoWqPk/AeFvkT22BoZEg2TAOI6eFE=;
        b=2r/kl8MAkvhLLGjmv69Jsq1C3D3ilJaBh3njea5APvd2wy/YXOgL2Pf0YXxpe7ELKd
         jbgaJTI3KUelowwj+BvXO+WXF1r4Nn6pXyH6uwKzOk5sqBHnwQxRRwN6b53GN8tXjxYa
         9NcMt77BgdDkfx2KY9oUZKXZlM68jiBusH79OmRWASuYc0nuPmVKAv/UEBR/oF1BHwh4
         Pju8mIHFnIiDFIzphpHiiOfIDxH2JDjGO/KFNuVJp5BCkgn4GW4qU/oydsqYx6V8L+y8
         kLFNLY0SMD8HB2FB8lxGZ129LPQVVBrgfwuD/Cyh0bV6DGk/Y+JSV3lj7o1rinktCIeb
         tHVA==
X-Gm-Message-State: AOAM532YXRCj3b7u4v5VLjSVNSynQ7GY9TCaClGkQIYsrwmuDZ+xYgUo
        pVxr1nqv/6v+nCqNVRTbxy14CQ==
X-Google-Smtp-Source: ABdhPJzMrbZqD8dxBt5pa33XJyLG0UrH4oeHM4Fjvdki9nRSlulS2lsZz9dIsOJgwD2jTHmh0mv2RA==
X-Received: by 2002:a05:6e02:12c6:: with SMTP id i6mr1048477ilm.204.1641855464153;
        Mon, 10 Jan 2022 14:57:44 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm4976518ioo.36.2022.01.10.14.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 14:57:43 -0800 (PST)
Subject: Re: [PATCH 5.4 00/34] 5.4.171-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220110071815.647309738@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <de625b1e-7a9c-3953-d80f-379befa1736c@linuxfoundation.org>
Date:   Mon, 10 Jan 2022 15:57:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220110071815.647309738@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 12:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.171 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Jan 2022 07:18:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.171-rc1.gz
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
