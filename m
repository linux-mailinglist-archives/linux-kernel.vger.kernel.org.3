Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F174FAE5C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbiDJPGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiDJPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:06:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705D056775;
        Sun, 10 Apr 2022 08:04:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o2so907623lfu.13;
        Sun, 10 Apr 2022 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uOwN9vBmQdLiAiop5qvqolDSzn0EbScB1TJ3qvgyKP4=;
        b=N/EAxeksoGcR25P1cO+rRBnnWJeh954SB9clCW8JYB7mC/p8FbN8llnTZCR14ZBTwp
         e3IZn6kQ/YGF1mmrUyBhAFyn9/cPSC8f2wiJBjhd8OXrYwz7qyhTZGLz+vjUfkhAGeo7
         7K9YJPggY72uhbhDdPUHR95VaFicvncBeLwtROWM6ULrrMohcokHfdtR86MQZTd+vonf
         ohAvLJ/Tw6wLSAcIgqZdumhaxIRewDBDhkZTZUKkRFTootnGUEnxXyky8jmKKCB1CZIA
         BMXEpjbdGJ8A5hU6pQwfJR9TmN2nc3sg5V7FGiLnzzZfCG3YL8PAvIb0KyN6nLkdLARU
         WCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uOwN9vBmQdLiAiop5qvqolDSzn0EbScB1TJ3qvgyKP4=;
        b=WOLqdLbktL54BbtkHh3ZJZ6JfC7LW5VKH0QuG8Z/EZbLgxVFb2PjBw5mK/jDa9RW6J
         xiz6K62agL6+aSvTWszW8IBSGa5/t4WwHZe7/LkYUnquxR6cxdjOdY32mb5VaTqfwscM
         R0H89UxbCbb+Pakxrd/nQFR7M5JZtL4TltHeEMYIm/VFdSq/5f1ngA7vjqg/1jlAEFMp
         IPb2NuTw2dPzLz6XIyHBIQeltBBZC1OyjDJ+cwrQoOOi/Q/gtGDtN/TDx3HOXQJZAMZE
         JYFwiW4gaERVP35tI+Qu3NjVsJy0bjsD7HvODFDXBuMnL4Eo5cfllr1ykq+QuGpuVfdm
         Z8Mg==
X-Gm-Message-State: AOAM532GPX0ZdLA0JpzUkmXqNIQ2npvMwxjQ2+VzI6ss0qFfEqFDcNsz
        FatE2mO3VAfD4COxe93CJk4=
X-Google-Smtp-Source: ABdhPJw8OMY3Ri0SfS4Q6JJrZLFioLRzz+diX3CAjHnsMo1KRWVVUJ1ANDt81caOOte3RkO0sN+JTw==
X-Received: by 2002:ac2:4194:0:b0:442:ed9e:4a25 with SMTP id z20-20020ac24194000000b00442ed9e4a25mr17987613lfh.629.1649603075677;
        Sun, 10 Apr 2022 08:04:35 -0700 (PDT)
Received: from [192.168.2.145] (109-252-138-167.dynamic.spd-mgts.ru. [109.252.138.167])
        by smtp.googlemail.com with ESMTPSA id f4-20020ac24e44000000b0044b07e39d75sm2217435lfr.74.2022.04.10.08.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 08:04:34 -0700 (PDT)
Message-ID: <bf23e357-1e74-6bbe-7f37-11147654e5fc@gmail.com>
Date:   Sun, 10 Apr 2022 18:04:34 +0300
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
>  };
>  
>  struct tegra_mc_soc {
> @@ -194,6 +198,7 @@ struct tegra_mc_soc {
>  	unsigned int atom_size;
>  
>  	u8 client_id_mask;
> +	u8 num_channels;
>  
>  	const struct tegra_smmu_soc *smmu;
>  
> @@ -212,6 +217,8 @@ struct tegra_mc {
>  	struct tegra_smmu *smmu;
>  	struct gart_device *gart;
>  	void __iomem *regs;
> +	void __iomem *bcast_ch_regs;
> +	void __iomem *ch_regs[MC_MAX_CHANNELS];

Why not to allocate ch_regs at runtime?
