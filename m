Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEEE48A35E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbiAJXBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345597AbiAJXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:01:48 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF5DC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:01:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h23so19784296iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dTGCVnG7125oZIurDw57TMj8iwbDNtjzXTfgD2OdzHM=;
        b=COdaRCGpOLMdqjtKvvQRCoJOxehIGt3QgfXv33bB/af31MaAaT3783vthrrMGE/xwN
         cbv13zqLmEGTGmoX2cEn+LKFINbkvQjz0oomUewhMCGI3Ffvz7+OXG+LK/p2CGK09Fjd
         tB8961fmKXL1QaK/ruwThlMVGV2dZokmxdDZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dTGCVnG7125oZIurDw57TMj8iwbDNtjzXTfgD2OdzHM=;
        b=CsH8esNySwVIqoHRT1ViuLVmjFJVclLvv0UZNnCGrhEJhP726EzXIeKnpns/X9Lep3
         YVmcjNlr1kRt43ZC/kfnOOZSD127U+MZKFTPvIO1GHrrYimY2bjLkx1+IV/DqOMOJavn
         ipQBIganO4IVW2USCxqxFGLKTF7tZAFIiDYu7PGJGt22l7064Gj6HpPUUz9Fw5XOMr28
         wkOxcLD7IREt4gFk979/asvUZICOTc5f7mF1IgHf2oRixv88tjuF0HUxXw6NvGUneb0G
         D9Z2pBhldy3IZNMbL0LS6eiXMZ5lSpWRIZ3AA/iFy8VJATEDEhzzCWR90WZdXCRaXObK
         lpmg==
X-Gm-Message-State: AOAM533YFM5PvvV1yZmmK0pUxcuzDo9yhX+Ud/9kTEVlntkXeJjpIlsZ
        0p4GWcsOeix4LCnezH2BCq+U8w==
X-Google-Smtp-Source: ABdhPJzqHoGFO5uF72WkDyq4mdn1E6JjNt2/Mdqkl8FEypSz02sc6ITFbsbmVDQZkrQiO+vjIQPQIg==
X-Received: by 2002:a5d:8d89:: with SMTP id b9mr887445ioj.205.1641855707418;
        Mon, 10 Jan 2022 15:01:47 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y8sm5023102ilu.72.2022.01.10.15.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 15:01:47 -0800 (PST)
Subject: Re: [PATCH 4.9 00/21] 4.9.297-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220110071812.806606886@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c8bf05c0-897c-1e51-df22-4c3b6c1c3ddb@linuxfoundation.org>
Date:   Mon, 10 Jan 2022 16:01:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220110071812.806606886@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 12:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.297 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Jan 2022 07:18:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.297-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
