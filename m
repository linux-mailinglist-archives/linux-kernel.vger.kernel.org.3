Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689C4590EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiHLKIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiHLKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:08:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864D0A6C26
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:08:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d14so668036lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XiuPovkOS+97bdIezfgaSELX7apRbPfn23zXTyCPRYk=;
        b=WK+XalqL9DhlZk4XXCNjIasm1v6PShzJ0j1k6NNDg2OA/sTrwKqxKyOeR30qVU8KSm
         oB6RcyAI+rgp/qomDS50vXsRvpgGMU8hYFCIKZ3rfvns7CeJy2kHl5nUhkq1YWlyvy27
         cvJnc0yE450p5CX/WPDXWB4MfItwVfRLOwl3ssTIJXwq977JkU3V7JMXU4eLy/Ci12Qz
         r+M3dyeG4GbLhWugWVKe+0EYYXQUNTT8CrLnzFgZwYk0ZEaw2xK4AxdnaXwoNqV/KM3o
         i62cojAHPISkcXI02zlCcfMeFmW2uytivQyJBlzVmi+Lc29iczuX09DG6ucdy0IJXNf8
         Bvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XiuPovkOS+97bdIezfgaSELX7apRbPfn23zXTyCPRYk=;
        b=aaqmtawbgIeNC3g9WDDDvxanoOcuCAErCQMhIyQHpwUK6zJkYkam03oRuQsiW0zg77
         F5JgJZi3ZOpHyIHzv4Y4G0t7FX3/ZR61xHvR/ECDgTZiX96vIsHqBljrks5fMdbOPCrb
         AdbXlk7sRLt00vfs6Ee/FJXnlVFTPUGg3Ap2s7dJW9HfxwoRewnHO9gymd+NBU/RO8VD
         7ClmIQJ4VerMhx8HAL1K6x3sNto6YzuXQJ6Dwg4/INZFAoYLzW6dGYDuL/t70WiQ/Jdo
         Xy35AQ68kr20xMHDZhVYmoHXgqiEOPEVrkq5tL/eeyrANrJ8U25nULSsRTv+4bryURdj
         gdmQ==
X-Gm-Message-State: ACgBeo0NaTWa1nx4G2x3k4G5CiHvAxmYhWWtz1Zy191nG06Boc1or1cx
        t6P6WjN4oZTsU7W59whVHU+OLg==
X-Google-Smtp-Source: AA6agR4LZIMe34S+FTwy2eQTrI+Qal/bV+LtzQk8TenlMIk3y8r8aBndkPCQ4cyu0M3CJBKoNOY/ZA==
X-Received: by 2002:a05:6512:3e07:b0:48b:131:616 with SMTP id i7-20020a0565123e0700b0048b01310616mr1154422lfv.475.1660298911903;
        Fri, 12 Aug 2022 03:08:31 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id z19-20020a05651c11d300b0025dfd2f66d6sm303951ljo.95.2022.08.12.03.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:08:31 -0700 (PDT)
Message-ID: <f64a1e5e-d2be-68d7-9bca-de03de6ddbfa@linaro.org>
Date:   Fri, 12 Aug 2022 13:08:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/7] arm64: dts: imx93: add blk ctrl node
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220812074609.53131-1-peng.fan@oss.nxp.com>
 <20220812074609.53131-5-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812074609.53131-5-peng.fan@oss.nxp.com>
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

On 12/08/2022 10:46, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 BLK CTRL MIX node
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index dd76472ced46..55f396723adb 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -112,6 +112,11 @@ aips1: bus@44000000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> +			anomix_ns_gpr: blk-ctrl-ns-anomix@44210000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +				compatible = "syscon";

No, syscon alone is not allowed.

> +				reg = <0x44210000 0x1000>;
> +			};
> +
>  			mu1: mailbox@44230000 {
>  				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
>  				reg = <0x44230000 0x10000>;
> @@ -174,6 +179,11 @@ aips2: bus@42000000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> +			wakeupmix_gpr: blk-ctrl-wakeupmix@42420000 {
> +				compatible = "syscon";

Ditto


Best regards,
Krzysztof
