Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3264FAE59
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbiDJPDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiDJPDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:03:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26CB55237;
        Sun, 10 Apr 2022 08:01:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u19so2444651lff.4;
        Sun, 10 Apr 2022 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NpZ0H0PYk+uGbKLbd/gkxpqsa6ufWmgTBUsmgUksc5w=;
        b=FgVMCG7A/GVw1Y33WtLbZTijOLO+KYfmAZP0uQTQM4AqHP6nZWXsrTni9PTOzLRjXy
         pp+4Na/Hk5xBT8SqMYVhOaknakUBeqIFDEmJQrY1GwV7wflZR0CYxr1nmHaMSEu0RNqa
         4rUwi9FSRnzkVfBdgykTKboURg1WFPN32ym14ETuUrXf7OHt1YRHeHRqTnnTq6l4OZ96
         JvKoUgI2rGuqynUYipq8E1pUZxfWECVmjPA86zrZWgBghb7MNWYMBQ3+DwCCwpTfk9ST
         Gr4INbTxq2zoWgp/u1JZ6U12Q1z1mbqkcxbt4fQiZT9LSfQvPtHUrYRJNUxUu8rGTr0B
         +fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NpZ0H0PYk+uGbKLbd/gkxpqsa6ufWmgTBUsmgUksc5w=;
        b=67g3RNiGO2yVqs1UE2ZCdX5vEaOwBrXo2jm758BIGKE5uUgpYxAaflp4KHdQs4YpBo
         H3h81Uo/ZYOl5/VF85KOJXkko4OFCocyPiUQxUdPLFK6hEj+mDvPd3QYj79LE1X5IN7x
         zD/4ZwSpagZeGgxGtttH7M8IiaWvv/Zp/2wzD6llnyuOwn7bfxRVX9rjWg4bRa7lhlle
         O3TK+7XxR/Jb7EkAGEqxP5PmxUgO+OWYjk/BTYY8tgNHUoq6sD0FonHxMe82ywIr+uzs
         /CUcMRpfkf6S23MyaR6Mc/jD+Rszym0zcbeCALfwZlat6vPh7KZB2bzA7wHjAkoc0zOp
         WEYg==
X-Gm-Message-State: AOAM533vcJQ9rQja6ixE3SO6rXhfZIaGdo4qz9cSSZW8K0DEul1ZuAR+
        9T9hUxMfNBieEDd0pVE1pDxLd0fFrYo=
X-Google-Smtp-Source: ABdhPJxy/AQZqO3SE/CbvqyyFUu9/UsD19QKrLrXUPTNPDoOv6oY1NIGGwjPaUEEPN4IGz8/Y5a/tA==
X-Received: by 2002:a05:6512:e95:b0:45d:cb99:358 with SMTP id bi21-20020a0565120e9500b0045dcb990358mr19280179lfb.444.1649602893206;
        Sun, 10 Apr 2022 08:01:33 -0700 (PDT)
Received: from [192.168.2.145] (109-252-138-167.dynamic.spd-mgts.ru. [109.252.138.167])
        by smtp.googlemail.com with ESMTPSA id a2-20020ac25042000000b0046b9f84bbcesm282229lfm.48.2022.04.10.08.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 08:01:32 -0700 (PDT)
Message-ID: <3b9cab7e-9ebb-7903-4ae6-2ec6adbc72a6@gmail.com>
Date:   Sun, 10 Apr 2022 18:01:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v6 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-2-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220406052459.10438-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.04.2022 08:24, Ashish Mhetre пишет:
> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> index 1066b1194a5a..c3c121fbfbb7 100644
> --- a/include/soc/tegra/mc.h
> +++ b/include/soc/tegra/mc.h
> @@ -13,6 +13,9 @@
>  #include <linux/irq.h>
>  #include <linux/reset-controller.h>
>  #include <linux/types.h>
> +#include <linux/platform_device.h>
> +
> +#define MC_MAX_CHANNELS 16
>  
>  struct clk;
>  struct device;
> @@ -181,6 +184,7 @@ struct tegra_mc_ops {
>  	int (*resume)(struct tegra_mc *mc);
>  	irqreturn_t (*handle_irq)(int irq, void *data);
>  	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
> +	int (*map_regs)(struct tegra_mc *mc, struct platform_device *pdev);

Use to_platform_device(mc->dev) instead of passing the pdev argument.
