Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE1148C2BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352714AbiALLCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiALLCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:02:15 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89760C06173F;
        Wed, 12 Jan 2022 03:02:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id e3so3969070lfc.9;
        Wed, 12 Jan 2022 03:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=09JJuYQHYFSNkDJz11ddv1sgJi4bBO6UP4Co8RuirbE=;
        b=dBlGUI/+GJtOOdMTkK2Rk+J00wdWOU7MRoX7T6F6KrYadNEH+MjaHLN1LzmJ/eIpJL
         z/FAFWKPI/PX7LN452hvOecPZU4qlKvqRH45NsdIPK/ShNLA+C5kXdzRYobLiy0x/ILZ
         pQnQtIEp/R96tSA4+B3bgL2AesQIIJ4inLeQsdt05SJzZ9dUUw+LpJm7SEtXAzjFeETg
         y6a3/AfNCUyhhfp1gC1VvlqUiI3ZheEcMIA7vapV6vYM4YTn49ewUo+yXQZUyOXqtM2t
         M00XdGkNdi8W+CO6lN1cB2ycmBHBoEN8erGnoTz9lg51H6uY3qns6KlDukKSjQ2cj+Cy
         eGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=09JJuYQHYFSNkDJz11ddv1sgJi4bBO6UP4Co8RuirbE=;
        b=rBsaXQhKti4ILUM73qsjMArBViS0uv9shCoM7d3QlxXgpnMnJGIAnIBUxgEO5tvHv/
         tS3eROJM/ovFGpHPgUgxi+v5/FXroIn1kwCPreYPoRiOPhPe8SgcbHtaH8G6Isv5vegf
         1crULgjqvrIuON/U3t/1RP+Sp5s86+SwkASRV8/7lKihzbwjXimWpmWy3B660InHds/k
         WKzBD9a0S90n+HpblYntV41CEafZ9yIMIxuP7tDbJQNrAGKcUldxM5XvzAHntVv3yVQV
         cGRB200T0/djF9N7Czl6mBcP6WLm8TnsJMozgxQ0zF1cMiFh+WwVaWVfbERlg2muMRMQ
         MlWQ==
X-Gm-Message-State: AOAM531TkzYpxQ9MpOZCDkaAGsvHxEXFQpMvQK6dnCIj3fm/6k7vkzAM
        ylvFOIaSqW18LIw5SYdJg7s=
X-Google-Smtp-Source: ABdhPJyt0wH+jA39S0j3mvW1vYjy6yhjAhFU3tVcMWRdF9T9fxMosfgsDonBUiJxwLBCD3c1JBOJFg==
X-Received: by 2002:a05:651c:1681:: with SMTP id bd1mr5624583ljb.33.1641985332952;
        Wed, 12 Jan 2022 03:02:12 -0800 (PST)
Received: from [192.168.2.145] (94-29-62-108.dynamic.spd-mgts.ru. [94.29.62.108])
        by smtp.googlemail.com with ESMTPSA id o19sm1528364ljp.58.2022.01.12.03.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:02:12 -0800 (PST)
Subject: Re: [Patch V1 3/4] memory: tegra: add mc-err support for T186
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e10bffa7-3b6d-fb21-583a-1a3f907ff6b9@gmail.com>
Date:   Wed, 12 Jan 2022 14:02:11 +0300
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
> +	{
> +		.int_bit = MC_INT_SECERR_SEC,
> +		.msg = "MC request violated SEC carveout requirements",
> +		.status_reg = MC_ERR_SEC_STATUS,
> +		.addr_reg = MC_ERR_SEC_ADR,
> +	},
> +	{
> +		.int_bit = MC_INT_DECERR_MTS,
> +		.msg = "MTS carveout access violation",
> +		.status_reg = MC_ERR_MTS_STATUS,
> +		.addr_reg = MC_ERR_MTS_ADR,
> +	},
> +	{
> +		.int_bit = MC_INT_DECERR_GENERALIZED_CARVEOUT,
> +		.msg = "GSC access violation",
> +		.status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS,
> +		.addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR,
> +	},
> +};
> +
> +static irqreturn_t tegra186_mc_handle_irq(int irq, void *data)
> +{
> +	struct tegra_mc *mc = data;
> +	unsigned long status;
> +	unsigned int bit;
> +
> +	status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(bit, &status, 32) {
> +		const char *error = int_mc_errors[bit].msg ?: "unknown";

int_mc_errors[bit] isn't what you need and .int_bit is unused, which
suggests that all this code doesn't work and was untested. Please don't
send untested patches.
