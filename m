Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C46480B00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 16:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhL1PyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 10:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhL1PyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 10:54:10 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C72C061574;
        Tue, 28 Dec 2021 07:54:10 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso24821783otf.12;
        Tue, 28 Dec 2021 07:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ll7027buisW0NEWTSu1htpdHZWakTW3q/gcHMjuQDGI=;
        b=TcS6V3hxsa1YUx7s1/czOLg55PDca3cg6Akh8vcVgfcMj46CzLVlITBJMcoAzowHqU
         H0uCYAdMDg2omZQnU9IOZvhQOS4zNfR5dJwPNIndBBKktk5PRKuC7J5abvxwwvFKgC5J
         caO8Pw/u040StcnZYxj8ZGJWiAMEYO6vj+PtcMf3GYHPR6hZoGox9wZ3dLgwcIm/oMa2
         BeA9Nj7rddVhXUSfp+KpsrBzFw/cCkmKyxKvu18r6xvcefn4IbnMpmOU6dwckzKvA3Y5
         rRIr7gZ8R4sb4DGFCFiiUU+kcBO2PmlDDZbxRI2biQ/4F68DwOYt8b2my5XAyUy8ykFl
         Fm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ll7027buisW0NEWTSu1htpdHZWakTW3q/gcHMjuQDGI=;
        b=1Qiao5/F6OF097FEfJ0p4RERcfuKsPQazEn5Aa+cuW3yCpEITITXDzqZshD1rUvDGT
         dBANMQHlP5lYJtJqNxDL/8F3K9pAd7aAKV7hgp5wJy9y7OzKRapweY3lonAEf/6Rj21N
         7XMfRozmojxhbl5xfOMVhl21VHJ78P9TkoQBCDGL1RHzFnqFtO8vUpw4GERUydPvfyri
         kK95AypBxN0lQQ5LPfxEYCaIf2TMhEIYHEOhbLH+pKUkTwSUQL3PhhCSL7XI+tRzhGBB
         pKxL0B1GspAceV0HlJl4WuCaFE92wjSQwK+YcQigfcPdpw4yPjXjwsoFKJIif9njZURQ
         Qwlw==
X-Gm-Message-State: AOAM532RD8l4/rO5V7fG/VY2mJXpjo0SaQtgL3IgalIqpGNMPsgyrDuU
        /Uix+j6SBUYjsnWqBhi73yfrvUg1V94=
X-Google-Smtp-Source: ABdhPJzRsbhZh2e9+uxsN6mhSV/t6R2O5Bpi7DxRAhoMG4kvfKotX7tbLl3XFWns3Dk6Hy/U9we+8g==
X-Received: by 2002:a05:6830:1e11:: with SMTP id s17mr15259608otr.361.1640706847864;
        Tue, 28 Dec 2021 07:54:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26sm3948825oij.5.2021.12.28.07.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 07:54:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/4] docs: hwmon: dell-smm-hwmon.rst: Replace ascii table
 with flat-table
To:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211228153709.18317-1-W_Armin@gmx.de>
 <20211228153709.18317-3-W_Armin@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3e2be661-093f-fe75-465b-1cc54e0d9f22@roeck-us.net>
Date:   Tue, 28 Dec 2021 07:54:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211228153709.18317-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 7:37 AM, Armin Wolf wrote:
> flat-table is recommended over ascii art tables.
> 

I really don't want to encourage people sending me such patches,
so please don't do that unless there is a technical reason
to make those changes.

Guenter

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   Documentation/hwmon/dell-smm-hwmon.rst | 60 +++++++++++++++++++-------
>   1 file changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index beec88491171..f1e185e8a3f7 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -29,22 +29,50 @@ Temperature sensors and fans can be queried and set via the standard
>   ``X`` such that ``/sys/class/hwmon/hwmonX/name`` has content
>   ``dell_smm``). A number of other attributes can be read or written:
> 
> -=============================== ======= =======================================
> -Name				Perm	Description
> -=============================== ======= =======================================
> -fan[1-3]_input                  RO      Fan speed in RPM.
> -fan[1-3]_label                  RO      Fan label.
> -fan[1-3]_min                    RO      Minimal Fan speed in RPM
> -fan[1-3]_max                    RO      Maximal Fan speed in RPM
> -fan[1-3]_target                 RO      Expected Fan speed in RPM
> -pwm[1-3]                        RW      Control the fan PWM duty-cycle.
> -pwm1_enable                     WO      Enable or disable automatic BIOS fan
> -                                        control (not supported on all laptops,
> -                                        see below for details).
> -temp[1-10]_input                RO      Temperature reading in milli-degrees
> -                                        Celsius.
> -temp[1-10]_label                RO      Temperature sensor label.
> -=============================== ======= =======================================
> +.. flat-table::
> +   :header-rows: 1
> +   :widths: 4 1 5
> +
> +   * - Name
> +     - Perm
> +     - Description
> +
> +   * - fan[1-3]_input
> +     - RO
> +     - Fan speed in RPM
> +
> +   * - fan[1-3]_label
> +     - RO
> +     - Fan label
> +
> +   * - fan[1-3]_min
> +     - RO
> +     - Minimal Fan speed in RPM
> +
> +   * - fan[1-3]_max
> +     - RO
> +     - Maximal Fan speed in RPM
> +
> +   * - fan[1-3]_target
> +     - RO
> +     - Expected Fan speed in RPM
> +
> +   * - pwm[1-3]
> +     - RW
> +     - Control the fan PWM duty-cycle
> +
> +   * - pwm1_enable
> +     - WO
> +     - Enable or disable automatic BIOS fan control (not supported
> +       on all laptops, see below for details)
> +
> +   * - temp[1-10]_input
> +     - RO
> +     - Temperature reading in milli-degrees Celsius
> +
> +   * - temp[1-10]_label
> +     - RO
> +     - Temperature sensor label
> 
>   Disabling automatic BIOS fan control
>   ------------------------------------
> --
> 2.30.2
> 

