Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14814FB65B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbiDKIxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiDKIxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:53:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D73EABA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:51:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e8so5527514wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=iwxtSATT8Mt7edJ1xwuhC6r8z0Io/WpcsfMVAIxwU04=;
        b=F9B3f7gF3tj+7DPUhhL8A0azIYdKhygw7xQvHI+hlQSkPx/ZjU173naKk0BEWrqbnl
         VSeuawys/XW0POS4dioHfGmfxq6mHHUztXrrvhDxW2e3y8txi71DWxAgiwNYXAoHgbJH
         K9txrMNeOkMakENz3pWnUlWX1BaWUZgcg5+gRChO8G/wkCUdgs6XUyFfpEBLdU0x3KJM
         MPEfcxkqrBJLLAkIfcx5l9k8VekmPfuQvSuFB/99qspUa7LOGLse4FfLPWpaeFpILER0
         Io5DCZ16PJJRKA41+VFNblwECaLmRELhRLM/1QIfZ+/ngkm6mePtV8ggC5xJxk+vS6br
         WeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=iwxtSATT8Mt7edJ1xwuhC6r8z0Io/WpcsfMVAIxwU04=;
        b=zjVT2kypbQJJ3Ifidu7+lEV01M6hp0ziTWQW7UanHpYOJaUy1/cmaa7sYZ/E3HnI98
         vzkXxuKijPo+z2ePEtMc2P3itvJyA6LXe3QITQz0AwFsFsbEcYuh9y7zUdypEUexwKwR
         ynej3SzXGriC2F3EUyuz4pHnUllDUnCIUV7Q4OAfPzyQD1sTN0VUDQ3qcCJOrBqV0qeB
         55WW4Tx8/fALkfFLrfyIG+x/TYenceSwSyv0B0Vne7BhHCCYmNf/i1d7Hb/K+YBCu4KN
         SdgAd0fv4o2/bNTrTscI0Ixb5YSH/0wMvFLC35lvy9RkbR3HnxY6DW4N3LokKetrZftq
         0xVg==
X-Gm-Message-State: AOAM530cpwWXnq8RrzMdhlA+hhYsCwX0/c7lbvTYnIGvIxGfJKuCTXTS
        PuHIp9sXrVdznzjWH4yhq955eA==
X-Google-Smtp-Source: ABdhPJxXTlCwkuNoO7NPZnS7ndGLa8yhRWNh//8Fb0sGJhDVMVy8ksQaFtdK8v2VUpknv/mNM5F+kQ==
X-Received: by 2002:a05:6000:1888:b0:204:1a8b:2999 with SMTP id a8-20020a056000188800b002041a8b2999mr24474226wri.221.1649667089907;
        Mon, 11 Apr 2022 01:51:29 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:d1:e096:d183:1bc5? ([2001:861:44c0:66c0:d1:e096:d183:1bc5])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm18300212wmq.41.2022.04.11.01.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 01:51:29 -0700 (PDT)
Message-ID: <cb196470-ec96-3a87-e5c8-3ae813a45b24@baylibre.com>
Date:   Mon, 11 Apr 2022 10:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: meson: alpa sort the board Makefile
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220409064257.24453-1-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220409064257.24453-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 08:42, Christian Hewitt wrote:
> Let's alpha-sort the board Makefile to keep things organised.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/Makefile | 38 ++++++++++++++--------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 0eec18678311..8773211df50e 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,17 +1,18 @@
>   # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12a-radxa-zero.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-kii-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
> @@ -19,29 +20,29 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-p200.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-p201.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-meta.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-hub.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-play2.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-libretech-ac.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-libretech-pc.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-mecool-kii-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-sml5442tw.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-vero4k-plus.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-jethome-jethub-j80.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-libretech-pc.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-jethome-jethub-j80.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-mecool-kiii-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-minix-neo-u9h.dtb
> @@ -52,15 +53,14 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air-gbit.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb

Thanks for the cleanup !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
