Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678DE4FBEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347169AbiDKOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347406AbiDKOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:22:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9452F021
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:20:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so83674wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=S3YV2NIKgVjmZIL+6HS0Sw9C7j5q+F7McJiN2a27ARM=;
        b=20ghj2lAKcSKoDLZ3O4IapS5ROMbvgbH9y83HJAP2vg5rlqfo+7fgfQl/xaG2Z6xCB
         vDsq9pLsiPeg3lUfzhbbNcnFfgv5c1iNz4qThO6N6Pi0FD8qjlup/Cgs70dwHM2eEAgk
         hqZIXj6Ot5j8w/0MMsqzxVcJZ5Rz1Vqibe7mz0E/4AAPZPcoLKGcnVMUDQes+d2ZyBmf
         jLYpFGwCPesKMISlCF84rw09wqq358l854W0OgVXxcUwh6ukhBdGft368zSvbmwuuQ7r
         KTaSYOY221gtQYfm3VWVACE9sR6Cx8ZYXCu+g4fsxydNr5oWJzdod0Ey1rWPgfVMO7j3
         HCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=S3YV2NIKgVjmZIL+6HS0Sw9C7j5q+F7McJiN2a27ARM=;
        b=B88ApIQbmur0s2hJGqfd6hcGF8r5/SJmp093wesUZ5QV70Frnv7ggfTDVJIdmM2jI2
         Oq8mL7/AvqulyFXVefBAQa2ruaSzH7HKRfveDN+LQcXUkZBSVll2tiwwu9WGinFwRy8s
         2pJmV3d4t4OVbR4vFDY6gTCykA5xluwTQtebM9OAnr/sVIjrTBxf2Afgm4gf6oJjjq9p
         AOqams6zNWgAipJOdnQPvWPyR9sImPDr0Oy4X6AjsbJI7NB0kpzEfHEAoYh4Q5h9n2DK
         Mqq35ny2mE445nzFsloPqjM7kmQVRrAk+IYnbKcZmXi7VzrxtXapuEFXec1b2rnSE29X
         Lrnw==
X-Gm-Message-State: AOAM530UtXkVt7fZNGlvZNwbUD5JLk1oqMDL75rF0yQNtC93Z6qXoJTR
        43BXkgnIVae1uzTApx4fQs+msQ==
X-Google-Smtp-Source: ABdhPJz4l3beiVULnQnS8K5T65hNj8lZdcPe3356nB8I4dOfBr0ZFNRG6vebaEI++CwpGxdZPwvo5Q==
X-Received: by 2002:a05:600c:3546:b0:38c:a8ff:843b with SMTP id i6-20020a05600c354600b0038ca8ff843bmr29729336wmq.24.1649686839724;
        Mon, 11 Apr 2022 07:20:39 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:d1:e096:d183:1bc5? ([2001:861:44c0:66c0:d1:e096:d183:1bc5])
        by smtp.gmail.com with ESMTPSA id k124-20020a1ca182000000b0038eb706c030sm4974012wme.39.2022.04.11.07.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 07:20:39 -0700 (PDT)
Message-ID: <8bde8ee2-ee3f-bba6-66da-28adb3897178@baylibre.com>
Date:   Mon, 11 Apr 2022 16:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO
 pin labeling for CON1
Content-Language: en-US
To:     Guillaume Giraudon <ggiraudon@prism19.com>, kernel-dev@prism19.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220411140401.450-1-ggiraudon@prism19.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220411140401.450-1-ggiraudon@prism19.com>
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

Hi,

On 11/04/2022 16:04, Guillaume Giraudon wrote:
> The labels for lines 61 through 84 on the periphs-banks were offset by 2.
> Realigned them to match the Banana Pi M5 schematics.
> 
> Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
> 
> Signed-off-by: Guillaume Giraudon <ggiraudon@prism19.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> index 5751c48620ed..754c3d43ef0b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> @@ -448,7 +448,7 @@
>   		"",
>   		/* GPIOA */
>   		"", "", "", "", "", "", "", "",
> -		"", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
>   		"CON1-P27", /* GPIOA_14 */
>   		"CON1-P28", /* GPIOA_15 */
>   		/* GPIOX */

While reviewing more closely I figured that in fact the issue comes
from the :
		/* BOOT */
		"eMMC_D0", /* BOOT_0 */
		"eMMC_D1", /* BOOT_1 */
		"eMMC_D2", /* BOOT_2 */
		"eMMC_D3", /* BOOT_3 */
		"eMMC_D4", /* BOOT_4 */
		"eMMC_D5", /* BOOT_5 */
		"eMMC_D6", /* BOOT_6 */
		"eMMC_D7", /* BOOT_7 */
		"eMMC_CLK", /* BOOT_8 */
		"",
		"eMMC_CMD", /* BOOT_10 */
		"",
		"eMMC_RST#", /* BOOT_12 */
		"eMMC_DS", /* BOOT_13 */
		/* GPIOC */


it contains 14 entries, but there is 16 BOOT gpio lines.

So instead, send a V2 with 2 entries added in BOOT and leave the GPIOA entries as-is.

Thanks,
Neil
