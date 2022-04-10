Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A504FAE53
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbiDJO50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiDJO5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:57:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870AC59A64;
        Sun, 10 Apr 2022 07:55:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h14so17400767lfl.2;
        Sun, 10 Apr 2022 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+/mbHYHqdNArCgS9qTOTJxvVmCb8ix9XakUfpewkf2U=;
        b=TL0E87KmTHg5SFGpsw4jCR1ZBfXW04iq4IAgRKpLHISIs4Updu89Aq8ATFkswhobSo
         xOYLwVY4YkPWkVrlV8zduinh68pCdBqao8GqLj9wX7aIr1hgZxGAHyvOHAXPidQ4BhAr
         KoMqCwQ8SwQhi6vbzLr4ybIIeiOmmvJxE/uIEilEVWH1YFsi2PEIZDyWsr69qXv3jHr0
         /axxFtRtvap6JT1p6O0uRjXnHWmaoQAL4gm0uPc6VvnbpdvI1F2Ia90ZRPZdyCVKWyCd
         sMcVbNGicHM0eU56HBZKsUGFVZSBc3HCBonQezkzNMjv4fV/6mEl0dcD9iXaBTj4NMfA
         6XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+/mbHYHqdNArCgS9qTOTJxvVmCb8ix9XakUfpewkf2U=;
        b=kUJWia7puROk6u5yXTOOX5kqPMj6PV6vPVMG8k2QNGdMksCLW4ZGbSRoPnSATWQTBz
         IycLFIzDq3iPd/T2ErcO7ZVnt6N0f48grszDddyMBEfEVNhQXKYTMxTZl2/nHXFhGNyg
         LMGJCRH9ZityuURSmdM5BJV5mCeA4YvbyRropCpEPO5F8q3I0hH++WnPPUm7swBFgNWE
         P8RD/7UmRyqAMyuUOyECiphYaK5h07iT7lBZmEWLW/1KDFMhdhZ1Yde+zjw9ZTy4bzgB
         fBardjT4pKq3XYcTAnWISbvxLWsjwF8zFNPIvX9XM3OHtEtjfab4aKroxb7sd/yP4jjV
         1swg==
X-Gm-Message-State: AOAM5308oS1XQs9ZQId6Wq3S74VV2Zy0Bvl8QUCgqRagRD1G29yKEXw9
        JTfSu1IND+ZWA2EF6iwwl89HkyArqw8=
X-Google-Smtp-Source: ABdhPJxaE6Y9qAhd0NsVlCoitvjNKPLwLesH4TaOVjpQ7pOJJ09X++RuDu+00mA/9MpwR8iPhKNapg==
X-Received: by 2002:ac2:4899:0:b0:464:f80b:a86d with SMTP id x25-20020ac24899000000b00464f80ba86dmr10593989lfc.65.1649602507670;
        Sun, 10 Apr 2022 07:55:07 -0700 (PDT)
Received: from [192.168.2.145] (109-252-138-167.dynamic.spd-mgts.ru. [109.252.138.167])
        by smtp.googlemail.com with ESMTPSA id t23-20020a2e9d17000000b0024b15c8ac65sm2236291lji.47.2022.04.10.07.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 07:55:07 -0700 (PDT)
Message-ID: <158816cb-9509-5962-11ea-e06aee991e14@gmail.com>
Date:   Sun, 10 Apr 2022 17:55:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v6 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-3-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220406052459.10438-3-amhetre@nvidia.com>
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
>  	/* clear interrupts */
> -	mc_writel(mc, status, MC_INTSTATUS);
> +	if (mc->soc->num_channels) {
> +		u32 status_chan_bit;
> +
> +		mc_ch_writel(mc, channel, status, MC_INTSTATUS);
> +		status_chan_bit = BIT(channel) << mc->soc->status_reg_chan_shift;

s/status_reg_chan_shift/global_intstatus_channel_shift/

> +		mc_ch_writel(mc, MC_BROADCAST_CHANNEL, status_chan_bit, MC_GLOBAL_INTSTATUS);
and maybe add a one-line mc_channel_to_global_intstatus(mc, channel) helper

mc_ch_writel(mc, MC_BROADCAST_CHANNEL,
	     mc_channel_to_global_intstatus(mc, chan), 
	     MC_GLOBAL_INTSTATUS);

> +	} else
> +		mc_writel(mc, status, MC_INTSTATUS);

Missing braces after "else", "./scripts/checkpatch.pl --strict" should warn about this.

Otherwise this patch looks okay at a quick glance.
