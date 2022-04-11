Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C834FC19D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348323AbiDKP4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348315AbiDKP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:56:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B163B1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:54:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so207976wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=tlR52mYiE9r7eSIRLMcwLn8IMEON/6GE7sgWO6ZBnBk=;
        b=wa0W+SMBcn4p5tTd/xN9SHSkxbSIdpuOoKk4xWg0YXMi8qwrcsoPTfMVZqmkYEw+Xh
         Ysps6vXjV065zNiOuFdsaB9zzDAsiKS/7cB3dqKpAjXeJxAN1h+YDN89MB1QdI5+8Y5a
         g6MNrkqtFK9AJO4c70tr6wAxiEwfdKiCPBXYG2IUOCBFH0ZWjbSP0rowK2Gcdg9J8e6f
         OqotiZu8cDdALhicKUKT6TTTnulhk6TKjr48lXRlpSwSY0UK8qutQNm+/bMsgj+ZzQZ4
         dk0IbKg6vG2Thyw90kfGRk9KjNhf229PxMpJKl9F6w56Zua2ScgLG3frlvzFbszR32tn
         VMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=tlR52mYiE9r7eSIRLMcwLn8IMEON/6GE7sgWO6ZBnBk=;
        b=TdWuyRm/P2nlelM3x31pchnDvYiccLDnNkKJ6opZ0W5eFzp4Zp5yyJeElmYnljdMn5
         E1q8+HLcGxWx36ycGlF7VH92IYUi7KtBvT3JZm8PRwfl4mK/6uQ7dJjhM08kHZUt23iI
         IBkHzhyUO7E1uDA3I4LLRAMp8cyTfuFSboDv9Q00Ed8Orv00DtGr8RBNWYAsLrQUGl+F
         asoIg9ZaRsNJtWRqjI7UZURqSaHbjGlnzu1PR0jxX8iFAXTj2gkiurZJRT90NIMsiXzJ
         ymWZUAwEuovW8CN+68hrWujpo5TEjxkjpSOm1lWms12aZrtt4pPgPWQMCs7296z9NbXv
         vxYA==
X-Gm-Message-State: AOAM531gBqziT3n1JAXf+iaLELRsXwAcBqN51dtNXSjQ9ixFIO/d/p3K
        1Osghw/tTFLAmXBpxVczdkG1hw==
X-Google-Smtp-Source: ABdhPJyuzEkE7dFzuOWFDkdd4xVdCuj8DDoi39proBdkUw6lKXK5xnrf67uJ25lDoXqZUJvxQLdYFA==
X-Received: by 2002:a05:600c:34c4:b0:38e:b628:da95 with SMTP id d4-20020a05600c34c400b0038eb628da95mr9011973wmq.150.1649692460341;
        Mon, 11 Apr 2022 08:54:20 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:d1:e096:d183:1bc5? ([2001:861:44c0:66c0:d1:e096:d183:1bc5])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm26066633wmq.27.2022.04.11.08.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 08:54:19 -0700 (PDT)
Message-ID: <a4bc92f8-1d10-84bf-00d9-fd2c22dacd55@baylibre.com>
Date:   Mon, 11 Apr 2022 17:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO pin
 labeling for CON1
Content-Language: en-US
To:     Guillaume Giraudon <ggiraudon@prism19.com>, kernel-dev@prism19.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220411144427.874-1-ggiraudon@prism19.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220411144427.874-1-ggiraudon@prism19.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 16:44, Guillaume Giraudon wrote:
> The labels for lines 61 through 84 on the periphs-banks were offset by 2.
> 2 lines are missing in the BOOT GPIO lines (contains 14, should be 16)
> Added 2 empty entries in BOOT to realigned the rest of GPIO labels
> to match the Banana Pi M5 schematics.
> 
> (Thanks to Neil Armstrong for the heads up on the position of the missing pins)
> 
> Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
> 
> Signed-off-by: Guillaume Giraudon <ggiraudon@prism19.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> index 5751c48620ed..84489525c75f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> @@ -437,6 +437,7 @@
>   		"",
>   		"eMMC_RST#", /* BOOT_12 */
>   		"eMMC_DS", /* BOOT_13 */
> +		"","",

Missing space after first comma, will add while applying.

>   		/* GPIOC */
>   		"SD_D0_B", /* GPIOC_0 */
>   		"SD_D1_B", /* GPIOC_1 */

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
