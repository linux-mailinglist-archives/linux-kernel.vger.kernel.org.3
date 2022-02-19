Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58C74BC99A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbiBSRwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:52:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiBSRwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:52:23 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F65F260;
        Sat, 19 Feb 2022 09:52:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g39so11136524lfv.10;
        Sat, 19 Feb 2022 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7yVrvBYHyY3QdyCCeyIxr1lH8/vkZhQdSt3EyEVyKOQ=;
        b=Z+Y2PwCGESLzwlh6ekus16SE6okHck1S/aJ/1TVFDFmmxlRMudavC5ID4rfQx3gFCz
         W1MZSPN/4+Fx/RCfC6kTNhwpni007xOVyRHw+z+nuasbJKry9LbwPKoZ2gAhc3KeCFAi
         Qt17+bumSz0PxMvDV537wcEhoN84QExYE8Kopw5GoLiXcISR15yJ//wSPJDa1/Pt+7Z6
         mFGFRf31DM/bSCDE9UYVRiAoXFf8vD7kuzRGxKnCrAWvtERB1NodQvBApniBlxN+wj9k
         a7M/mJpr/nIOUZ5lB98CqvzBtpbpT+fABKX62mm4c+IPyP91fbflRUuDtCxqjSaRiNQ/
         Lm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7yVrvBYHyY3QdyCCeyIxr1lH8/vkZhQdSt3EyEVyKOQ=;
        b=yoyAqx+dcOn3QRRE2oQK62P4fdB8fz7TZRzwEDQjL3W+e2RML8FSrRWUe5IcwRGYSY
         vxdC5gZWuwqQEquuIuOSjqqFIRry4IqgN7xNIIHRMpD9MZS1X9dewEZ2a33nzdQeieD1
         nvaYqoKFvcbARpwdXKfFJIiqFSVbmVlqs04eGwynzd53f9NGLJAuoQmRRSMHRhedRDnF
         6vPcfjoJgJVl8O7vLl0WYLvTL73AoO54AtAtnPhiAKzZZ2voBV+iVSGT+/QgZbfm2Zb9
         YF/V5RbgCV4oJ884WjH4SCVFcdBlllqkUfwI1z1oB07t4vExtaAMzeZXpawOP9FquW/0
         +SEA==
X-Gm-Message-State: AOAM531Fju7DXRNUj5E6UA6rkyKdN23Outry+S1B537v9xwZIY8LtoKv
        KoKOTpgJfCeFrCN7TNCPseBq8kKAnY0=
X-Google-Smtp-Source: ABdhPJztgefYS2BdI3meZgbmQg2nNYbVEhFCxZeyVrUB8mQqvT+0gHoAIgPTRqIv1H4Rufh/EzXWng==
X-Received: by 2002:ac2:5b4b:0:b0:43c:795a:25a6 with SMTP id i11-20020ac25b4b000000b0043c795a25a6mr9172627lfp.268.1645293121966;
        Sat, 19 Feb 2022 09:52:01 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id q8sm630091lfr.181.2022.02.19.09.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 09:52:01 -0800 (PST)
Message-ID: <2605a614-0a2c-85ac-576a-048f38f9d366@gmail.com>
Date:   Sat, 19 Feb 2022 20:52:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/9] gpu: host1x: Add context device management code
Content-Language: en-US
To:     Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-4-mperttunen@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220218113952.3077606-4-mperttunen@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.02.2022 14:39, Mikko Perttunen пишет:
> +	for (index = 0; index < cdl->len; index++) {
> +		struct iommu_fwspec *fwspec;
> +
> +		ctx = &cdl->devs[index];
> +
> +		ctx->host = host1x;
> +
> +		device_initialize(&ctx->dev);
> +
> +		ctx->dev.dma_mask = &context_device_dma_mask;
> +		ctx->dev.coherent_dma_mask = context_device_dma_mask;
> +		dev_set_name(&ctx->dev, "host1x-ctx.%d", index);
> +		ctx->dev.bus = &host1x_context_device_bus_type;

host1x_context_device_bus_type will be an undefined symbol if
CONFIG_TEGRA_HOST1X_CONTEXT_BUS=n? Please compile and test all combinations.
