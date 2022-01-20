Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B999494E97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbiATNHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbiATNHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:07:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9BBC061574;
        Thu, 20 Jan 2022 05:07:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o12so21300170lfu.12;
        Thu, 20 Jan 2022 05:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aXepAYAyT7/G8EroLA/XnX6tZ9gPc8nhC6rl/rhcEGs=;
        b=Ss4NoeWtMC4d0o9WZ/kRzzaxrIxL/7mA+WzSid6J6zcrfxEDmH3DqWIBii2r8YeQzC
         rvnUwzEkWpesHSbJFyrOerFhoQOhmAhbe1XNwjJ96JqZcgx3127/m2tWqVXLWgQvjts9
         COBENoNvpCehEgl6WbsJBKdK3mW2aLb2+xpqLYJW1FB2hZliu2cqxevrinDA8CmPooju
         G6e4Jq6PWfWkVWZY/hCRauFk6bSYWLkf4q8xA4ujRdLuQLN7l2uv/ClSYmu7NvOGswdq
         iR9vM4BQGWQErX2KewyEHCEzP0bKi7o3HnDU1qeRHgvppGbCRkyBkf67Shicjq7Q6ltE
         OyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aXepAYAyT7/G8EroLA/XnX6tZ9gPc8nhC6rl/rhcEGs=;
        b=Yv3/aGdMBTMMKC2S1BRh1IZNdFd7Jegst1jMAhG0JAz1NAi3uKLavB0AG/XjxPwlep
         4YDI4l8dGcn1rQj0VTomdtErn1scw6LsO/hi9fLGa7ZOZZOXzSaWkPRbkAGJccAWJ3Xb
         pzsw+kF2/qE5j9YYFtbQFYazNXlcFUWf+NGJspBL9VaV4b6WZoTFd3ltbF2IkWvGiIsm
         ZPzQ/ObIM8Mor1dtQGUt9nEjy22K2xPNiyuYeNI/o2Cm6YdmGRIYrXrpgRG1IuTx6eFN
         EKqYMMj94YNGJQmWDQjJUhkfcQEGptBh/PfGeSZmtJOMlBoJHK2Xcmk2LPp/odqvRsGx
         7vvQ==
X-Gm-Message-State: AOAM5304Q1nfzdMPVO5DEJ/AT1Wj9jXuLDijMW0s+UgQEeYFzzVseQuY
        6/Rc9mBv46jNXWBE0anvO2g=
X-Google-Smtp-Source: ABdhPJz7bgETZMke5qG1t4pwZ0b4t8bIgENlVidIOCfUlk+navtmLt1uQXf8liK1BUVJZ6CnicFTqA==
X-Received: by 2002:a2e:8854:: with SMTP id z20mr7773833ljj.343.1642684019705;
        Thu, 20 Jan 2022 05:06:59 -0800 (PST)
Received: from [192.168.2.145] (109-252-139-36.dynamic.spd-mgts.ru. [109.252.139.36])
        by smtp.googlemail.com with ESMTPSA id z13sm353056lft.92.2022.01.20.05.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 05:06:59 -0800 (PST)
Message-ID: <1ef23e26-fcde-e2b7-d4d7-c4fc68c1ca90@gmail.com>
Date:   Thu, 20 Jan 2022 16:06:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V2] memory: tegra: Add MC error logging on tegra186 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1642669368-20605-1-git-send-email-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <1642669368-20605-1-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.01.2022 12:02, Ashish Mhetre пишет:
> +		default:
> +			status_reg = MC_ERR_STATUS;
> +			addr_reg = MC_ERR_ADR;
> +#if defined(CONFIG_ARCH_TEGRA_194_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_234_SOC)
> +			addr_hi_reg = MC_ERR_ADR_HI;
> +#endif

I'd add new "has_addr_hi_reg" field to struct tegra_mc_soc and use it
instead of the ifdefs.

if (mc->soc->has_addr_hi_reg)
	addr_hi_reg = MC_ERR_ADR_HI;
