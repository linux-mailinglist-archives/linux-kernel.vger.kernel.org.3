Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C84DE93E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbiCSQQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiCSQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:16:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578143E5DE;
        Sat, 19 Mar 2022 09:14:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so6508783lfj.11;
        Sat, 19 Mar 2022 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gannZSabus/lhZSDcCvNkZLX8+a+i5HLBO+9WIv/OwQ=;
        b=pA2kCcalx9JThK3rPYzTqTwN/Z35mb8onO8omS6OVvwBQS4zGJkfU26G3JUI3N4DL6
         wZzvPbL4hCcGp/sUHnIvFBljEeYd4ktMb0Dq3v0j9AGo8T9mtspSuGL3JciBdOMJvhQv
         02clUVt1VxHzpooIPbAHeBVfvtcHiSbQo8+U1PI6sd/3bR+gWqI17G5eW7ecUfAHcd5h
         5ImKJf2qCojx+ShNtFAIoIg4EvFDIT9zHgFpfv8d5vsY5/urxXu85jV4tx3UeddVuiNS
         grMADx9l+rRr78WRoZn8JQ69cInCL2bChjfiW2oL/3VcO4U9rIf8aS8AaFRqYEx7ZnPu
         2JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gannZSabus/lhZSDcCvNkZLX8+a+i5HLBO+9WIv/OwQ=;
        b=kwCRlQ5yPujzLmLvTYWJj32N6ATp0OZ2icLvY63rxXWjsc7EEb7PomAvte2zPp//Ly
         mvsYztmnNEe1bALquiSMFgxcg/GdRNMt4t+7oWLq2/Q1odU4aXNICvjHCgVhSi3Ra7P9
         9fpsaZAiC/FXF51m5Vh82WSSSwCcGldxLfBqpBYHdzqgJnKMPMYxWmnk9TRsrZOG3r7j
         8RkIWx3asJ09UmwSEltzt95HjeahjnDPW0S6yR6F1+02uePAqru4pesZAstqZUHvUbyw
         Yx7Zh1E/x+QZLBfXiTm0qdkdKa9ybFLi8dM5wUT4VS4kMConyPUO1WLEWxURAVH2DZbP
         LzrA==
X-Gm-Message-State: AOAM533Nx1Ej2Vj8CKmVewEnCM/Q967u4mtyc9Cg4r40DOcV7qCo6MO9
        HgtQyvzRuEPwDvn+GwkD4+Y=
X-Google-Smtp-Source: ABdhPJwMdjs/2uu85H1wGjFYi7Weei3xAo73xSwf3J5hkiyo13zLXqOfYd7bVlP/fNpX1WW4FJozZQ==
X-Received: by 2002:ac2:4c4d:0:b0:448:a39c:a72d with SMTP id o13-20020ac24c4d000000b00448a39ca72dmr9516556lfk.432.1647706493379;
        Sat, 19 Mar 2022 09:14:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id k7-20020ac257c7000000b0044854f11248sm1322115lfo.55.2022.03.19.09.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 09:14:52 -0700 (PDT)
Message-ID: <9ab1a77c-82e6-39be-9b90-b394037fb574@gmail.com>
Date:   Sat, 19 Mar 2022 19:14:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220316092525.4554-3-amhetre@nvidia.com>
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

16.03.2022 12:25, Ashish Mhetre пишет:
> +static int tegra186_mc_get_channel(const struct tegra_mc *mc, int *mc_channel)
> +{
> +	u32 status;
> +
> +	status = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, MC_GLOBAL_INTSTATUS);

This mc_ch_readl(MC_GLOBAL_INTSTATUS) is replicated by every
tegraxxx_mc_get_channel(), it should be a part of common interrupt
handler, IMO.

And then I'd rename that callback to global_intstatus_to_channel().

> +	switch (status & mc->soc->int_channel_mask) {
> +	case BIT(0):
> +		*mc_channel = 0;
> +		break;
> +
> +	case BIT(1):
> +		*mc_channel = 1;
> +		break;
> +
> +	case BIT(2):
> +		*mc_channel = 2;
> +		break;
> +
> +	case BIT(3):
> +		*mc_channel = 3;
> +		break;
> +
> +	case BIT(24):
> +		*mc_channel = MC_BROADCAST_CHANNEL;
> +		break;
> +
> +	default:
> +		pr_err("Unknown interrupt source\n");

dev_err_ratelimited("unknown interrupt channel 0x%08x\n", status) and
should be moved to the common interrupt handler.

