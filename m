Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB66E4943D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbiASX0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbiASX0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:26:14 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772FBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:26:14 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 192so248479pfz.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r1BrZMEuUDk+2sfXVctDN6hyPwNL/9n18gjgSpq5RYs=;
        b=QEfgfBiw9LyCRGvxE4oDjyAUOMjhA6PfbklcFCfNhp20IFa06NoxVVCzCx7QSp/tg7
         vPxqDAj3m8ct3vewn/VMcwziq1+ELXR3dVLqGKtHiK3wTU36w5rSlBQzZc0raRj0q+sr
         2cTGIEBsgfo2j8ngtuvCOAs3XmnVTRDdVqxlNBnohoofKjqXIQz6bs+mB+NWNoDIKZqB
         LHldT6k4UX0/cfXvE/zsjbIwomUbUqeU+s/iENxLkkpSM0as7nXvDBg6sh30/cpiNvyV
         2YSmHTQXgOyQBn6O1DhaLIbIQLw9sVJP7EFsCRpnUsOrPko55RmQKtems8enux2LVJq5
         BMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r1BrZMEuUDk+2sfXVctDN6hyPwNL/9n18gjgSpq5RYs=;
        b=tknglcFG+DHqWzbYc+P1IcVC3D0+zb0KHkAwbysqfvyK2IIPZlgK4nimj8mICBghJ6
         3lk2mjvZ6m9MyNfHv7/er+f40Lyol1cKztxXGvYk4PhzH7yhHvBayUkzUXrQfo+2rhB2
         YyN0J92UXiO1EqpQj4t6uStYGzI03mkuG/veyOwSQ466MKfSRm6AKav4WoOgxRFYUY0h
         LCPF1dSO0CxxBwRd2fWhJkLEOSkv7iwEnLCv8Choonr4KdKhEO2Ghw8MSHrtRYYxO5Ow
         MPYkL4RxT62dVFLq95/4svginbnG0V75Zf3WoPw4cTQMGQkzDnCb9jKGa9TER525G4Uw
         8H5g==
X-Gm-Message-State: AOAM530UH6tCAPw0UNghV59q0meVo873OR/WBhcBQ/hNg2Pmwd18dB2S
        wApvvOBUbRYaoeSGOUTGP18=
X-Google-Smtp-Source: ABdhPJzM9YC3NsLH8dRSatWaoVSYt3jJno/5D1/wga980c+lxNS6gIW/n2C6/rt0o79E47c7tp2CkA==
X-Received: by 2002:a63:b341:: with SMTP id x1mr29912496pgt.185.1642634773940;
        Wed, 19 Jan 2022 15:26:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c70sm646991pfc.139.2022.01.19.15.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 15:26:13 -0800 (PST)
Subject: Re: [PATCH 0/3] phy: phy-brcm-usb: Fixes for phy-brcm-usb driver
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211201180653.35097-1-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7cbb745e-8b95-1eed-0903-44070a112ec0@gmail.com>
Date:   Wed, 19 Jan 2022 15:26:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201180653.35097-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 12/1/21 10:06 AM, Al Cooper wrote:
> A few fixes for the phy-brcm-usb driver.
> 
> Al Cooper (3):
>   phy: usb: Leave some clocks running during suspend
>   usb: Add "wake on" functionality for newer Synopsis XHCI controllers
>   phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option

Are you able to pick up those patches? Thank you

> 
>  drivers/phy/broadcom/Kconfig                  |  3 +-
>  .../phy/broadcom/phy-brcm-usb-init-synopsys.c | 46 +++++++++++++++----
>  drivers/phy/broadcom/phy-brcm-usb.c           | 38 +++++++++++++++
>  3 files changed, 77 insertions(+), 10 deletions(-)
> 
> 
> base-commit: f080815fdb3e3cff5a004ca83b3815ac17ef71b1
> 


-- 
Florian
