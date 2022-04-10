Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E94FAE34
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiDJOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiDJOU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:20:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389D4C78F;
        Sun, 10 Apr 2022 07:18:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b21so22455731lfb.5;
        Sun, 10 Apr 2022 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zu02Bp5Bmo69mY+ZzCrRwSJldwE8Eb/jrbse8/ezonE=;
        b=BN33pqXNRLlK+TdFHmXv4pg7XkbnubNfhUkTZTJfzbTrpgHeXVV6OMhFl3RrepVGCF
         h9cJ7+Ue69kNFWHB83p17QKKSbiLT0hqfbeChyf49YLQTbcii1sb49ImLIhCNNgFs7Rs
         Ew31GUlnL0lgtgj/psjJd0RxZtmfunYu4fW6UGkzzhZweoKUGDhNM5hNq3jFee7bK7sH
         qqSTC+6zTKKMAjJlqwu3D/cLU+a1ZDMFX6GRPT9MdUwBm4/tZ+hsyBPUgKeYLBvUSKoB
         jtvAgg4NMgWuEH/K31HxGIzKmCLe5VLrdploKKpZjop00f/q1xx0uUqmMQgwXUPBkvnw
         gd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zu02Bp5Bmo69mY+ZzCrRwSJldwE8Eb/jrbse8/ezonE=;
        b=gGAdr6CofwCfB0ZtRMJYXBnvGcpQxrpv62qIE8NjcAbp/sOsl4PDXyxmVIbeTxvYO8
         THS81z9g2QdJ2lhopIhaZpY4rPhTLZDKsAGvd6a/VHe6JwO1AQcyjptC+wEZ+jSqEy8X
         aY6J6lDVldqJCqewOYWzBEQ7AikiVjFVjTEsTKjcrDQOVFOTfJ80gLnONoYuYT1YwGVX
         qq+XuDzDxMYEL5l7ePTCBboknJWqGCg7o5Zc3BF7zwGhR8h9pul1sHYWDXlz3ABgBfkx
         JMelmJRnFMoOes0w74VBOnRUYum8LcxXHoKl+/N/LTpWwNGYw9KkIFMpWARQHG5bE1oq
         yiZQ==
X-Gm-Message-State: AOAM5315nr9cddsuXFIfeIJg4qXoK15WPJPpMHq+8Ad/iRBN2hsA9cll
        XP/yIpnRQznc0w8v0zEUe+c=
X-Google-Smtp-Source: ABdhPJx9OUDwUGEFE2E7HRlKV6j0WftRq+v41puWGQp/JtNZ5oHd15avpwdi4RU/4iO0XEB0TBYpeQ==
X-Received: by 2002:a05:6512:31cd:b0:44a:9e36:a9d with SMTP id j13-20020a05651231cd00b0044a9e360a9dmr19093278lfe.271.1649600325391;
        Sun, 10 Apr 2022 07:18:45 -0700 (PDT)
Received: from [192.168.2.145] (109-252-138-167.dynamic.spd-mgts.ru. [109.252.138.167])
        by smtp.googlemail.com with ESMTPSA id p7-20020a2e8047000000b0024aeee8607csm2862513ljg.27.2022.04.10.07.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 07:18:44 -0700 (PDT)
Message-ID: <3bbbffff-6aa3-7068-6f0c-4372d53daf94@gmail.com>
Date:   Sun, 10 Apr 2022 17:18:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v6 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-2-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220406052459.10438-2-amhetre@nvidia.com>
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
> +	num_dt_channels = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
> +							  reg_cells * sizeof(u32));
> +	/*
> +	 * On tegra186 onwards, memory controller support multiple channels.
> +	 * Apart from regular memory controller channels, there is one broadcast
> +	 * channel and one for stream-id registers.
> +	 */
> +	if (num_dt_channels < mc->soc->num_channels + 2) {
> +		dev_warn(&pdev->dev, "MC channels are missing, please update memory controller DT node with MC channels\n");
> +		return 0;
> +	}
> +
> +	mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "mc-broadcast");
> +	if (IS_ERR(mc->bcast_ch_regs))
> +		return PTR_ERR(mc->bcast_ch_regs);

Looks to me that you don't need to use of_property_count_elems_of_size()
and could only check the "mc-broadcast" presence to decide whether this
is an older DT.

mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev,
"broadcast");
if (IS_ERR(mc->bcast_ch_regs)) {
	dev_warn(&pdev->dev, "Broadcast channel is missing, please update your
device-tree\n");
	return PTR_ERR(mc->bcast_ch_regs);
}
