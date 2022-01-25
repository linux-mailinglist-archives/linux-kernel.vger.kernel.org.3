Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F0549BFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiAYXjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiAYXjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:39:44 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB9C061747
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:39:44 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e79so25641006iof.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3EGAwwEJ1UFzCDVb++WP09dEeEE8cQffQQY/gexv+tw=;
        b=Qae0ZTtqjocmY0Ravf5tq6h8wF8LGSOwgVdIsQeW+atXcVBL7ij5nxtNqYBRJs+mML
         0G42t7d1SA3+ZKDAb9blJK1jggBfu1thzmapEH+kYO0VvTGNCsw1yM3+pPXZac/Qt6v4
         a0DVYlThxayvdUm7QhLesXrDF3yLnijz7nTEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3EGAwwEJ1UFzCDVb++WP09dEeEE8cQffQQY/gexv+tw=;
        b=Xb/3OcawdhgiHmdDVV2k9jcGQ1QnZXLAsy/bGVD0b5ngLmXRNspMLni+2RUGTGHTV9
         HTONh1IxG5H4+sTcqPfr6tezJZ0UoHdpqA1sL7L5mzcBkHlxoPLqRMjbJitVY+/j+s+A
         /YsuoWELemEkmU4EjDeMDN+LnxegBeWORTS2fB6bALWKsSJy/AY3rhd5669xV/60QSfP
         sD1xc1FhCQL/sczduWyWxxhMCkWf86MYlGA9zs2uE99GVzbw+FUDjdmeRbFvYz9UYbLP
         NDVYdB6FGUAQ1VjGIqv4QOMpJOijeWmAILo/ozVg5WVBmBIxiz7L7YR98o2WOptpwVrU
         RToA==
X-Gm-Message-State: AOAM531iJsb9gA2hLBeKgDCeXsw61j7cvJLI/ROxOjD4DBCrjXbKsAxa
        bXluNgsAtaVfC2QUtXncQdlggw==
X-Google-Smtp-Source: ABdhPJx+r3KufkOqCDwgWoIEMdDUZvZOUwJZIWuUXZno6vmkS0bEKKvB96shjxxwL7qyzVnI8MWtHA==
X-Received: by 2002:a02:7b1b:: with SMTP id q27mr6030853jac.27.1643153983448;
        Tue, 25 Jan 2022 15:39:43 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id u26sm3697804ior.52.2022.01.25.15.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 15:39:43 -0800 (PST)
Subject: Re: [PATCH 5.16 0000/1033] 5.16.3-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220125155447.179130255@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b89ab685-41fa-c78b-b0fc-bbf90b33b01f@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 16:39:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220125155447.179130255@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 9:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.3 release.
> There are 1033 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jan 2022 15:52:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.3-rc2.gz
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
