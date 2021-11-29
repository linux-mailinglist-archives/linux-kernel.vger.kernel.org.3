Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169B3461FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhK2S46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379776AbhK2Syz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:54:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FF3C08C5FE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:13:25 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso17096850wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UY/oMk5CP+lhMDCwiflvPnkQGNHXKlcdSyzcY5XesvM=;
        b=LdSkTX7j+GKCpWd8+WYJWMzonvnbpljw+CiiO+L2fLG/RiTbh/f+PYd58DBC8MkCcx
         Lze9WAyW5LoyxHhoHAPjd9pYeabSx87SofJ+A3sc2j+4Gh+gN/1QGtF2Lz6VjHODG1pO
         KT4SqRJQ/gaaw79YDcscBM7j8YIwEIYwPAylQqyYnwPIZvsgzc8aZzMh+HpvcpVZ4VIa
         RXjdHsAR/5Z7vAnOP5MQYWYfzmXvi6UXh2hF+e1CSXgC0VjlN7juGGKZZaSQGMhoMN3l
         AOelfNyqpCxU82FekRcF3qBSUbdbiseyXsHi5eP7tUhlDT0Vir97G9jO1XKEBFuYsk8R
         BDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UY/oMk5CP+lhMDCwiflvPnkQGNHXKlcdSyzcY5XesvM=;
        b=3nUB3YC7X7fKxGmQN/JbALoRmLiGaGKOdobAPVMly5qfgxlaqM8XAnAZ1pR/megLTI
         i/QPv30p02eWV2YhP8VnuoF5+cbrL5bw6XVC077+OVSyVifB/Z58xLaWv6JIoSI/+lBu
         RZsVE74fPoq2NKd4wWBeN7IVQQLrJuic0Gice1UeKXm8ZDMUYBcfGGAAuAwWABwfYhdm
         7OWM/+4G5pLBtfNN7TATjVP7UVBhJgVWeGOIxVrKripsR6g6JwkmhpEL8YM2JSYrpVaO
         qqDBsVe4StY7Ha22tz4iHYYfPanum9AkHS0TcX3gNPt7xmXbzvR6A/ikfiX+9cDwfJK5
         MOvQ==
X-Gm-Message-State: AOAM532ZR40Blfcugvs81RzhWkUL8rnD010HkaMJZ7gqC44KKtQEwe93
        ex6wRe97UY7s2ugQ/eBRfIHhGg==
X-Google-Smtp-Source: ABdhPJwgpBiTwlTfTn/bJ34kExETRJsTZjWxY47jcBXZfiM7XlYaJSoBXDgR+XCTtDaNM/XVDvAgMQ==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr37091482wmi.113.1638198803605;
        Mon, 29 Nov 2021 07:13:23 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id g19sm20703756wmg.12.2021.11.29.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:13:23 -0800 (PST)
Date:   Mon, 29 Nov 2021 15:13:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
Message-ID: <YaTuEdDXkjdGE+qX@google.com>
References: <86f546b3233fd799b0c39b83afc521440ebfe004.1638192232.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86f546b3233fd799b0c39b83afc521440ebfe004.1638192232.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021, Mauro Carvalho Chehab wrote:

> The INTEL_SOC_PMIC_CHTDC_TI should be initialized early, before
> loading the fbcon driver, as otherwise the i915 driver will
> fail to configure pwm:
> 
> [   13.674287] fb0: switching to inteldrmfb from EFI VGA
> [   13.682380] Console: switching to colour dummy device 80x25
> [   13.682468] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   13.682686] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   13.685773] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   13.686219] i915 0000:00:02.0: [drm] *ERROR* Failed to configure the pwm chip
> [   13.699572] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on minor 0
> [   13.739044] fbcon: i915drmfb (fb0) is primary device
> [   14.037792] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registered
> ...
> [   24.621403] intel_pmic_install_opregion_handler: Ask to register OpRegion for bus ID=PMI2, HID=INT33F5
> [   24.630540] intel_pmic_install_opregion_handler: OpRegion registered
> 
> (some extra debug printk's were added to the above)
> 
> As suggested by Hans, this patch also addresses an issue with
> the dependencies, as, for this driver to be a bool, it also
> need the I2C core and the I2C_DESIGNWARE driver to be builtin.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/mfd/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
