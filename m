Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9C247C2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbhLUPep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhLUPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:34:44 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD03C061574;
        Tue, 21 Dec 2021 07:34:44 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id i63so21989822lji.3;
        Tue, 21 Dec 2021 07:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ENsWP3t0OEsvzi2ehFfWL5PLo9nbmRuKstEblytFSZk=;
        b=du6prEqyy4VDh/9oQkaNuO9m1zQmEsrUQ+ezBUvmdM6CVHpRrysbEQkA9iSaS8HB+8
         MMzGTQKeSwvJ/OMg2yhe7Yt1vapH1K108rr2fLquBGUMx0MpBRRQl2si/5hZffG4aFAG
         N9jkNTT9MYa23a5A7VgGu7lS5uMTHDm1h7ZrmuXECkw8zkoH8pKFS0hF7MjLbTEFkOlN
         gLOYbyWyTbW1YKBZlvHUA+8qaXAlZh0AzZB8Ig0kFWVbyqaJq+Q1T+FBmLBNfogkbfYs
         4o7SJOOV18G/kAxQu0QoOel+dW83xDbMgHYW+3Zof+o1vsttA+tQNcM/eEesD1T9fSXC
         yNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ENsWP3t0OEsvzi2ehFfWL5PLo9nbmRuKstEblytFSZk=;
        b=TG+wOZKjktHQUjIAAkl55XtF3qlM1E/f8mdnXpeDoHyQBvs2E121VnesvZLf6xRWDQ
         Tb+ln3H1dMD2jHBUo3aVr7M9MwpyEhMTf/STvCiT1nqfPaUY32XeBaPogAWcotaIbQyD
         q1E5bdha/2eb7/+9oGm0sydjBApkG3rQvpdtpaCSD/nzAjIIpaO5c39yhFTCQS3/LRNZ
         kVQwDUP+hlJ67qsSayZZ0ObhoRN+zQz3MQskuYL74pXx/CzuPg5gwNcu/Ax9+bg85SM1
         Pa982juKAiobhF6OYgNYGLs/zTdgeDQA/I6pQxJr9cktPzhpoFmIH7cAWKy8vEnv+SRv
         Rn8g==
X-Gm-Message-State: AOAM530nYJjJOZan29nSxH0fd2o1WBQUH7ZWZ5ZBRVCqv1ipaVG0ywG/
        oLjkRxdd6o+Iq5rs5XHHKkPZxEj+nVk=
X-Google-Smtp-Source: ABdhPJyDx3MAzVctUS7978ihuhMpJuYGK9FEWO80QNPmP5CaKDEoqhisEbZErPGWxHz0QLZ7Rtf0oQ==
X-Received: by 2002:a2e:7a11:: with SMTP id v17mr2727509ljc.33.1640100882577;
        Tue, 21 Dec 2021 07:34:42 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id bf19sm2771177ljb.126.2021.12.21.07.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:34:42 -0800 (PST)
Subject: Re: [PATCH v1] memory: tegra30-emc: Print additional memory info
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20211217234711.8353-1-digetx@gmail.com>
 <fc5601e7-40e7-03c5-a433-859539f82144@canonical.com>
 <03a09ff5-fe2d-3ce2-a93b-4e44fd030ffb@gmail.com>
 <84487ed8-2f9d-c178-012b-8407e5083b87@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f775891b-12c4-ae6c-364c-abaa7ea3f249@gmail.com>
Date:   Tue, 21 Dec 2021 18:34:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <84487ed8-2f9d-c178-012b-8407e5083b87@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.12.2021 11:14, Krzysztof Kozlowski пишет:
>>>> +static void emc_read_lpddr_sdram_info(struct tegra_emc *emc,
>>>> +				      unsigned int emem_dev)
>>>> +{
>>>> +	union lpddr2_basic_config4 basic_conf4;
>>>> +	unsigned int manufacturer_id;
>>>> +	unsigned int revision_id1;
>>>> +	unsigned int revision_id2;
>>>> +
>>>> +	/* these registers are standard for all LPDDR JEDEC memory chips */
>>>> +	emc_read_lpddr_mode_register(emc, emem_dev, 5, &manufacturer_id);
>>>> +	emc_read_lpddr_mode_register(emc, emem_dev, 6, &revision_id1);
>>>> +	emc_read_lpddr_mode_register(emc, emem_dev, 7, &revision_id2);
>>>> +	emc_read_lpddr_mode_register(emc, emem_dev, 8, &basic_conf4.value);
>>>> +
>>>> +	dev_info(emc->dev, "SDRAM[dev%u]: manufacturer: 0x%x (%s) rev1: 0x%x rev2: 0x%x prefetch: S%u density: %uMbit iowidth: %ubit\n",
>>>> +		 emem_dev, manufacturer_id,
>>>> +		 lpddr2_jedec_manufacturer(manufacturer_id),
>>>> +		 revision_id1, revision_id2,
>>>> +		 4 >> basic_conf4.arch_type,
>>>> +		 64 << basic_conf4.density,
>>>> +		 32 >> basic_conf4.io_width);
>>>> +}
>>>> +
>>> Quickly looking, these two functions are exactly the same as ones in
>>> tegra20-emc.c
>>> . Later you might come up with another set for other SoCs, so it looks
>>> it is worth to share these.
>> Should be too much trouble for not much gain, IMO. How many bytes will
>> be shared in the end? There is no much code here, we may lose more than
>> win. All these Tegra EMC drivers can be compiled as a loadable modules,
>> that's what distro kernels usually do. There are no plans for other SoCs
>> for today.
> It's not about the bytes but source code lines to maintain and fix (if
> there is something to fix). But if you don't plan to make a third copy
> of it, it is okay.

Only Tegra114 SoC potentially supports LPDDR2, later SoCs dropped LPDDR2
support. We don't even have memory driver for T114 at all in the today's
mainline. I also doubt that there were any consumer T114 devices sold
with LPDDR2. Hence we shouldn't have a need for the third copy anytime
soon, likely ever.

>> I don't see how that sharing could be done easily and nicely. Please
>> tell if you see.
> Since it is not about duplicated object code, but code for review, it is
> pretty straightforward:
> 
> 1. Create tegra-emc-common.[ch]
> 2. In Makefile:
> 
> +tegra20_emc-y += tegra20-emc.o tegra-emc-common.o
> 
> +obj-$(CONFIG_TEGRA20_EMC)  += tegra20_emc.o
> 
> +
> 
> +tegra30_emc-y += tegra30-emc.o tegra-emc-common.o
> 
> +obj-$(CONFIG_TEGRA30_EMC)  += tegra30_emc.o
> 

The problem that struct tegra_emc isn't shareable and this common code
should introduce messiness to the Tegra EMC drivers. I'd prefer not to
share anything for now and get back to this option with sharing later
on, if will be another good reason.
