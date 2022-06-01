Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471E453A12B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347160AbiFAJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351430AbiFAJr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:47:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C969F4EA3B;
        Wed,  1 Jun 2022 02:47:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h5so1589592wrb.0;
        Wed, 01 Jun 2022 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CKOCWfdmOOI9xdIls2//FVypVbNOjkaoePDp+LmHECs=;
        b=bF66OCt1fmRCDaA+t4Tc507PLEIL5n22wKaPSZPBdiX9tCrzxa03BOfjkj3XwWUeoe
         5AKv9GYjATj/PtsucfdqvJw4HTXAZorhMpdX1OFjbc0MwP5xhWjZGkd+2lBI2e6Kntn7
         V3HosqigOpF+m9AFbukSpzI4ELDZZ/tArGScy2BoP1VPHm1CLszlKwRd6Ke2PhGiFDX7
         HWO8tlKeds0V49+PMDQKhbyrvfKQk5gUb1LnqOPAqeKeluSEkv2kl+MFeIsM3F3YuKpY
         kObCcW8gvera8uEaPBa17VFwPcCxv4iKWXeut+pXJharcOmyY0QEmgRGBCiy7HykIFNG
         ekHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CKOCWfdmOOI9xdIls2//FVypVbNOjkaoePDp+LmHECs=;
        b=BPPAWk9JcxjxnouTH5LMAKuXcmygOR4FjuBAHWV2/hXJsqtzA2Dzc8Gsdgwe9Y6xf8
         rrqrzVJXNIbpK0DDjQrFRcDC3A2rtqBfWKQ2iDeXaAlULeKjbcbLUajWkNejjTueKUjy
         C64qkJnwX1egLvna3Ft0HVNDIep14pIemwMkAnjVxwqXkaHOA2mfOG+uPpVTafHRP9P+
         l5kuoWX6k5AqeglWi2tZn+pmE8goQdko+aL14A02LRNuVeWuE3mZS3nRKqVB+tFLMoic
         bKH1xHLqUjUUqw3gaOM/WS4XhbxPpGGOkw3ZRnT2oI4Ay517lz9KbE/MWMVVpMnQf9N8
         IECA==
X-Gm-Message-State: AOAM531d1XP7uK4iS/X01sUQJZur71T9J55kcdaKYCLXlKHNq7ZwCeyL
        P/vLMgaLUOQjx8SMDNFIRko=
X-Google-Smtp-Source: ABdhPJzJw3e/qEJAYVU4JAED1FujPkMVrsu7b6xncg93Ro2/8ItNX0kIqnBW5tB+W+IbYS0vDNlbxg==
X-Received: by 2002:a5d:6984:0:b0:210:e15:9a7b with SMTP id g4-20020a5d6984000000b002100e159a7bmr24357441wru.30.1654076830023;
        Wed, 01 Jun 2022 02:47:10 -0700 (PDT)
Received: from [192.168.1.101] ([160.177.66.137])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d4a8f000000b0020c5253d8edsm1078356wrq.57.2022.06.01.02.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:47:09 -0700 (PDT)
Message-ID: <0b4abf17-f44d-dec4-56f4-0ae12e49b05b@gmail.com>
Date:   Wed, 1 Jun 2022 02:47:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] arm64: dts: add dts files for bcmbca SoC bcm4912
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     dan.beygelman@broadcom.com, philippe.reynes@softathome.com,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601004244.27394-1-william.zhang@broadcom.com>
 <20220601004244.27394-3-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220601004244.27394-3-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2022 5:42 PM, William Zhang wrote:
> Add dts for ARMv8 based broadband SoC BCM4912. bcm4912.dtsi is the
> SoC description dts header and bcm94912.dts is a simple dts file for
> Broadcom BCM94912 Reference board that only enable the UART port.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

[snip]

> +
> +	axi@81000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;

See comment below for the ubus node.

> +		ranges = <0x0 0x0 0x0 0x81000000 0x0 0x8000>;
> +
> +		gic: interrupt-controller@1000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			reg = <0x0 0x1000 0x0 0x1000>,
> +				<0x0 0x2000 0x0 0x2000>,
> +				<0x0 0x4000 0x0 0x2000>,
> +				<0x0 0x6000 0x0 0x2000>;
> +		};
> +	};
> +
> +	bus@ff800000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;

This does not quite make sense, as I doubt that this part of the bus is 
64-bit capable, rather, I would expect to find both #address-cells and 
#size-cells to be set to 1 and ... (see below)

> +		ranges = <0x0 0x0 0x0 0xff800000 0x0 0x800000>;
> +
> +		uart0: serial@12000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x0 0x12000 0x0 0x1000>;

... have this become simply:

			reg = <0x12000 0x1000>:

which also looks awfully big for an UART block, an entire 4KB worth of 
register space?
-- 
Florian
