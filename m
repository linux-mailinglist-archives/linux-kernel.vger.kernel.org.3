Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9114691E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhLFJHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhLFJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:07:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83059C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 01:04:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x6so39817272edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 01:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lJwthijYuGWba0Z94MskwAYfq2plGY55scswf+uqwG8=;
        b=k5vkXyW8b2b6/NBeKUgtrtTU+vGuNBO07Fq5ytgg6gPkGuvRTXCOmLvHuWy40MeXt5
         kREzFuGaVrn0j83r+GmWjrJkXKz3OlyDlx+aDMhhri9PQlzn8HAhO+xF5hOtF4/a3duh
         RRi3bCSCiV7eJ3gfDVgaxcniOIDj4bazPP6543Lf6oK0XupWcVVypOHPm5ktJRv0OfCw
         +tvjJFROOFIEI76mLayCJ3NwCXaKMuLDop+t7Uv9YKnt88DwVeWEGHYyAmbIp4z5iKeR
         3T9ze/c1wBxEX7ewUDFXdu7LO5nmzzC1zHCZ0Vfu/tML2iSpdhHPVWHWr0XYjRyTl5h2
         kklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lJwthijYuGWba0Z94MskwAYfq2plGY55scswf+uqwG8=;
        b=gf6dsGYtff3oEnJwi2lioy+bogzodQ4obb0rjtAfhx78UHttNFvlV2Sb+nH/Ebkrvp
         7CY9LpTgYnIYJbBSGVW2OOqiuNvS1LOCmKQZgkl6KziWHBf8x15MWhSEdfEJ3dBfx4y/
         JUSKl8/PxPhcXOPmXjs72HYLGRJ8gO1RWrHXubQ6COLvBDiVuRmqTs2WT2frl5c6K65c
         JLljNJCT0yb8T8CL4PC7b0lR36cDSBZGJGcF6Comh4mn8ZDwvrJVgD0ZZgmPyjoAeV0y
         qdrKTAylr8jjWzL75lZV8XWJlj4dQqcNW0T/l09NBJ4/s1LtMM/CFupFdvQJsQXlt4Ay
         X9dw==
X-Gm-Message-State: AOAM530+yJVeriMbv5RqznDSDCNwmnPLGFgh0S/Zml672EUWMdwKyMBs
        MQzwhrAlayDY4PXgKVGSHjg=
X-Google-Smtp-Source: ABdhPJysagPMrpCS7O+5lSo5bnWjEPbQQtEWyISaeM2QGHgJZ4x2JDZu3x5ul5a7rfH81yySATqc6w==
X-Received: by 2002:a05:6402:350a:: with SMTP id b10mr52735233edd.184.1638781444987;
        Mon, 06 Dec 2021 01:04:04 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::b792? ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id c8sm7283291edu.60.2021.12.06.01.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 01:04:04 -0800 (PST)
Message-ID: <b23ab24a-3553-728a-010c-02b6644be266@gmail.com>
Date:   Mon, 6 Dec 2021 10:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 00/10] staging: r8188eu: some more cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211205151251.6861-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211205151251.6861-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/21 16:12, Martin Kaiser wrote:
> Here's another patch set with simple cleanups in different parts
> of the driver.
> 
> Martin Kaiser (10):
>    staging: r8188eu: bLedOpenDrain is always true for r8188eu
>    staging: r8188eu: remove a bunch of unused led defines
>    staging: r8188eu: remove two unused macros
>    staging: r8188eu: bHWPowerdown is set but not used
>    staging: r8188eu: remove unused macros from drv_types.h
>    staging: r8188eu: hal data's interfaceIndex is never read
>    staging: r8188eu: remove empty HAL_INIT_PROFILE_TAG macro
>    staging: r8188eu: remove two write-only wifi direct variables
>    staging: r8188eu: remove unused define
>    staging: r8188eu: AntCombination is always 2
> 
>   drivers/staging/r8188eu/core/rtw_p2p.c        |  3 --
>   drivers/staging/r8188eu/hal/odm_RTL8188E.c    | 41 ++++---------------
>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 10 +----
>   drivers/staging/r8188eu/hal/rtl8188eu_led.c   | 16 +++-----
>   drivers/staging/r8188eu/hal/usb_halinit.c     | 28 -------------
>   drivers/staging/r8188eu/include/drv_types.h   |  6 ---
>   .../staging/r8188eu/include/osdep_service.h   | 18 --------
>   .../staging/r8188eu/include/rtl8188e_hal.h    |  5 ---
>   drivers/staging/r8188eu/include/rtw_led.h     | 32 ---------------
>   drivers/staging/r8188eu/include/rtw_mlme.h    | 12 ------
>   drivers/staging/r8188eu/include/rtw_pwrctrl.h |  1 -
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  2 -
>   12 files changed, 15 insertions(+), 159 deletions(-)
> 

For all patches:

Acked-by: Michael Straube <straube.linux@gmail.com>
