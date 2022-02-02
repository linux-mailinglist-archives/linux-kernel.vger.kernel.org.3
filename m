Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84B44A7488
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345468AbiBBPXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345134AbiBBPX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:23:29 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4BC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:23:29 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id h7so25874318iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XFqlwHLzxsSkTu4EbLQcoHbn4CyjCcQeSmjOwD3D0b8=;
        b=KjTnQGPzCt0S96UuIiNaawuVsmZa9fYmRebjLuFamfRMalfj7glkboFmx2YQiVjxxi
         OFiyfetLE/KKL1YviKxiRuabpPFcUmMMwWrECiJfjImb8tCVUyU600HZGw/+E5Jg7ncm
         fQtaS1Gh6MWfhgntWc+BtgcMKLgRdFXik9aGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFqlwHLzxsSkTu4EbLQcoHbn4CyjCcQeSmjOwD3D0b8=;
        b=eeF5A2ecZVAOAihyjCXZaQ3B+is9ojn4q+pQVLbALGLwyKbwPMh3Z2r85jkjyV9PHq
         wh5PlAp+hbfcgT1q2xUlBQZ8uEk5aYC1bxEGYUlkPJ1lBAU0gg2JAdDONKcj651ZSd1c
         o5CpNLlmpdIQtah6iyBi4uToh8bxZm2o4rfFha33/k+UGuM6u3xUGNAZisoVnXF4qvBd
         vLFxM6MTDeSVcHEEYBSwPO3fBXxuKoLZ6XPW4BWUWcVxu0dX6dE6iyP4eRAVwjuCuFHu
         D2xTqpsqAM4Jg9CkjVJOWZA0c0XFK9z/WHOsnBPOnoj0AaSq3GRY9asA8H05UVsEivVT
         lLHQ==
X-Gm-Message-State: AOAM530gsHEOPBR0IHmfwWdmYRr6H72pADtDTUIIKDlYlsLv9HlEQWXY
        E38y7CO88gbXLEmJlUL4Q3nJuLNCz2QW+A==
X-Google-Smtp-Source: ABdhPJwDnQ5AYawUXmJEJT+iihMTgbH4Y5Qg1y5crUIqxFnZmWZ4x9zV9SU+rsirQ4wVe6B0oamhbg==
X-Received: by 2002:a02:aa0a:: with SMTP id r10mr9395203jam.246.1643815409098;
        Wed, 02 Feb 2022 07:23:29 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id z23sm15236046iol.11.2022.02.02.07.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 07:23:28 -0800 (PST)
Subject: Re: kselftest tree on kernelci.org
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <5fd1a35c-f84e-1c6a-4a3a-be76dda97ca3@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ece6ea91-c44b-0bea-c4a2-ec099fa94881@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 08:23:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5fd1a35c-f84e-1c6a-4a3a-be76dda97ca3@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On 2/2/22 6:32 AM, Guillaume Tucker wrote:
> Hi Shuah,
> 
> I've made this PR to start monitoring the "fixes" branch from the
> kselftest tree on kernelci.org:
> 
>    https://github.com/kernelci/kernelci-core/pull/998
> 

Thank you.

> While kselftest changes eventually land in linux-next, monitoring
> your tree directly means we can test it earlier and potentially
> enable more build variants or experimental tests.  Since
> kernelci.org also builds and runs some kselftests we're regularly
> finding issues and people are sending fixes for them.  See this
> recent story for example:
> 
>    https://twitter.com/kernelci/status/1488831497259921409
> 
> Keeping an eye on kselftest patches with kernelci.org means we
> can verify that fixes do what they're supposed to do with a much
> larger test coverage than what individual developers can do.
> We've been applying kselftest fixes on a branch managed by
> kernelci.org to verify them in the past, but having the actual
> kselftest tree part of the workflow would seem much better.
> 

Absolutely.

> There are several branches in your tree, while "fixes" seemed
> like the most useful one to pick I see there is also a "kernelci"
> branch too but it hasn't been updated for a while, reviving it
> could give you the possibility to test patches through
> kernelci.org before applying them on other branches that get
> pulled into linux-next and mainline.
> 

This branch was a topic branch specific for changes I made for
kernelci runs to be cleaner - I should delete this.

If you are looking for other branches to monitor in addition to
"fixes" branch, the following are the ones to add:

next (for the merge window), kunit (kunit changes slated for merge window),
kunit-fixes

> Many things could potentially be done with arbitrary builds and
> tests etc.  These are some initial suggestions.  How does this
> sound?

Sounds great to me. Since selftest patches flow through various
subsystem trees, having kernelci keep an eye is great. This would
be another pair of eyes in addition to occasional tests I run and
Linaro (LKTP) monitoring next.

How often do you send reports - I will watch out for them. Thanks
again for taking the initiative to add kselftest to kernelci.

thanks,
-- Shuah
