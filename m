Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF45349D97F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiA0DzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiA0DzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:55:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B87C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:55:12 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y27so1546437pfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DTqfZ2Khk7i2kR4no5ocp1ILc6jfOZz5DYWh2ODagWE=;
        b=MH2eKxmRFX4O+qEUS8Am3et6XBzmvFyvO3vPi9LdnJ2AtT6fXfJlVlzV1ZffvPQJwX
         M6Xxx08py7d7hgQ4oreeQ6EgnR7jQ74d2wPBFRBdFDdkfAoREnePLNXmcfkt6zes0lry
         1sQCri5olxkom5chwTWGs9rpcbtsZB5rpNEqBTRb6sglq0teeV9EVLP8hJQpJYnk7pbV
         FFOo8K3/5Q96jsv5K1o4azXkUOaYHsYzGspl9tSNjxHH8YK99eOM7bltdgE+rM2W4ge/
         1ZsI3q3IqagPUJjJHMynb823aerCHzoPpFYM19bnpUua1QAWbdspav9sdQVZZihn/0kd
         EF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DTqfZ2Khk7i2kR4no5ocp1ILc6jfOZz5DYWh2ODagWE=;
        b=h+LaTU/SfaWuwOTTT1wc5vak4MW0pAKLXrwgoj4kHSB9fV0jo0XM8wSyiq4uN0UfQN
         zWDBJJYDSvxosPB/JBOsRmnp5mNKyigLIXBr/FnKU2u6KQQ1PtIFL4VqkhkIh/mjTTmk
         VOl/pNvVSfTfQhKYbt0dqhuM4np+pIW7offTfPpDPvMC2pHPKgAO8tikTVQJi3ng1cKo
         yc9LgVG9y7TUFHuR31+hSnqgRV8jz0iT4hqC16Qebhiseu5xChspm3rHs028lsW+6+Gu
         QFXlDz7HrcCwX/fqmJ6hbF3kLe4b/aM1uKUnj5/6RFcShZRhVWOqy6R2uOadur9/N3HC
         BWzA==
X-Gm-Message-State: AOAM5305hyFECKlsULGg6TSngAbV1pV0vGngPtvGkZGoxBhTKnO+de4t
        zxw+z42cgwrQe0milAOODP0=
X-Google-Smtp-Source: ABdhPJzZBk15HQ8kvib9OppnvSfRL9zj6j34lSbuGB6DOfYGpAplTAF7Gxb1cKMM44WIHj9sWl+8rQ==
X-Received: by 2002:a63:f34a:: with SMTP id t10mr1448682pgj.189.1643255711573;
        Wed, 26 Jan 2022 19:55:11 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id z13sm237264pfh.45.2022.01.26.19.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 19:55:10 -0800 (PST)
Message-ID: <c7b80842-1e30-8a25-933c-da8658a91287@gmail.com>
Date:   Wed, 26 Jan 2022 19:55:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] Broadcom STB PM PSCI extensions
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220122035421.4086618-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2022 7:54 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series contains the Broadcom STB PSCI extensions which adds
> some additional functions on top of the existing standard PSCI interface
> which is the reason for having the driver implement a custom
> suspend_ops.
> 
> These platforms have traditionally supported a mode that is akin to
> ACPI's S2 with the CPU in WFI and all of the chip being clock gated
> which is entered with "echo standby > /sys/power/state". Additional a
> true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
> mem > /sys/power/state".
> 
> These platforms also may have an external Broadcom PMIC chip which can
> cause the SoC to be powercycled assuming that we communicate that intent
> via a vendor specific PSCI SYSTEM_RESET2.
> 
> Since it is desirable to get any new functionality added to the kernel
> to be loadable as a module as part of shipping said products in a Google
> Kernel Image (GKI) environment, we need to export a couple of symbols from
> drivers/firmware/psci/psci.c.
> 
> Thanks for your feedback.

I will be sending a v2 addressing the kbuild robot failures reported but 
would prefer to get some feedback first so it can be addressed 
simultaneously. Thanks!

> 
> Florian Fainelli (4):
>    firmware: psci: Export a couple of suspend symbols
>    soc: bcm: brcmstb: Make legacy PM code depend on !ARM_PSCI_FW
>    soc: bcm: brcmstb: Added support for PSCI system suspend operations
>    Documentation: ABI: Document Broadcom STB PSCI firmware files
> 
>   .../ABI/testing/sysfs-firmware-brcmstb        |  16 +
>   drivers/firmware/psci/psci.c                  |   9 +-
>   drivers/soc/bcm/brcmstb/Kconfig               |   4 +-
>   drivers/soc/bcm/brcmstb/pm/Makefile           |   3 +
>   drivers/soc/bcm/brcmstb/pm/pm-psci.c          | 315 ++++++++++++++++++
>   include/linux/psci.h                          |   2 +
>   include/linux/soc/brcmstb/brcmstb-smccc.h     |  84 +++++
>   7 files changed, 430 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-firmware-brcmstb
>   create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-psci.c
>   create mode 100644 include/linux/soc/brcmstb/brcmstb-smccc.h
> 

-- 
Florian
