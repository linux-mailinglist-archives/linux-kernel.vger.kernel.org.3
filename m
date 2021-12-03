Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E67467F83
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383300AbhLCVvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383250AbhLCVvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:51:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868CFC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 13:48:11 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o29so3415635wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8U4LuV4nTWBRHMuVX5JcdO7RS1Lp3x1GY6HwFLoLa1o=;
        b=ixZPcTPlfySA5CLgeCs5+PMqZS7zZvGQIo8krngYbtprFmruMLtvCc3I1ctD5qtQj/
         s02vSmHKAhKO7yhi64NOqWmqbJNZQtb73CmGfDYkukfWvby7DPR1L2u83tjOSw8L/BbR
         KxVhFmfkki/lBvMW4+pmlJHEfz2smewpbkQxP5KFAZTddmwPgQK31E7sWyFaeSpckQ8X
         fm1Q/EnZa6Od+nHBatimTSfk9SjOTKSnRXP1GnEND+0Csqd6xbmVF9+OhPhhvn6WnluU
         vc2M6lBOwl5e97tO5ZvqeZCkvyZ/QldWvKhIkgm+I+EoauQaq/YmovQF+Pw9ZYypJBlY
         uHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8U4LuV4nTWBRHMuVX5JcdO7RS1Lp3x1GY6HwFLoLa1o=;
        b=p2vnZkx87pKXkDfSy/CY8Suvj8LfDapYOQkdeDS3bpr/GRZq6hOjg4S+If7MwkYrfL
         kdaK3xHa5KlfWGyl37E0A20J+XPwvli6ZEZnnV963hyQ85Nkj03x65FfUAk6arY5Xk7a
         FSR5D9+Ueb1ms/WxarkOGaDJFTAWTTWyWP9HAjA8Ml9xOd5V2TU/mH08/NKL08CVH7Ed
         jMC5pex7O/fuU/mfu1VNTbun7Ex4oZpKsoLAeiEWcMIJum5GU4Xagm9SfetYzml8z0Oc
         X95dckI8G+c8BLVGZc1m+wuaVM+VbctrAFBDGh7jpt/Ko910wfwGa59vmuLzd+o/PLKK
         oSCw==
X-Gm-Message-State: AOAM5337QEKrqRjRPwFC05s3KigQgdHE4wQIc8MkZK/XGKwXsubvTdtU
        iS8Gq+NGsrBB6AKqkjgjILkAbZJADSPLlQ==
X-Google-Smtp-Source: ABdhPJzU8wrfNhPs32jCMw44mRyRekp5WmNIfDLRTCZUyVz0EC6XhFbwb4nQaUrYdN11UgAJVoSBBA==
X-Received: by 2002:a1c:98ca:: with SMTP id a193mr18593537wme.162.1638568089728;
        Fri, 03 Dec 2021 13:48:09 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:98bf:72f4:f216:41dc? ([2a01:e34:ed2f:f020:98bf:72f4:f216:41dc])
        by smtp.googlemail.com with ESMTPSA id p14sm5901698wms.29.2021.12.03.13.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 13:48:09 -0800 (PST)
Subject: Re: Time: new clocksource
To:     Muni Sekhar <munisekharrms@gmail.com>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
References: <CAHhAz+jpmksehY4BSH9jJPYuY+jykSHtx9TNiG-gAkq10zaXSQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fe9dbf81-e060-36ab-b769-215af3d65ba7@linaro.org>
Date:   Fri, 3 Dec 2021 22:48:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHhAz+jpmksehY4BSH9jJPYuY+jykSHtx9TNiG-gAkq10zaXSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sekhar,

On 03/12/2021 17:50, Muni Sekhar wrote:
> Hi All,
> 
> We have a Digital PLL with 64 bit timer counter hardware and the
> counter is accessible from the CPU over the PCIe bus.
> 
> Is it possible to add this timer counter hardware as new clocksource
> driver? To do this, can someone please point me to the existing
> reference source code(or patch) for this task.

You can refer to the drivers located in drivers/clocksource

git annotate on one of the driver can give you the initial commit where
recent submissions explain the timer internals.

> Suppose if it is possible to add a new clocksource driver for this
> hardware then does any userspace get_timestamp* API would get the time
> from this new hardware?

It should if the timer is selected as the clocksource


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
