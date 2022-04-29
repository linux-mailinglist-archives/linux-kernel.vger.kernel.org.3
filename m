Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E279514C64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377157AbiD2OLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377130AbiD2OLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:11:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A4A31342;
        Fri, 29 Apr 2022 07:07:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p7-20020a05600c358700b00393e80c59daso5380916wmq.0;
        Fri, 29 Apr 2022 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F6U0EkqCPsQHAJyvN7uVwZZ/NZlhtUREfzw+eDMOBxU=;
        b=FgBhORL/bHYdqcOTfAOYXjVyqsNMi4ftyxMRwi5DSgY5L0D2OPSFQXG5eXFPAM1evK
         Re0fEJ45kGwAkXIw36ceyZt1hGE8GbtTvD9B3pC2EwbY9M5aya0oybJf6AP31aGHr5np
         CH2OOSQzsSUQIpWT/mV/3CYU1Rwu2yzlrV5GmzNc61ajON2A4+yo5dT1srOb5eUHbns7
         0IbUZRn613u1SrHKDoAkYd9Y+hGvKxafwv8pOsUavd4YSlxMiCXAMgztJz/1RqYtuCS4
         kMmX01NwGxziPRVDnPZN7k5Hn4HKUqj3pFmKrsoADJJoZpJHbCkYpxwEBX1yubDzNzf+
         4C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F6U0EkqCPsQHAJyvN7uVwZZ/NZlhtUREfzw+eDMOBxU=;
        b=GZOCnwjtaSXbbBtPKxP2iWtWWwuZO+boiyVGmfRnIghBVNVsHBgqLbToEH7Ap++pSu
         bypHkxve5WLE5k2+AG5C7B5OTIQAQDsgBmIWHVeBMqyguVFFgb5eLBrMHgmhSk/OSjAl
         3Eb7sAbs3vX52xP/3WUMmx127McSAVM6zkOoFuqI2gA+HIcFfRtwfKQ8H374JEPfe6ca
         5laaFt3VVC1FiFoqovorbJ/fKolk2ztPDSK/UTDcYcEE8yHzF61r2wM3aFENrZtNur3H
         ewqY1H9kLA98gtLJFGHipvqkOa769rQbAygdmkfi470vvYn4jv13g+hxRyqUE/LfCw3X
         jkKA==
X-Gm-Message-State: AOAM533kO4kMLKRBUl5fng9VZoSSOxRw1RQl37msUdYflu9ddS0qJgWV
        nGx97fown3jAjNTaM/sbxKE=
X-Google-Smtp-Source: ABdhPJxgo3nsWAeqRx16WilGR5Kx+5rmyDRvK20doz+vPEmTvwA8MNy6ugVxIjkZs01TFSvmOlipLQ==
X-Received: by 2002:a1c:f606:0:b0:394:1a21:f68c with SMTP id w6-20020a1cf606000000b003941a21f68cmr3380937wmc.131.1651241236731;
        Fri, 29 Apr 2022 07:07:16 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0020a992ce36esm3230764wrc.1.2022.04.29.07.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:07:16 -0700 (PDT)
Message-ID: <6aa03759-9027-4841-9ad1-84cbc19fcb00@gmail.com>
Date:   Fri, 29 Apr 2022 16:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 5/5] arm64: dts: mediatek: add mtk-snfi for mt7622
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
References: <20220424032527.673605-1-gch981213@gmail.com>
 <20220424032527.673605-6-gch981213@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220424032527.673605-6-gch981213@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/2022 05:25, Chuanhong Guo wrote:
> This patch adds a device-tree node for the MTK SPI-NAND Flash Interface
> for MT7622 device tree.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied, thanks!

> ---
> Changes since v1:
>    1. use the newly introduced nand-ecc-engine instead
>    2. reword commit message
> Change in v2-v6: none
> 
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index f232f8baf4e8..8c2563a3919a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -545,6 +545,18 @@ nandc: nfi@1100d000 {
>   		status = "disabled";
>   	};
>   
> +	snfi: spi@1100d000 {
> +		compatible = "mediatek,mt7622-snand";
> +		reg = <0 0x1100d000 0 0x1000>;
> +		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_NFI_PD>, <&pericfg CLK_PERI_SNFI_PD>;
> +		clock-names = "nfi_clk", "pad_clk";
> +		nand-ecc-engine = <&bch>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
>   	bch: ecc@1100e000 {
>   		compatible = "mediatek,mt7622-ecc";
>   		reg = <0 0x1100e000 0 0x1000>;
