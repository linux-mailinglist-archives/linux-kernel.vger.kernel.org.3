Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC44BC996
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiBSRs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:48:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiBSRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:48:28 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FA05B3F2;
        Sat, 19 Feb 2022 09:48:06 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e2so5352269ljq.12;
        Sat, 19 Feb 2022 09:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WRNvBC6o9UGsbku3xFPijsy2+ZDFIPtWNh5a7I/Btf8=;
        b=TGbo6yCdYGD93/pxAGhyvvLgjH8XJVMuefXHswz4bP1zr+75mmibPV0fnY76r5UpNU
         y0muNB1nQVsn/u7CtcDcB6RX/RJ3c+ZtiNjOyLJbmyuqCq36ediJN4rJr0WglLPwfD3u
         xEDJnMgsUsVL3uy/LXM2l1UIEPzsVKUFv6g7mSj0EaUYUJnUJe4nGbrQpoT4CFjuAFuq
         Q06Y3/xx9wCBw5cmlkzdvR2NUyZph6PXeR4PQsmrZ8DY/0p3bYXb+rs6HwTFPuLAhmUy
         pGMReD+zLCz2keV7tSi3Vu4OZPeZnPvBevY2uOSjVOjm9Vw/wP9KdGBrxBocI8+4jF0y
         ANXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WRNvBC6o9UGsbku3xFPijsy2+ZDFIPtWNh5a7I/Btf8=;
        b=XyUZjB8GDjY6lAodh+0KgzCx2Mn38w10qAyQVBZpe1Zja0nqPDhT0HLRRptdY/pvAE
         8QUHlfmJwvEWpvwNEiyRqTE40p2isixEuO4x2kcsyaVyeMpS41hHoj70SRb9c8CTMa2S
         BKipnQUaWIx27c0saTDUHqcFz16zgBE//QX4nccKVKVf1zERzYlesqz4t7HQ8g36P7i6
         n3WsqzWEci9Ao+KWNCuMhtyJZOAUbAIKoMAosLY+Hf4nmBaX9s4JG+nr6cbkyLUtGgFI
         iZeTpVj0/TwVkIXGCDpkCP/XvAYvx6MYjCjmooKUVT5ivgzla751NrjXKGxNizE6CmZY
         p0rw==
X-Gm-Message-State: AOAM531MKcotHTCz/xycp8R/7PloDhtAdWGiGWtAUk2AkBXLb/RTXBCT
        DhHMGDzDypz6kNMECI/MRglyavlmvGE=
X-Google-Smtp-Source: ABdhPJz/BRt4yZ6Y5LNb+KZh4UnLJk9a9nacbUYT258c5HxaK4pyq7Kl19rqtEU4LLu69ggLTlSMMQ==
X-Received: by 2002:a2e:8682:0:b0:246:2c86:8d19 with SMTP id l2-20020a2e8682000000b002462c868d19mr3745142lji.329.1645292883313;
        Sat, 19 Feb 2022 09:48:03 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id q8sm624249lfo.220.2022.02.19.09.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 09:48:02 -0800 (PST)
Message-ID: <149d4794-90fd-cde3-9d59-39e6488db679@gmail.com>
Date:   Sat, 19 Feb 2022 20:48:02 +0300
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
...
> +/*
> + * Due to an issue with T194 NVENC, only 38 bits can be used.
> + * Anyway, 256GiB of IOVA ought to be enough for anyone.
> + */
> +static dma_addr_t context_device_dma_mask = DMA_BIT_MASK(38);

s/dma_addr_t/u64/ ? Apparently you should get compilation warning on ARM32.

https://elixir.bootlin.com/linux/v5.17-rc4/source/include/linux/device.h#L524

> +int host1x_context_list_init(struct host1x *host1x)
> +{
> +	struct host1x_context_list *cdl = &host1x->context_list;
> +	struct host1x_context *ctx;
> +	struct device_node *node;
> +	int index;

Nitpick: unsigned int

...
> +del_devices:
> +	while (--index >= 0)

Nitpick: while (index--)

...
> +void host1x_context_list_free(struct host1x_context_list *cdl)
> +{
> +	int i;

Nitpick: unsigned int

