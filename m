Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41A546D7C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhLHQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLHQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:13:12 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C043DC061746;
        Wed,  8 Dec 2021 08:09:40 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c32so6583236lfv.4;
        Wed, 08 Dec 2021 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Ag4EH6Sr6BZslKLCR8VetO9HeoFeNRaW0N6c+Mu6Xw=;
        b=PFeDRduoDEgkRKVw5+Jw5bcmhmPSJrKsrb2OM9rlVLnVNaW94bm1OU00TeFKkRbDq0
         yrIXvP0FllrbrrQitulGJC14NS/G2RFq8P4eaIpAR8A24mRWGLmpuqQJIewx9o3ZBod+
         JGTKuvxgeV1gZVgANpFAcXRIGFIwazaU8EoPz8NlGRjZsBTWtKXjxxwEGREq/VTc6NIx
         pj03i7kpXySZewxyDrwxh3HBcwXkkcI3L0A+F1THKsba1YJIGkN2nC5CBWCxWEZ+m0tZ
         M7M+oirfw+bkqltyrcIB8pIYzzoGkmuXrzpP9mnCFX+m8LQoOQUmhNl+/NXFihmtZgr8
         rGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Ag4EH6Sr6BZslKLCR8VetO9HeoFeNRaW0N6c+Mu6Xw=;
        b=SbOAkUZo3xeQTnnU1s97xFhyZJN2x/xRby0T9sYVfKQuYiRaAmbbAkgvQ0c59WvWJ5
         l3I09zChnWiJVM8EsGx31aDC0FU/VaDsgT7THBo0l7a5c1FTYuSjRBV6JU6RhijWVSuh
         om1VQtaOgiqy/oISyKAWFvbwgB7XXRLME+hLriab11u+kXLypTI1TYHoIVx9uk6MRPkR
         jNVJwGvlibQNj7c/da3w/GaKEynKGkcJUT7MUf2EzquYrxZ1iCryFR4QZwl1Xmxql43d
         rKQvQpA5eZGgiVZonyDQS4dWAy+AeAJCt4TAwtXHqDytooTOqh7RFEoBigL2rTxQKGwC
         VCpg==
X-Gm-Message-State: AOAM5329xJOYpSeGG+xBIL8S6rlvRkLOii7Ly7uMSABIkuP0iNOHlBEl
        JjxlZ0v4uGIsYN2vd/VGxZYtPU3O/7o=
X-Google-Smtp-Source: ABdhPJyIQ3fNw160L4AUPtLSousyLrypJOi8qtntDDg23MApW2UPh7qTKIMeeBdgiB4r9cJwhrdDTA==
X-Received: by 2002:ac2:428b:: with SMTP id m11mr342057lfh.311.1638979778916;
        Wed, 08 Dec 2021 08:09:38 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id e17sm292567lfq.102.2021.12.08.08.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 08:09:38 -0800 (PST)
Subject: Re: [PATCH v7 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
To:     Nicolin Chen <nicolinc@nvidia.com>, thierry.reding@gmail.com,
        joro@8bytes.org, will@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211208084732.23363-1-nicolinc@nvidia.com>
 <20211208084732.23363-7-nicolinc@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <090bcb4e-ae22-bdcd-2837-e1afc3317cb6@gmail.com>
Date:   Wed, 8 Dec 2021 19:09:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208084732.23363-7-nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.12.2021 11:47, Nicolin Chen пишет:
>  static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
>  				 struct tegra_smmu_as *as,
>  				 unsigned int swgroup)
> @@ -517,6 +646,12 @@ static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
>  			dev_warn(smmu->dev,
>  				 "overwriting group->as for swgroup: %s\n", swgrp->name);
>  		group->as = as;
> +
> +		if (smmu->debugfs_mappings)
> +			debugfs_create_file(group->swgrp->name, 0444,
> +					    smmu->debugfs_mappings, group,
> +					    &tegra_smmu_debugfs_mappings_fops);

I noticed this in KMSG:

 tegra-mc 7000f000.memory-controller: overwriting group->as for swgroup: g2
 debugfs: File 'g2' in directory 'mappings' already present!
 tegra-mc 7000f000.memory-controller: overwriting group->as for swgroup: g2
 debugfs: File 'g2' in directory 'mappings' already present

Doesn't look okay, please fix.
