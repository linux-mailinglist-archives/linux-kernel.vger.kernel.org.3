Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0FB486157
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbiAFITN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiAFITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:19:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09990C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 00:19:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q8so3183334wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 00:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AZChhdnX0YuKY0BMypmerxkK3KtsyiUpb0QZT6UqENA=;
        b=VO4dzc4B7SZ56DYc9RsQVTj2YckoUNgNXNrRsx4OkCuI/KuXWV+dp+csUeOh1kIuqY
         1XRVZP8bcTHhKQUtDa9CeWcNQLkDQyXdDxXkPSJST08TdqNpAIzFHqZQjaL19M8NQvRI
         L7WR9n0BIe5SL9RjNMwz/33GiN5rBYBFdK8//vmgCiBSA8u35OsllG+sLZ8vQKAxavhC
         qJ44+7WIzUwFNcn/xX8BkfUg2c2rfAAmjI5uum2vpBDldc+iI881IlsRnxKJQtaPsfqK
         os5Ke6OFwQwVK99lfeyzZ+wpdONSLvhlYqNHzaE+LvzAH5It03zyog0UOEPRoRF58Z+P
         bWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AZChhdnX0YuKY0BMypmerxkK3KtsyiUpb0QZT6UqENA=;
        b=AW9r1yR6+NOKIxu47zXIDthXkUks0bhAtVBfVKrtXajK72x+3ZpcnmoTC6dkKa1NkQ
         5MNNkO/goV5MGOsRfnXKx3ynz/mSoPV1kJRfcNGFCpmeBDehvo55GS8cpJPF92INS7xw
         kiqikobd6FG9Av+X4hZKxkRcpXalx7HIus+ZNyqO2vZMnbE3YTQZ7iJerCnpw5WVzys9
         w2KmylDGSKaOdW5M+4/WgV8lLp9yUJNF2Cvb8zt4PDT632QsJ424gLxxAZeseq5V1egy
         7qD8sSx4NboyYxNqkOxu6xP5x0QtV9ojoB/7I1oebAgNN8J5roYtU7dr/P5Yv67bIC4Y
         J0gg==
X-Gm-Message-State: AOAM531kbXTHl62QTwXE+eTkZm+c5Ue8DAvEhZ6G1h+8Lbz8XQCW8u/Z
        eNByEimq7bCZoKwMe7CdDccQzA==
X-Google-Smtp-Source: ABdhPJzmX3i843FH+Y7JbfwGB3nwKMKHvBSNhesub5FRG/49dtrtvh7mg/lJ29NWeNYkdzWqNa1ljQ==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr51143400wrd.179.1641457150469;
        Thu, 06 Jan 2022 00:19:10 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:cf72:3b19:5d45:871d? ([2001:861:44c0:66c0:cf72:3b19:5d45:871d])
        by smtp.gmail.com with ESMTPSA id y8sm1472208wrd.10.2022.01.06.00.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 00:19:10 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: nand: meson: fix controller clock
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220106033130.37623-1-liang.yang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <8439ec98-694e-0391-2a00-89e856024823@baylibre.com>
Date:   Thu, 6 Jan 2022 09:19:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106033130.37623-1-liang.yang@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/01/2022 04:31, Liang Yang wrote:
> Change-Id: I1425b491d8b95061e1ce358ef33143433fc94d24
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt        | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> index 5794ab1147c1..37f16fe4fe66 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> @@ -14,11 +14,6 @@ Required properties:
>  - clock-names: Should contain the following:
>  	"core" - NFC module gate clock
>  	"device" - device clock from eMMC sub clock controller
> -	"rx" - rx clock phase
> -	"tx" - tx clock phase
> -
> -- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
> -				controller port C
>  
>  Optional children nodes:
>  Children nodes represent the available nand chips.
> @@ -28,11 +23,6 @@ see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindi
>  
>  Example demonstrate on AXG SoC:
>  
> -	sd_emmc_c_clkc: mmc@7000 {
> -		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
> -		reg = <0x0 0x7000 0x0 0x800>;
> -	};
> -
>  	nand-controller@7800 {
>  		compatible = "amlogic,meson-axg-nfc";
>  		reg = <0x0 0x7800 0x0 0x100>;
> @@ -41,11 +31,9 @@ Example demonstrate on AXG SoC:
>  		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>  
>  		clocks = <&clkc CLKID_SD_EMMC_C>,
> -			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
> -		clock-names = "core", "device", "rx", "tx";
> -		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
> +			<&clkc CLKID_FCLK_DIV2>;
> +		clock-names = "core", "device";
> +		sd_emmc_c_clkc = <0xffe07000>;


sd_emmc_c_clkc should be documented, but it should be either:
- a syscon
- in reg

but since 0xffe07000 is part of the emmc memory space, you can't simply
put this address like that and pass it to a random undocumented property.

Adding "syscon" to the sd_emmc_c compatibles, and passing the sd_emmc_c node as syscon
could actually work.

Neil

>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&nand_pins>;
> 

