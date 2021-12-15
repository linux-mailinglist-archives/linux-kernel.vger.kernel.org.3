Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D421D4764FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhLOVw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLOVw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:52:58 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D760C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:52:58 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id m9so32473642iop.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I85U/lcBLUoO2SybcOVTVuJK1q6E27R1PuawdPjLrS8=;
        b=AL0l6kIyoKbN2rrXxNKOjkWz21L/VXhPsjeoLnNSsFcVfiMYm5Ryf365Kuxg/TuGJf
         7SkNXHdeUBYcqLA67Av3XJVZPm7AXR4WG8K9alt6z1K1RsYybm34opVNXDkiGHylA8g7
         MsVO/OHUbuWBpLaNON63XAKtxB0JLUJQZw24E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I85U/lcBLUoO2SybcOVTVuJK1q6E27R1PuawdPjLrS8=;
        b=ztDxgsoc33O2qpX1695siQh3fstO4pxWqHYpRyxhAWm6sFWug6+drOlFOtQA/2DPnz
         7UoldrNNrT+Jz+fud2aF0EYacKw/rz1Uj5v1ekc1ar7+AQ2otaylYqgTSrORIbXSq0E8
         Gog5VtiY5zTAoYuzvD6cmdR2eg1odedr/vSeMtBXYnvl7PleT51kWWkikDBtP+q5YC+s
         JmMMTyGYUzx704wZnGuHffFXm7SKUt3FnmGyCf21xmLcLR8zxklsUle3OfkbNQ4xaFoA
         IJ1dV+caph6PVEuLBTJMpepTxCaLg7iJi0TztJ0SSnFk9QyPh2rvhoF303xpohWGXp75
         EXsg==
X-Gm-Message-State: AOAM5317hBA5cD9JJPiN19SJl1e7toWHqqlzGkvS/rQY5BcPVod0M409
        d7fyi9r2n7k1aVMq9sRZF7xRrA==
X-Google-Smtp-Source: ABdhPJzMQZ7/bdZ08n1EdxxzUbuDR8YXwT4G8+Y2DiiQwRlJxcsinQAI+vtCXa9S7UGtCL7zyCm1RA==
X-Received: by 2002:a05:6638:378e:: with SMTP id w14mr7254630jal.219.1639605176323;
        Wed, 15 Dec 2021 13:52:56 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o7sm1490512ilo.15.2021.12.15.13.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 13:52:56 -0800 (PST)
Subject: Re: [PATCH 5.4 00/18] 5.4.166-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211215172022.795825673@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <138ede2a-fae3-e33a-ab6b-564ce578af43@linuxfoundation.org>
Date:   Wed, 15 Dec 2021 14:52:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211215172022.795825673@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 10:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.166 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Dec 2021 17:20:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.166-rc1.gz
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

