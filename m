Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20B5481678
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhL2TyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhL2TyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:54:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98C1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:54:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t26so46358616wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AYgJm3Z1tSR5Siv29G2UYY7I4ntAQELIfBcvNqWFS10=;
        b=l5HwBAha+7bZs3VnX23PMnXJbhjgGcH+jbQ4Wvz4T9QfZzs7v/NoE4FeHJenRY/Ma6
         lVqoQAzOYNa85ePDghrThFWQcgyybgbHMDigMdnmtgFNh5bwjc1fwKYoFiAmQE0d2YPL
         nFjoW5JWa22OJ6aPNfbqpXWmGt5fSsRah2vdTaOXY53vdPJ/d6QzqmUESgaO1g/7XE03
         Ssa6EWbNiEIpLeH4hlYeG1mtJx2hmRzxCCX7hWo099eB+ekJf1gWP8RBL4GD/rbvjQmf
         LnCX62F6doa2/TL3jjzglIM002CHoadx5YqmNhWMLAPE0X59LmqNzGMPOOQ4GqMvOBfl
         g21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AYgJm3Z1tSR5Siv29G2UYY7I4ntAQELIfBcvNqWFS10=;
        b=0/1vGQvLCHCxyt+lglqKWw58AKh2dp3V61VxUOCt3R90ry4Svb7JPnUYcgFU8sbyjx
         nsOpZlSUYTjmxK6YBNceYeQcsPl9gdpeCGgTYoO2QPGLV8W2ptyRFDtBxSpHzkRapUTW
         c1XoFUV+kvcxqCsX1vUBThz79STq0cI20bOsCwun+ijGigow1PZhTSkKw+DMBhwrdECV
         SRUHNHayytjXDdqnN7b5zDx7FsVnA0d5J01SHycXgFTWXkUktYE0MB89O5zvE9J+dIy1
         dwhEnXbIe5yRjQCr5tReCZvwGyMektagnQ/GbVdsrOZs1mUAF/TCzat62OuevF8XM+jF
         HA3Q==
X-Gm-Message-State: AOAM531A40eSJf2zA1L7Fp9fWY1h2lNrciRH+1rLhj2zusz+wcWq8hBN
        y5wjstbmGXSE+BzqPcrdx3g=
X-Google-Smtp-Source: ABdhPJxOKg6B9uBEFM9ZKGS0/B/51ZCestKZbdkcWcnACIJ5hkWYEOz6EqO4BL5FZSh//Tu1CtlhzA==
X-Received: by 2002:a5d:64a1:: with SMTP id m1mr21524523wrp.503.1640807646252;
        Wed, 29 Dec 2021 11:54:06 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id x8sm24420551wmj.44.2021.12.29.11.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 11:54:05 -0800 (PST)
Message-ID: <0b0f0f81-cabe-aef2-e453-2caa2985b96b@gmail.com>
Date:   Wed, 29 Dec 2021 20:54:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] arm64: defconfig: Enable MT6397 RTC
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20211217162445.876034-1-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211217162445.876034-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/2021 17:24, Nícolas F. R. A. Prado wrote:
> The MT6397 RTC is part of the Mediatek MT6397 PMIC, which is present in
> the mt8173-elm base board.
> 
> The driver for the PMIC is already enabled through CONFIG_MFD_MT6397, so
> enable just the driver for the RTC.
> 

Applied to v5.17-tmp/defconfig

Thanks

> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f2e2b9bdd702..76bd34223277 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -927,6 +927,7 @@ CONFIG_RTC_DRV_TEGRA=y
>   CONFIG_RTC_DRV_SNVS=m
>   CONFIG_RTC_DRV_IMX_SC=m
>   CONFIG_RTC_DRV_XGENE=y
> +CONFIG_RTC_DRV_MT6397=m
>   CONFIG_DMADEVICES=y
>   CONFIG_DMA_BCM2835=y
>   CONFIG_DMA_SUN6I=m
> 
