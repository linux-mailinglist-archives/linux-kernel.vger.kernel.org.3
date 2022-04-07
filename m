Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8983C4F7EBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiDGMJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiDGMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:09:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CB3F47C9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:07:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x24so1175738edl.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RXZ9lKydxs9kO1JxJb9dd9FMIU/aXNoy++vgijFww0k=;
        b=fLD8z1WxhKcc6h+Y8bC7AhGku/THlFtrhKM2rXzhUBuY0kZjjS+0nP32uiXsbKo5/g
         khQVI75054BWUQlt5DPpOFfvB1C+p6Bg6JYLxddgQE2rlBw4T2ZAoRz1jur9dTuSv+4a
         PuPwoait6By0LinqVCigKsk27Pu1PN4dao0w9VO5oGnS21ll8SA/av/uBJlwRKY1Sa9T
         uPHNnqI9qcgn07ejmI3ZrgOto5D/UYJV+PRTfpGcbrBnPd44tF7LRqJuSl52TmPmcq1a
         KEn44H29T8tDkwyZrPS4ekqYz6E73UKuBcnVAcr7NeH3f5F/2pYyzup2hEtYL4f0Hy9M
         ATcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RXZ9lKydxs9kO1JxJb9dd9FMIU/aXNoy++vgijFww0k=;
        b=eLZ5h0peAZDHukPVNYKKJ1xAINFCXUyHu7bjDzWR5EAwn/fGT2GWQP0J8rvAO6J4bR
         F23s48VMmCDerBJNrzbCZovraiBdLYl85NuawBCHOAnGOCrPjBpVvAAtgflfzLIyjK/G
         BmID8mQ7jQ0eRXkC+3XJ6uz8o0sq/Q7yHQ9DvE4P888bnoKvIn2VgRmG9C9udZ3rPZV3
         HkcoYbDHFLJNbV1Dzr97Y/5HJt6qX0lhGaOiXi4dg4S7tcerT2r283TtR853DWPw9CDT
         7xsxEbIIY687G0mHy81CjcA5hibvXYLunauGmqyv1IBVRkOLSM8AaEwepSdXxg/BJKCo
         RWWA==
X-Gm-Message-State: AOAM532zlueb+9UIuvJU5V79TFzWWapD6okIyVMB/21zqGQ232y0B/U7
        nrBa+mhQXKnCid9oHujU0Kf2Gg==
X-Google-Smtp-Source: ABdhPJxY5BbGCb1UPDSfWzKyt1vTRnHHRckAjtmhaAzU6YN/28sHmSGj6JzYZN3UfrqHa7RW1CKLYg==
X-Received: by 2002:a05:6402:209:b0:416:5211:841f with SMTP id t9-20020a056402020900b004165211841fmr14082498edv.59.1649333254265;
        Thu, 07 Apr 2022 05:07:34 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b004197b0867e0sm9133959edv.42.2022.04.07.05.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:07:33 -0700 (PDT)
Message-ID: <01250e59-eb49-43fb-666e-c1592d9dc922@linaro.org>
Date:   Thu, 7 Apr 2022 14:07:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ARM: dts: lan966x: Add QSPI nodes
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        arnd@arndb.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        alexandre.belloni@bootlin.com, olof@lixom.net, soc@kernel.org,
        nicolas.ferre@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        tudor.ambarus@microchip.com, Manohar.Puri@microchip.com
References: <20220407105835.10962-1-kavyasree.kotagiri@microchip.com>
 <20220407105835.10962-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407105835.10962-2-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your patch. There is something to discuss/improve.


This should be sent with your DT bindings patch in one patchset.

On 07/04/2022 12:58, Kavyasree Kotagiri wrote:
> LAN966x SoC supports 3 instances of QSPI.
> Data and clock of qspi0, qspi1, qspi2 works upto 100Mhz.

s/upto/up to/

> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  arch/arm/boot/dts/lan966x.dtsi | 48 ++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
> index 7d2869648050..b3c687db0aea 100644
> --- a/arch/arm/boot/dts/lan966x.dtsi
> +++ b/arch/arm/boot/dts/lan966x.dtsi
> @@ -196,6 +196,54 @@
>  			status = "disabled";
>  		};
>  
> +		qspi0: spi@e0804000 {
> +			compatible = "microchip,lan966x-qspi";
> +			reg = <0xe0804000 0x100>,
> +			      <0x20000000 0x08000000>;
> +			reg-names = "qspi_base", "qspi_mmap";
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks GCK_ID_QSPI0>;
> +			clock-names = "gclk";

This is not correct with the DT schema.

> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(0)>,
> +			       <&dma0 AT91_XDMAC_DT_PERID(1)>;
> +			dma-names = "rx", "tx";

This as well.

You can test schema with 'make dtbs_check DT_SCHEMA_FILES=...."
(check the docs for help what is needed to do it).


Best regards,
Krzysztof
