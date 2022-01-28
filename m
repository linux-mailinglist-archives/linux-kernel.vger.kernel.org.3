Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC99349F071
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbiA1BSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344973AbiA1BSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:18:43 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2FAC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:18:43 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o10so4159959ilh.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zm6jt3p11fiox9NrW6k7kY90d5jZ78UTNU+uKIg6j4Y=;
        b=aSN+oUgXq0WlQr09++7wQ1ENyNZDwzHSE6Nb9MBgflSrqloXWXa7aA2+yJSJCJTdcW
         PvavYP0uqpRq+wL8al/95VctYfCSq/lgLnDBXxyDacVpfH5+EHmrLtwg72ZaY6XJZj44
         zZ5p7P66suif3S3vf7d5/0ORL0znu+Fub7MGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zm6jt3p11fiox9NrW6k7kY90d5jZ78UTNU+uKIg6j4Y=;
        b=IXXP+dBi3AZthn/TY5OnYNwHFBL/q1NijwfWO5vroLQuyGI6fmp3i+NE7dAeTz9OqB
         77/cucWURSZ5lJNl6Ex0zp1RoBojlubhdrnv0C1KVxuG3uw51Z9tQXD55g3zStAas6Sh
         arzsxmns/nDtC/OIMrRPk8VVJnFeD8BpWuwEZBkZUkknQtMX2/s4U0C1yxstJV55lVwV
         BoaL3ux7ElF6/lYBvM9PcySE8kWxGRV/QL5PVm4b7k5y6FQAlZek5AUS9IszJD9CcY5P
         VHQ90qAvTueBOLvz3xc0boqfYZHqpQm6RKj2FuUYMkAgDj9sK/8xdOGLQ1TcFZNmJJkd
         HD6Q==
X-Gm-Message-State: AOAM532uvFmwk81bpQYR7LLRV9DvTZwE0NkxEZI4RUPqQjko44B8d46U
        0AJtGq94C1N/dRnsuNMOCxnsaA==
X-Google-Smtp-Source: ABdhPJz2LqRWJuJrMba4WnHk5L/Msh/A5Ow0X8uEe+Z94NUPwZmU+XQODKdyivToEYVnT7ouXvJc7w==
X-Received: by 2002:a92:8e0d:: with SMTP id c13mr4261818ild.159.1643332723010;
        Thu, 27 Jan 2022 17:18:43 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b11sm12802760ilr.51.2022.01.27.17.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 17:18:42 -0800 (PST)
Subject: Re: [PATCH 4.9 0/9] 4.9.299-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220127180257.225641300@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ca4a9161-7d70-46ca-adff-fa002f63d829@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 18:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220127180257.225641300@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 11:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.299 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Jan 2022 18:02:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.299-rc1.gz
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
