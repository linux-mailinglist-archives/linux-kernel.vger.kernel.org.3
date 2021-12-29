Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7553481679
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhL2Ty4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhL2Tyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:54:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2886FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:54:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso12261051wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NrUwacVRFzf7fPecApv7ayzGGTUNhRqhhOB3jeB+l2U=;
        b=YsSoIPwzO9KKLygwNBShfBEoExsIkKA/yPYAt7L9NGQRNHoAAVh7WJzs9nItMNfGHL
         770ifnXVhVaXC2stW2OilxKe7hOOM8jArF7uWzS6j81GZvy2zyaLq439wUj3TMHSaGPy
         /x0OzentsBshc35MCbf3+VcYzAw7YUdFwz+gMiL9FbQO2p5kQp+MHTdWVym772MoyEon
         457sRW07z+hJMgncCqnEa0R0Pkixt7E3ciZxbd3A10WRFq1Ov/uu1HBJMHPY7Qq5d6Kp
         SViY9YG/QCQ27PV0hXmIKoY6fANq5/OiZKer4MJVSfVlak+gCf2hbPTgj4rghgPj0N1Q
         KG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NrUwacVRFzf7fPecApv7ayzGGTUNhRqhhOB3jeB+l2U=;
        b=iYAJkOgn3X9+2YG8o8JJ7NLPy5PZejD3Nr55cv7xMRt4ZAiXxhp5bc6CbFWllnKwpA
         jZ5fwKu5DDyRhuh2ugNyw3+AFkZyrM/g7cCXjeckhUFN3xs0CqENkfgsTTFw9fxtcO6R
         Dse2RRXMe+fkGIm+C0nhjSn2/9pD6Km/legOPQUW9R59zNhenilVKlismajf6ZLwFAp4
         MjgKhVP4GvEsxDH/46z8QTAjW0Aj9hPRMXaWQb9Y6GHMyMwYiHUPqCPzncEQlLg7yLO8
         ajKDN3EnLVnTigzNcoKnP4n009Jr34hP0yjnU9RnaXXSTJAPENpGQkVMXcsm5DfqjwZq
         60VA==
X-Gm-Message-State: AOAM530C6WQo3q7ABd43zw9eo2HisZ/JUiGA+F9bmTop9lyKvS4hZCdC
        xTkdwr2XoSIJo0mvRbhOKe0=
X-Google-Smtp-Source: ABdhPJwicjRzPYXLZuwWJqBlXY6XpJaAGofQW7h4VyW/OcTIkX81w4DFb+roiVs0KmVLtQdpqcwhRA==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr22777579wmb.73.1640807693669;
        Wed, 29 Dec 2021 11:54:53 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id d10sm24046243wri.57.2021.12.29.11.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 11:54:53 -0800 (PST)
Message-ID: <af4243f6-a4cd-a51e-0ee0-d5f0dec074ff@gmail.com>
Date:   Wed, 29 Dec 2021 20:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] arm64: defconfig: Enable cpufreq for MediaTek
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20211217154452.868419-1-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211217154452.868419-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/2021 16:44, Nícolas F. R. A. Prado wrote:
> The MediaTek CPUFreq driver provides control of CPU frequency/voltage
> on MediaTek SoCs. Since there's no device-tree node to bind it to, the
> driver needs to be enabled built-in. Enable it so.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Queued now in v5.16-tmp/defconfig

Thanks

> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f2e2b9bdd702..829e8bc045f7 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -96,6 +96,7 @@ CONFIG_ARM_QCOM_CPUFREQ_HW=y
>   CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
>   CONFIG_ARM_SCMI_CPUFREQ=y
>   CONFIG_ARM_TEGRA186_CPUFREQ=y
> +CONFIG_ARM_MEDIATEK_CPUFREQ=y
>   CONFIG_QORIQ_CPUFREQ=y
>   CONFIG_ARM_SCMI_PROTOCOL=y
>   CONFIG_ARM_SCPI_PROTOCOL=y
> 
