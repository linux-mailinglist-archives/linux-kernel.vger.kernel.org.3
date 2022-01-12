Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E6C48C2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352702AbiALLBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbiALLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:01:28 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3CC06173F;
        Wed, 12 Jan 2022 03:01:26 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d3so6599047lfv.13;
        Wed, 12 Jan 2022 03:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JDKpbVvncXZg+dhS5GwOnEl7CbpOlY80mhDgDjysBHQ=;
        b=nzy3J6DQUoamzkSBls6Pv1aEhtT5GXx2J+BARKTcC0dHOymkoyUR+h82smpMD6URP2
         qHCWRbYWyCVoUZqzyk5DfksiZcN+3XzRXoxWHChgj+EJUwtzRuwNAjhxWOd2TRypQyGQ
         //Z//MBYWCeHCYjqE5J6YXjfU2Lidv6zyXdlBbr91Iz6fflNwhp9dhNeINSpggPejHSH
         JKqyAi3N4px8P5pWxbB30wVV/Rsfwsnjk19YGotXNyScb6BxopNFts2G33TjWs+K0ng+
         tfraakLmcn4wlHF+YN316DEr5l2mJ6TaJRB7KNh0Ai6Wygh1RW7nCLdr6k3mqEkeif18
         d8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JDKpbVvncXZg+dhS5GwOnEl7CbpOlY80mhDgDjysBHQ=;
        b=2kKJVCQLFS5EOVvkkzeYjj/h+LJDvv/tvMx2AEznRewWpK2xueG7UMtPo1R30zfu10
         eGsex/4a5LisbJzWmuUZJRwvcKlPzUtwzvr/XQCRmJ7Q1rmaegABbZV4XdqQYr8fymVL
         0yTq7YlbEAinysQiwfWFFHQ+lIJyncH+V1HeN4a7RXAl/m7IET1LYL7amWN9bwcJ9geV
         k1d5nmF5hCqCpUeEJlRBOqV8nTDQG20Y1VOXuMKVBS0BYRuJn1pkJTyFRzhEXM5fdrCW
         6pHtfv81uKV9gchpJDt4KGYjtEYIiN2NXF3X6IeZrPQu/TxTd7/rI3HBDxSu4lcUFMuC
         kkSg==
X-Gm-Message-State: AOAM532yjsXn9aj0l8+VzwSnB/VNQValgkMh0PxMTbUSvZ/IhR2R47OM
        R8yKmccamfIcZsUdrl2aRTk=
X-Google-Smtp-Source: ABdhPJxLXmyjrpw57NQ8We0Hd905K3dTHP1k+kD9HH5Clmmr0HXM5eP+lDgF48rYW/aMgYrZ4kTPTw==
X-Received: by 2002:a05:6512:3c88:: with SMTP id h8mr6813345lfv.256.1641985285347;
        Wed, 12 Jan 2022 03:01:25 -0800 (PST)
Received: from [192.168.2.145] (94-29-62-108.dynamic.spd-mgts.ru. [94.29.62.108])
        by smtp.googlemail.com with ESMTPSA id p9sm1601519lfg.287.2022.01.12.03.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:01:24 -0800 (PST)
Subject: Re: [Patch V1 3/4] memory: tegra: add mc-err support for T186
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f9ca5794-55ac-803f-8606-f0b48e826eb7@gmail.com>
Date:   Wed, 12 Jan 2022 14:01:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.01.2022 21:45, Ashish Mhetre пишет:
> Add all mc-errors supported by T186.
> Implement mc interrupt handling routine for T186.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/memory/tegra/mc.h       |  17 +++++++
>  drivers/memory/tegra/tegra186.c | 100 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
> index 2d4f495..7817492 100644
> --- a/drivers/memory/tegra/mc.h
> +++ b/drivers/memory/tegra/mc.h
> @@ -44,6 +44,15 @@
>  #define MC_TIMING_CONTROL_DBG				0xf8
>  #define MC_TIMING_CONTROL				0xfc
>  

this empty line is unnecessary

> +#define MC_ERR_VPR_STATUS				0x654
> +#define MC_ERR_VPR_ADR					0x658
> +#define MC_ERR_SEC_STATUS				0x67c
> +#define MC_ERR_SEC_ADR					0x680
> +#define MC_ERR_MTS_STATUS				0x9b0
> +#define MC_ERR_MTS_ADR					0x9b4
> +#define MC_ERR_GENERALIZED_CARVEOUT_STATUS		0xc00
> +#define MC_ERR_GENERALIZED_CARVEOUT_ADR			0xc04
> +
>  #define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
>  #define MC_INT_WCAM_ERR					BIT(19)
>  #define MC_INT_SCRUB_ECC_WR_ACK				BIT(18)
> @@ -159,6 +168,14 @@ extern const struct tegra_mc_ops tegra186_mc_ops;
>  extern const char * const tegra_mc_status_names[32];
>  extern const char * const tegra_mc_error_names[8];
>  
> +struct tegra_mc_error {
> +	u32 int_bit;
> +	const char *msg;
> +	u32 status_reg;
> +	u32 addr_reg;
> +	u32 addr_reg_hi;
> +};
> +
>  /*
>   * These IDs are for internal use of Tegra ICC drivers. The ID numbers are
>   * chosen such that they don't conflict with the device-tree ICC node IDs.
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index 6766cc4..4f3ae71 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -146,8 +146,107 @@ static void tegra186_mc_clear_interrupt(struct tegra_mc *mc)
>  	mc_writel(mc, MC_INTSTATUS_CLEAR, MC_INTSTATUS);
>  }
>  
> +static const struct tegra_mc_error int_mc_errors[] = {
> +	{
> +		.int_bit = MC_INT_DECERR_EMEM,
> +		.msg = "EMEM address decode error",
> +		.status_reg = MC_ERR_STATUS,
> +		.addr_reg = MC_ERR_ADR,
> +	},
> +	{
> +		.int_bit = MC_INT_SECURITY_VIOLATION,
> +		.msg = "non secure access to secure region",
> +		.status_reg = MC_ERR_STATUS,
> +		.addr_reg = MC_ERR_ADR,
> +	},
> +	{
> +		.int_bit = MC_INT_DECERR_VPR,
> +		.msg = "MC request violates VPR requirements",
> +		.status_reg = MC_ERR_VPR_STATUS,
> +		.addr_reg = MC_ERR_VPR_ADR,
> +	},

I see that these VPR registers present on all SoCs starting with T124.
It doesn't look like you need the separate IRQ handlers at all, instead
please extend the common T30 handler. For example, you may add a
switch-case statements to handle those T124+ specific bits differently.

static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
{
...
	switch (bit) {
	case MC_INT_DECERR_VPR:
		status_reg = MC_ERR_VPR_STATUS;
		addr_reg   = MC_ERR_VPR_ADR;
		break;
	...
	default:
		status_reg = MC_ERR_STATUS;
		addr_reg   = MC_ERR_ADR;
	}

	value = mc_readl(mc, status_reg);
	...
	
	value = mc_readl(mc, addr_reg);
