Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04454DD947
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiCRL5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiCRL53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:57:29 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48CE10429C;
        Fri, 18 Mar 2022 04:56:06 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id bx44so4480890ljb.13;
        Fri, 18 Mar 2022 04:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LpBDuSYRfhCjN2rL91mRm+RnyEuqAx1X5cQe2gIQXvU=;
        b=pRUCnvYyE/VQbf9w/9SrFBLsuH43ScruqwEGCJZXCXUEoTGqYTh+T7wC2xOkbRUcX4
         BRRGlOOI8uWZJAvZbYVg3lAIjwQeViCKVkwd9w6UzBIRG+wsDBW6WqUXqObc5XB0p0Jl
         yKs2hXLEaG9JMHVkZBGa4azqyHDDG+Gd2KTwl07rpO/+4mZkI7+VWMAFXAb+eucVq3Ef
         QN+SWrne0vNHWG+9ZAu0xWuktdLL58fznepB/SrwTLvOy+IOSFJCH35c/QrosVoWWdju
         mGz2/MBH+UKFZ7gMbFIvSxUKvnCIX59SiSiYPjl7N3xsVS9OUnFKK5581W093gZQ47KD
         R43Q==
X-Gm-Message-State: AOAM530RPArbQ4aTXBB7/kqm+qiszeQRYI0wSZQYYmXvsgLDuZMtEjEm
        GpFDBmdLVmWk57jIzDt/0UM=
X-Google-Smtp-Source: ABdhPJwXxt19VE3E+LR/+1rHtFn/71OmpD0icPdohgbhWWTOiDk8Ulkt/mFgVGq4Zi2NlGCvJlo+Uw==
X-Received: by 2002:a2e:9bd7:0:b0:248:ca3:ecf1 with SMTP id w23-20020a2e9bd7000000b002480ca3ecf1mr6179171ljj.66.1647604564930;
        Fri, 18 Mar 2022 04:56:04 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id a11-20020a194f4b000000b004482e94a3b1sm819762lfk.19.2022.03.18.04.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 04:56:04 -0700 (PDT)
Message-ID: <df985bc1-bb99-9623-ad78-b77329b8eba7@kernel.org>
Date:   Fri, 18 Mar 2022 12:56:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: imx8mp: add ddr controller node to support
 EDAC on imx8mp
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Dinh Nguyen <dinguyen@kernel.org>
References: <20220318113526.15986-1-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318113526.15986-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 12:35, Sherry Sun wrote:
> i.MX8MP use synopsys V3.70a ddr controller IP, so add edac support
> for i.MX8MP based on "snps,ddrc-3.80a" synopsys edac driver.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 794d75173cf5..a6124a11d6ee 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -902,6 +902,12 @@
>  			interrupt-parent = <&gic>;
>  		};
>  
> +		edacmc: memory-controller@3d400000 {
> +			compatible = "snps,ddrc-3.80a";
> +			reg = <0x3d400000 0x400000>;
> +			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;

This is not correct according to the bindings. Dinh's commit adding the
compatible might not be correct, so please first fix bindings.

While fixing bindings, order the compatibles by name (s goes before x).


Best regards,
Krzysztof
