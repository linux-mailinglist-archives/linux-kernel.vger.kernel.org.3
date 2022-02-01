Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2164A67F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiBAWZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiBAWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:25:30 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B7DC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 14:25:30 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r144so23100629iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 14:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c8Z+kUcSrvdIy+j6TXlBvEfQwbtScvEizHt7CTGG+Vc=;
        b=EHKrzeWVuQgBl9KotjIHVVYlOaxRxsBpLSNVO4ZQ24Z7UPwPh0ttihxq7VOk7HsX/l
         92FFJtVP4VMSVqwiLTdQFsy1kggf9eHMZ0h3GSnvLRnmQGX9cMNLv4jGpd85IpAbI90q
         7GwDpVRWFckQgRlRbrVdzK3vVZuNNKRHwYmWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c8Z+kUcSrvdIy+j6TXlBvEfQwbtScvEizHt7CTGG+Vc=;
        b=hjJ7rvHfRJS/+US4sl4rXBX0xJD7LWXJhokqlTU6+cIIUqgka/ADpyKet9oiaE5g/H
         bCuoRhGZQkfuVLh51T0f+2pgC15SsFR+Intg6tA370oK8x2YC7FKvLfducSkLNLzPam8
         eqaPN4B1fCoHZElfwmV6Tfmq4Z50Ly+npPo2QRKQKu/QMgOmbrI9Vlau6JeZ9zhd45Hg
         Qdygl+Ro5b92o001KS/6A7OL0nYhDO5UbmtBylBNUsZW9p56H3rH1YC97ikz9zKwBKgI
         DqvH5OGp1iS/kaYRvw/RYcr6rtdntAu311AR7ihyqNdjnrKef6GMM3e9UoSTviTQZf0u
         tvMQ==
X-Gm-Message-State: AOAM533VCaShPXprLLPGlouGqdufh0sYoQpQDL+lgggiV3hEVijea+J5
        iWRnIniSE7GxPPShksvnwnEQzg==
X-Google-Smtp-Source: ABdhPJyn8BP8cf3LHaH8TbY6UXFt8VWWYEkwquI6sAfKK7mjg0onP3ECbKANYJIaIl5q8Uzx/4fkAQ==
X-Received: by 2002:a6b:8d16:: with SMTP id p22mr14961418iod.110.1643754329758;
        Tue, 01 Feb 2022 14:25:29 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e11sm15854991ioq.41.2022.02.01.14.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 14:25:29 -0800 (PST)
Subject: Re: [PATCH 4.4 00/25] 4.4.302-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220201180822.148370751@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0fb348da-ed05-8311-ce21-4f5c5d47fe9c@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 15:25:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220201180822.148370751@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 11:16 AM, Greg Kroah-Hartman wrote:
> NOTE!  This is the proposed LAST 4.4.y kernel release to happen under
> the rules of the normal stable kernel releases.  After this one, it will
> be marked End-Of-Life as it has been 6 years and you really should know
> better by now and have moved to a newer kernel tree.  After this one, no
> more security fixes will be backported and you will end up with an
> insecure system over time.
> 
> --------------------------
> 
> This is the start of the stable review cycle for the 4.4.302 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Feb 2022 18:08:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.302-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
