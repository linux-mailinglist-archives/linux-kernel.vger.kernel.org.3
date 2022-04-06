Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989E4F623E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiDFO4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiDFO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:56:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C496094BF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:33:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so3415902wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fPdHez+B9xoPsCLxTMUwgkfR7VF58WkxSxp727nYR84=;
        b=Y/+LPZSg+vNsnscHarNCJ1f3nTSOszz5+T3BfdFq5x+pnpbt+XeaR/NSPrDGbV+AEG
         B4zDr+b9lFWWfoOOaYcxpN+fEwi4zJs7cc7VPFVRN7sVuIWeyGiGikwd77cK1BzOAr9E
         G1pr39mzUUJmdv/IEwYsk3ErG1rbxZBxDDwSJZayzCljP5VmFGogxMKtHHPK0H7uVz7I
         rRS9MtIOfaUNrFLQc7hMIb5xLxC3tHsMo5ykghYk+kSOjdXt9hxIZyXQUIfQDot1Xw5V
         15gCmNYJEYu0TpoQNOZsTMbIDTtjAt1FcZ9Hbxi2UX9PpPfenumngwg3Allpm91rec6e
         GlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fPdHez+B9xoPsCLxTMUwgkfR7VF58WkxSxp727nYR84=;
        b=YKS9G0YZb1F67vfgWyqbiRcokODAf2g7I8I0CkSfZKr2xd6A26hceQ4t/kC1LMh5ud
         YWQ/H4ed6mBAIp1ZRLJi/e2CH76vbaqIJy9MCDR2xNEyO7hH04YkPM5Xhk/cNH7nmhA5
         HSZbG6adb35nueofqjvo/RdlWXv6DtCW8QONE//RS+s5wEwXpZIo7GfnWIVfkjzknrzQ
         bFNWj1bkMfhydNsBMsdroxrQc7UPe1AUIlcu43XD0ydxT+cmunKX+1Bc+ulBn7fNcVTb
         wND1Folly95vHRK2XnAqmJ/N7NU2Paa06s8khApagu5uQK3D4v1PtA1KbqNL1a5pw6Jv
         Pccw==
X-Gm-Message-State: AOAM532p96YHCvr/0T0UoUSKS6mOl91kXz+PmEcdVjBpsVi82eeDgCFx
        P+nVni0tUePZ3KSLgHaSh2p6Nw==
X-Google-Smtp-Source: ABdhPJy7Fs+DjI4SArLCSlh5kObPiWZ2Bb3VzRhcmspKhUdQfVlkRxkg83++z0XbiQwjiGew22KhdA==
X-Received: by 2002:a05:600c:1c94:b0:38e:7030:24cc with SMTP id k20-20020a05600c1c9400b0038e703024ccmr7102877wms.121.1649244771125;
        Wed, 06 Apr 2022 04:32:51 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:261f:c14c:d23b:d177? ([2a01:e34:ed2f:f020:261f:c14c:d23b:d177])
        by smtp.googlemail.com with ESMTPSA id a16-20020adfdd10000000b002060b4e240dsm10204682wrm.93.2022.04.06.04.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 04:32:49 -0700 (PDT)
Message-ID: <b9a53a99-55ac-3f23-c87c-9827dd76239b@linaro.org>
Date:   Wed, 6 Apr 2022 13:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v15 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
Content-Language: en-US
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
References: <20220310090048.1933020-1-laurent@vivier.eu>
 <20220310090048.1933020-5-laurent@vivier.eu>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220310090048.1933020-5-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 10:00, Laurent Vivier wrote:
> Add a clocksource based on the goldfish-rtc device.
> 
> Move the timer register definition to <clocksource/timer-goldfish.h>
> 
> This kernel implementation is based on the QEMU upstream implementation:
> 
>     https://git.qemu.org/?p=qemu.git;a=blob_plain;f=hw/rtc/goldfish_rtc.c
> 
> goldfish-timer is a high-precision signed 64-bit nanosecond timer.
> It is part of the 'goldfish' virtual hardware platform used to run
> some emulated Android systems under QEMU.
> This timer only supports oneshot event.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
