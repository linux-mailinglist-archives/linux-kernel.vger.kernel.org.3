Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897724A6525
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiBATqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiBATql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:46:41 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E50EC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:46:41 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r144so22591704iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=shWzrMOdzXk8dl6SzVhCHa0A4LhonoVByHBdkG2UtXU=;
        b=L2iPu7KHT5U3KiH3kV6Fpbak6OEdL4ghq3fdLNC5DK2NbdUMdugEAmICmHQ6tY0zZQ
         0CeWkWrnZ8+u6CxznmwUbQXtmcsYvogFchevImPiZjLE/kFIgRiNWdPnqRzEVybW6CGc
         dwwVqWMMe2ZubGNKQlOJTIS2V0Q1Vovcm4c0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=shWzrMOdzXk8dl6SzVhCHa0A4LhonoVByHBdkG2UtXU=;
        b=mrZGSGY7l5nIDuJi/Z7An7zADrW7k3SBJZZ3GvD52MW0+Jh8e0gFmdZVyDsKUMfkxf
         R4OQ963Kwht4rmlL/VAke0DwvNq5AHXOshVvdgatm6v8dRScrAA3jr7GPfkCzB7E3G+I
         o/C9uqc+9t0KkocMln1ER4rnP+5zX0otFWL7m/d1foFsc3lotLfIqHpmsHloxhRF/FrS
         IOhCb/MqStSyolT+CPOZjqZjZsBZ+QLPHq9RELdL+H35ma8DGzlc1FBRaShCTav0ej/x
         kRc0YOhxZUntED3Jkh1rKywI6VViQaVEaWKaaTQ4z8hzf9vtCrdXTBKjWEzqLWDwX8qA
         KQdw==
X-Gm-Message-State: AOAM5303gWC4v309fp6fXzskBXQFGwNdnFXLcN0ZncfTv00eID/1xVt4
        QhXEFP/Nxxn8xJaXltvxKERVbQ==
X-Google-Smtp-Source: ABdhPJyKVFhZsu9u898JQhGfmjZGmzxEdox5fSdXSRy3JQnXw0uQuHDsI+blU6tX3DrGjlTpABPqbw==
X-Received: by 2002:a02:b10e:: with SMTP id r14mr13984036jah.226.1643744800937;
        Tue, 01 Feb 2022 11:46:40 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id f4sm7766091iow.53.2022.02.01.11.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 11:46:40 -0800 (PST)
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
Message-ID: <8ef32c1a-2123-522a-bb65-9e421fe07a7e@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 12:46:36 -0700
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

Couldn't find the patch. Didn't get pushed perhaps.

thanks,
-- Shuah
  



