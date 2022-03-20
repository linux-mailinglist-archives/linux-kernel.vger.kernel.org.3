Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266444E1BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 13:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbiCTMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiCTMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:54:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A704A1D321;
        Sun, 20 Mar 2022 05:53:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q5so16707585ljb.11;
        Sun, 20 Mar 2022 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NPj9f04sMJ3VkX20TlDwOIssZGRIWkPsk5pfadmGsnk=;
        b=O8l8/fSJLECcqMdp6c8EoQHjLWPP4Jqo+Mn2mvGzLRadeGboXLsiVGVd8lcemhSizW
         HrtiJ9Y0Jhyze/mkGbTLNz8V9zgcqWTEFhywWXbpr/qfucCRiZuH+WmaKTQ6xYkW276U
         wvSBI7BGwcBS4zozwRChvkA4eeVlSSSW11+Ik/8n4ULx+EYSOdVJyGDpE2qwiqLfumwW
         YY7iek4w7+Gm9c1MCOBdEIKnm7s514hute7EYudLAaWgoi+mbZitn3wruC72jcbxiBvp
         ZkdTOQ2aKcug1RyRT/zCYgo2R4n3gMNx51W0sJ9K1q9gHfnH3RVwiYzg72/gEetsEWME
         OL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NPj9f04sMJ3VkX20TlDwOIssZGRIWkPsk5pfadmGsnk=;
        b=uYsSYuuwLVVA7yufYciuKbpILOP8ipKLKETrnPkPVbWjTbH6q7Z4vjBZkJiRe19QNB
         6QJoffI2hj+sn8pt/trX0eVWyOOtMLOQooBfV/K5Ut6CeAxzXpFmukME5QhAP7Skd/Gy
         LKqvkASQ3AiWc77GUviwVaYXh38eXhBCkMyQs6OoQxN6LIEGff54yW6MyXtOI8GpYCyL
         huQg+Q4XixokaX8+3nKImUj/jBXoG8WJQYKexOXfcrYlKAHXzOtt9szeeZCrwSufS3dN
         pVLoNFeJ9MYe4GEQGNagBGtYh8DhO/Sspdc4DiNNIDdp5M9DaOM8Qe5z/L04oEsz6l2z
         hPAg==
X-Gm-Message-State: AOAM5325uH/7dV6iEImFAPjNLoj5jtYXpLphENPm5+1883JVCWZndHmh
        2jCOcpVlLtVfJXlFj/hzHew=
X-Google-Smtp-Source: ABdhPJzvwSNPy6xtXY65ySuLrJ0+ws9oS3Q9dOVUXrq6EoQf69hU+0kXjD346is8XpVjM4HwFS/HWg==
X-Received: by 2002:a2e:96d9:0:b0:249:8257:74ca with SMTP id d25-20020a2e96d9000000b00249825774camr1618118ljj.105.1647780802595;
        Sun, 20 Mar 2022 05:53:22 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id z11-20020a05651c11cb00b00247dee7faeasm1832219ljo.12.2022.03.20.05.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 05:53:21 -0700 (PDT)
Message-ID: <55ae43f0-a22f-b532-2476-c3afa1e2cb73@gmail.com>
Date:   Sun, 20 Mar 2022 15:53:21 +0300
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
> +
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

This won't work if multiple bits are set at once.
