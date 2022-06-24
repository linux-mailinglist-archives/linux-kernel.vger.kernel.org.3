Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C4559E22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiFXQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiFXQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:01:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D2B52533
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:01:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i10so3790093wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ffiO6A2PsfBMr7NqXQDGe4LlsBtZjortKK8FGiE8TGs=;
        b=kgIGHkC9AmqJrRisa88gEb2JSgScN9bTHPrFYutqUu3j4EstnyWyH4Vt4PYgnr9wM7
         g1Jv7MXUI3WAB6EsQuB5VZz7SP0td1kZM8aHXB3334K4ewpr7f3MXm8FbbdOznRGguvS
         9npxt9kXyuL8dePxN4eNBJih2eAKLJYfnropKFhsxtJFb5vn9xZLZDaeLxxdOT+uhgu7
         3g9Tgk1Q4KU08dTsHPkDehTnAWTp6s9QGlC+C82CA4Ykt8mHcGCE9bINdYKZj0AXVxyb
         K3pJ1DpOKkUR6dPZXOp4lH/wfDAGpvVFshjIujmrGNIAff8cayGDyBrUKkUCR6/UtDUa
         54lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ffiO6A2PsfBMr7NqXQDGe4LlsBtZjortKK8FGiE8TGs=;
        b=1mIBFLzH+lInE29NbjK0pJMxEhz7UcZV1mPl0xJRMulDd/i3w4u7OVyH/Vi79oczS2
         so0qdmlPUbYOzzSq4vZenW6oR+zQc6sEbXpXLZS7dJUQmanQSAKH5JmSlgKa38V6wTm8
         PanSrhQORLkAsrmRYfAAFSzBjB2GbDGn+xlPIHPnXoWIESqY4ia3vKHS2+ydmj0HIhxp
         TROBLoNLiCKZy5AtfXdrfm+KVi9ATKhtnM7zKRcz+x0/XoXMzhLBWhrY32tvj9hge6X0
         HaCp+dGcUM5ikKpd5u1Th7stVusVyWvE7B022RYybNPHomvGVYhXFWH2M0zXhUsGII0I
         cydA==
X-Gm-Message-State: AJIora8mChnemURhyDIeBrl1zVwiAXnEi8+giXVUw3vywBf1NXGUckMp
        dyMMA2bkIIb5FhOUu2uT7PclLQ==
X-Google-Smtp-Source: AGRyM1vKGC5ccFr+1PSGrjWJ2Vn9gJPfJi5n/uVuZ8+6JKiJ9SiV5LkmBEgKYLw1Q+Ux8lewMHEdMg==
X-Received: by 2002:a05:6000:381:b0:21b:9a20:7edb with SMTP id u1-20020a056000038100b0021b9a207edbmr13997766wrf.71.1656086499812;
        Fri, 24 Jun 2022 09:01:39 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6551000000b0021b932de5d6sm2720639wrv.39.2022.06.24.09.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 09:01:39 -0700 (PDT)
Message-ID: <ac726845-01ec-4f35-7197-4c52fc483644@linaro.org>
Date:   Fri, 24 Jun 2022 18:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,micfil: Convert format to
 json-schema
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
References: <1655980125-24141-1-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1655980125-24141-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2022 12:28, Shengjiu Wang wrote:
> Convert the NXP MICFIL binding to DT schema format using json-schema.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,micfil.txt  | 33 ---------
>  .../devicetree/bindings/sound/fsl,micfil.yaml | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.txt b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
> deleted file mode 100644
> index 1ea05d4996c7..000000000000
> --- a/Documentation/devicetree/bindings/sound/fsl,micfil.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -NXP MICFIL Digital Audio Interface (MICFIL).
> -
> -The MICFIL digital interface provides a 16-bit audio signal from a PDM
> -microphone bitstream in a configurable output sampling rate.
> -
> -Required properties:
> -
> -  - compatible		: Compatible list, contains "fsl,imx8mm-micfil"
> -			  or "fsl,imx8mp-micfil"
> -
> -  - reg			: Offset and length of the register set for the device.
> -
> -  - interrupts		: Contains the micfil interrupts.
> -
> -  - clocks		: Must contain an entry for each entry in clock-names.
> -
> -  - clock-names		: Must include the "ipg_clk" for register access and
> -			  "ipg_clk_app" for internal micfil clock.
> -
> -  - dmas		: Generic dma devicetree binding as described in
> -			  Documentation/devicetree/bindings/dma/dma.txt.
> -
> -Example:
> -micfil: micfil@30080000 {
> -	compatible = "fsl,imx8mm-micfil";
> -	reg = <0x0 0x30080000 0x0 0x10000>;
> -	interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> -	clocks = <&clk IMX8MM_CLK_PDM_IPG>,
> -		 <&clk IMX8MM_CLK_PDM_ROOT>;
> -	clock-names = "ipg_clk", "ipg_clk_app";
> -	dmas = <&sdma2 24 26 0x80000000>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.yaml b/Documentation/devicetree/bindings/sound/fsl,micfil.yaml
> new file mode 100644
> index 000000000000..74c77f4cf7a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,micfil.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,micfil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP MICFIL Digital Audio Interface (MICFIL)
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +description: |
> +  The MICFIL digital interface provides a 16-bit or 24-bit audio signal
> +  from a PDM microphone bitstream in a configurable output sampling rate.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mm-micfil
> +      - fsl,imx8mp-micfil
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 4

You should describe the interrupts/items. Similarly to clocks.

Best regards,
Krzysztof
