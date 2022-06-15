Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E187654CEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349275AbiFOQbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiFOQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:31:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7FA3E5ED
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:31:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so2543724pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdNSDdpF28pADLYgfkDW0JNGk35ddAn9s2Wtj0NQQ2Q=;
        b=Ra3/gzgHLMvhMwLdQQySr/AEsKgTQMBRhU6/8HG3JugrGp53TKxO0j9eEm7MGgognn
         fx5xOfjJ6rcI23PbqmaP9MCfc/xgt5WF6pl46Cqk3RVVe5FcIjhkGzEPHOmswY03z/WK
         9BzK10ikXKviG0ZqWns1DxWiDTGgWkobEIeiBqHTDEklBELLFGkYqUrZJBm/KkHpLJph
         C4wWwQe8pf3La5DBg+t6Q6pI+/RXGKnMKNRhvgLM6C2KCfQ6yrSFRY9vd4iRR5e/klWj
         L9hV51sHMf3BoA2/pP9k8/BO1if/8OFkX+GFKKBMTs2bt3oxfMOMoWcTBw3uLAvUqn2l
         fmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdNSDdpF28pADLYgfkDW0JNGk35ddAn9s2Wtj0NQQ2Q=;
        b=KvIUoUj3MRvUGOgWpGJhV3IAaSFgSoh8GCn1dEZxcV7a9JW54tOJ7oQUc7tI2lHGNi
         w9B1qAA0U5u4vl6wJeB54VG53UkTuBhiCFDCeMJ2FNhVHwJO3dnMh2UDfHllDeSTCDbd
         UvHLfHkAXrEP0IA94sjrirTh7IBomREgAcwcFzcVW8JqCKT80DfH37OkB2wglEV0zhMz
         xOjfO5kGtHwyZlrQ04vysDBi8H3JmtS7rtsuCHCqgOVMhjW2X4jf7mNbQx9dnKGDkS3L
         r/YZSsAKPucsjan3PIg+4/gTT4dPfOeS6ONPeCBMJSNllZKFttkXC3c/+8FFo4ZQ7XXw
         vXAA==
X-Gm-Message-State: AJIora9gUS3An0O3MtAYSPNBmkAk4OSNMCzJNAVGWUgGmBd6DB7j3a/o
        ObwXnmkkmkWF0VkZ/Vhk41o5lyueO3L73eW34b0NbQ==
X-Google-Smtp-Source: AGRyM1tVeSFJ9MDUV4QfDSYCsyFBWbtC+ASjHQDphSfhT/CWvCSk9MOpeXGJRW96EvLtaQncLlpGenrTxVdGQtgFTzQ=
X-Received: by 2002:a17:902:f353:b0:167:7bc1:b1b9 with SMTP id
 q19-20020a170902f35300b001677bc1b1b9mr192047ple.117.1655310674625; Wed, 15
 Jun 2022 09:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220613150653.1310029-1-zhengbin13@huawei.com>
In-Reply-To: <20220613150653.1310029-1-zhengbin13@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 15 Jun 2022 18:31:02 +0200
Message-ID: <CAG3jFysx_sS2QAdh2G9xivD8OjNXRPn1H0zVq=1V4P7yi7UoOw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: it6505: Add missing CRYPTO_HASH dependency
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gaochao49@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 at 16:54, Zheng Bin <zhengbin13@huawei.com> wrote:
>
> The driver uses crypto hash functions so it needs to select CRYPTO_HASH.
> This fixes build errors:
>
> drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_hdcp_wait_ksv_list':
> ite-it6505.c:(.text+0x4c26): undefined reference to `crypto_alloc_shash'
> ite-it6505.c:(.text+0x4c6d): undefined reference to `crypto_shash_digest'
> ite-it6505.c:(.text+0x4c7d): undefined reference to `crypto_destroy_tfm'
> ite-it6505.c:(.text+0x4d69): undefined reference to `crypto_destroy_tfm'
>
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 8ffd601e68f9..1afe99dac0ff 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -94,6 +94,8 @@ config DRM_ITE_IT6505
>          select DRM_KMS_HELPER
>          select DRM_DP_HELPER
>          select EXTCON
> +        select CRYPTO
> +        select CRYPTO_HASH
>          help
>            ITE IT6505 DisplayPort bridge chip driver.
>
> --
> 2.31.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next
