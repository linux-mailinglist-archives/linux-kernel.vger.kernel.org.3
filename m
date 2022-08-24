Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A8E59FAA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbiHXM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbiHXM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:57:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D6395AEA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:57:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d9so278454ljl.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nqd2a1NkKDVUdWFX24ptHpwYU9zy+QmGyakndaLPtWI=;
        b=MFOuZmrAEsufXG+4mt2PNk4yf67B1k3ZxWchVBK0of2qgtPBlubt0Y1zK5CPAryzL8
         J7jfMXXWFf3MFTbki8eoh0/c3kkFz1JaAamh5Nbx6u5TgmKYRAoEE805aqK22VB35vMJ
         cC3EAgs5sbdCpAePy/1QV/AWLUKnvDjSCi4E9XHSe6zTY8rTTQDFktTdkqGvqwEIEOlB
         3CY+c2cGzrEVGtewWHPfBvPndrbQfqj+8sJQZ4kU+Q91WWNvDb4eW9nx7qmC5P9EAGsx
         FNHl/NLN1Z2HK02hko1fWiBH7WMjn0qjUqbeWCWLfaeeZnyTbdybmHsbo/UbZDOmZE22
         MzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nqd2a1NkKDVUdWFX24ptHpwYU9zy+QmGyakndaLPtWI=;
        b=RIH7D39qwmRtU6oIbI/InLOU+rtsioH2T4GUdrdWq++5kdL+xlbOfpsYM6oWYuWQGx
         1Sra8RauFeFB4Tt+gmV+58PXWqaVzkaXGZZcsvgF51RysNYweKiGBqNt2MGTViT7+khD
         S1C9MBy7rOIxes4q6Hoy/AuuhmJG9e1uhjpVK+P616vA/f6VvBYd8XgUhk0U+GRs6Twp
         TWqMSrnqUzPbe1gTgdp2U/B8ydIKcFTJ/NAXYDnysfHLoFSytTcMEWWn2CL9qlNdaz3/
         +jJSH5SJcsj0ZLhOvbZCJzCCuLEvfFZY6FreRLKcLyqfOonlldwqJ/Bh6mh/IUXniEYA
         OhTQ==
X-Gm-Message-State: ACgBeo3ulZzERIQS2lMRoTk3ZevU8P9RFeMvDlOisL1hSKNr1scEvfwf
        UPnug7OTXemG3r9oWajhTn3pvA==
X-Google-Smtp-Source: AA6agR5jk3yzkhq/+4BfJtrOJ6VyWGEy/RIkF8YQnAiBBUgm7uMruWxiEpFWcax5/+jPQMi2MnRUXQ==
X-Received: by 2002:a2e:700f:0:b0:261:c6ff:476c with SMTP id l15-20020a2e700f000000b00261c6ff476cmr5215634ljc.493.1661345861888;
        Wed, 24 Aug 2022 05:57:41 -0700 (PDT)
Received: from [10.243.4.185] ([194.157.23.230])
        by smtp.gmail.com with ESMTPSA id a14-20020a05651c030e00b0025e728764ebsm2404858ljp.105.2022.08.24.05.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:57:40 -0700 (PDT)
Message-ID: <09308102-f927-125e-4321-d231decbd6c9@linaro.org>
Date:   Wed, 24 Aug 2022 15:57:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/4] bindings: firmware: Update binding doc for the zynqmp
 afi config node
Content-Language: en-US
To:     Nava kishore Manne <nava.kishore.manne@amd.com>, git@amd.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, ronak.jain@xilinx.com,
        rajan.vaja@xilinx.com, abhyuday.godhasara@xilinx.com,
        piyush.mehta@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        harsha.harsha@xilinx.com, linus.walleij@linaro.org,
        nava.manne@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-4-nava.kishore.manne@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824035542.706433-4-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use subject prefixes matching the subsystem (git log --oneline -- ...).

"bindings" is no correct.

On 24/08/2022 06:55, Nava kishore Manne wrote:
> Updates binding document for the zynqmp afi config node to handle the
> PS_PL Bus-width and resets.

Use imperative language:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml     | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> index f14f7b454f07..9504665cad95 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> @@ -59,6 +59,13 @@ properties:
>        controller.
>      type: object
>  
> +  zynqmp-fpga:

Just: fpga

> +    $ref: /schemas/fpga/xlnx,zynqmp-afi-fpga.yaml#
> +    description: The Zynq UltraScale+ MPSoC Processing System core provides
> +      access from PL masters to PS internal peripherals, and memory through
> +      AXI FIFO interface(AFI)
> +    type: object
> +
>  required:
>    - compatible
>  


Best regards,
Krzysztof
