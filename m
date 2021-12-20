Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE347B052
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbhLTPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbhLTPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:30:49 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE4C07E5C2;
        Mon, 20 Dec 2021 07:27:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l7so16586517lja.2;
        Mon, 20 Dec 2021 07:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5xhA132ah6hJXCbDg6Qu8MApQm3lR77Dm/XN8RAx5xI=;
        b=MrMQ32IPp1ABwuFOPnjoVzzy7DhzGRo8bw2ZPxODVh+xit42tpeUUEG7BGQRr0ZehA
         ZgXfjmUIFZr9OSBKUIXJftZpP8O4u5I6+f5aiP4T6dDlallsMvAZs/sDRseEnglIYR10
         TtW4eruZ/rETNgfisFTXgAR90aOEk+61PATAXqqf4xJUpmOb+0lbUOafled2xdDp/RJ5
         uSYOTvwpXtDHvg60936zA7mLu2xJgg3oZTZdvNilZRut60lvz6JAH6/2JW0+u0cPj9n5
         zKL6o24xTLrW07r/7MQ2u7Pl75/6nqVjSiEJF56UvxZr5KOpGOo57uXcbVf4MJd0x2iJ
         dhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xhA132ah6hJXCbDg6Qu8MApQm3lR77Dm/XN8RAx5xI=;
        b=dAbg3vVoJnwYpKCpGK2dKpRjuuZrpCrUc3O4/luZZSPyi7YgSfu+iCa+c7ls33IP22
         efcoiSAXVJPAzE3dGX1+J6dFyhWVugcF5WDxyCX9/KgpAU3r0pWm30gWWIfrMDs77AOv
         kGO7SODNPR19tV0b1nVokx6ZA02Mq0htjdjGDpueBpznXpmPCMNRYlB5YXQf/h0dDaRZ
         Eww1JKrt2Fu31WcP1mvwTfXbjHvyXpCT1JlWLrGixSNk9tndTM7n/4LQfHXkOeIP2Bf4
         eX1te/Sa1hbsMbqBhv0usDt3blrcDQRicOllj8vdCZnpOmQAfKWHcKGnWBgjs58huEy7
         mGhA==
X-Gm-Message-State: AOAM532FolkYeFfz/nKk+Cflm/hywV9thPaev14Xu4FPUGJ3Is9U4v8Z
        HXQLpAJMWRefFgwb0Zo6Pp8IK08Hg+4=
X-Google-Smtp-Source: ABdhPJwSdsaZG7XbBIx+hqgELcmuOlrGneRp+Go1T6mLq+vqMkWjAHvr+pVTQCrsqzKkphSkEE35hA==
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr14823825ljk.291.1640014041682;
        Mon, 20 Dec 2021 07:27:21 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id f37sm924608lfv.180.2021.12.20.07.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 07:27:21 -0800 (PST)
Subject: Re: [PATCH v1] memory: tegra30-emc: Print additional memory info
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20211217234711.8353-1-digetx@gmail.com>
Message-ID: <af428524-c630-64b9-5d67-22714ebe8d15@gmail.com>
Date:   Mon, 20 Dec 2021 18:27:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217234711.8353-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.12.2021 02:47, Dmitry Osipenko пишет:
> +static int emc_read_lpddr_mode_register(struct tegra_emc *emc,
> +					unsigned int emem_dev,
> +					unsigned int register_addr,
> +					unsigned int *register_data)
> +{
> +	u32 memory_dev = emem_dev + 1;

I just noticed in the datasheet that memory_dev needs to be inverted,
otherwise we read dev0 instead of dev1 and vice versa. This also needs
to be corrected in the T20 EMC driver. It's not really a problem since
both memory chips usually are equal, nevertheless I'll fix it in v2
after we will decide on whether this code needs to be shared or not.
