Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF24BC9EB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiBSSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:35:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiBSSfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:35:41 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCE1158DBC;
        Sat, 19 Feb 2022 10:35:22 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id v22so6974911ljh.7;
        Sat, 19 Feb 2022 10:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ihAhYAdeg+5mNGGybXtL07Go2hn89yUQuHza/hGj/wQ=;
        b=CKbEo/EfSh655da36ya0jrhiGmnzQqTJlKVP0gefuCExsV+Ab7Ta4cauO8X8eA3OWK
         TEZrfeFlxRC+gQEgaRmPQeXwLBjjzfgOYxrodtJQGs+efxIkqMPTUKC4v9B7eVm7qKYl
         YGUfTC6sdtKsKCnDAFUKWJTjZ9s2Zr79iREHv35eU1e/w4U8VDM29SYxf88A+zdYNJs0
         9hAbRMheWeo4Hmth/m1GzpzOmPFDZ5rP+lCPG8lUufpRM2Alh00ttY9Ml9cgAXiicfP6
         HYkiHJhRMbJTXV+hdEPibOskEipA8014nW1jPmS00i/Qqz9eCUw8Pc36FwSTGZ0Y0L6F
         xTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ihAhYAdeg+5mNGGybXtL07Go2hn89yUQuHza/hGj/wQ=;
        b=JwjAXoFNtblGnZ2uuzKZpdhDkouuJ6f1NGk2GHorpvhSS67CMtfwgkjQSwhogFLhvh
         ETQEWspR49PQA+WjFLaut5mTHGsT3nyZnlFwCr7WhaQkTKyPNVNIp3UssL/XYcyH8dBu
         ZAvo27PjQJ5KGvBGUHmD9cu8qRV0SBElWtOOFgeGaOV7oZoGt92K/5zyioYgdZjgS7wP
         GsOJ+uOmnv3R72CgNCUa17Crrk5bpJKYUUMsevQKvmR38EFxvITFHDxtd2cHq/OcCJCv
         KlrW2QKczt4UhDx1LzMFpEdHmKPjovnJtPoM4xddyFILqGILSMovZ4uWZ4z5w6vSmIWS
         mYhQ==
X-Gm-Message-State: AOAM531WyRYmavLv5bnH3uBhcPho6A5YrKtNA+q/fa9O/UFQqqezaqPs
        9ROJFNVYXK5rnQ5eBulL1Ec=
X-Google-Smtp-Source: ABdhPJyUuey/Cp/BTWCj1MjuWX+PNTm6NcAPr+wmv4r6uS40/QsJrxTXnPwEO8K6bkDeKyB/mQeKDw==
X-Received: by 2002:a05:651c:201b:b0:246:34b5:155e with SMTP id s27-20020a05651c201b00b0024634b5155emr1600949ljo.273.1645295720866;
        Sat, 19 Feb 2022 10:35:20 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id j11sm642315lfm.40.2022.02.19.10.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 10:35:20 -0800 (PST)
Message-ID: <2b4dd244-f918-4d26-2322-00a0bb226ccf@gmail.com>
Date:   Sat, 19 Feb 2022 21:35:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 9/9] drm/tegra: Support context isolation
Content-Language: en-US
To:     Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-10-mperttunen@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220218113952.3077606-10-mperttunen@nvidia.com>
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
> +	if (context->memory_context && context->client->ops->get_streamid_offset) {
            ^^^
> +		int offset = context->client->ops->get_streamid_offset(context->client);
> +
> +		if (offset >= 0) {
> +			job->context = context->memory_context;
> +			job->engine_streamid_offset = offset;
> +			host1x_context_get(job->context);
> +		}

You should bump refcount unconditionally or you'll get refcnt underflow
on put, when offset < 0.

> +	}
> +
>  	/*
>  	 * job_data is now part of job reference counting, so don't release
>  	 * it from here.
> diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
> index 9ab9179d2026..be33da54d12c 100644
> --- a/drivers/gpu/drm/tegra/uapi.c
> +++ b/drivers/gpu/drm/tegra/uapi.c
> @@ -33,6 +33,9 @@ static void tegra_drm_channel_context_close(struct tegra_drm_context *context)
>  	struct tegra_drm_mapping *mapping;
>  	unsigned long id;
>  
> +	if (context->memory_context)
> +		host1x_context_put(context->memory_context);

The "if (context->memory_context &&
context->client->ops->get_streamid_offset)" above doesn't match the "if
(context->memory_context)". You'll get refcount underflow.
