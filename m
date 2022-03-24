Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D24E6811
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352422AbiCXRsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbiCXRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:48:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C8B2471;
        Thu, 24 Mar 2022 10:47:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n35so3174713wms.5;
        Thu, 24 Mar 2022 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RpJJksH0wfu/m1hwkaHpI10R0iz63qY9JlRehAsmSG4=;
        b=beKod+HfMm0Bku5wtAVpyK+e9L2eGDgfyGQ8e9UbBgGSjnu7zlrGA5uR/c49Ndjbw8
         J3+HUUaHI3dwNQWFXzMLGxwSl+eL95Pe0KjHzYSHfvsIRH2X3PFkiekf5hSvZWpM/77I
         2JmQJ0P7/x8UAujhhJTc+8+f9Hgg8Xea5xROKP3lZlawf26HxUWhJUciens8hEc2qGTY
         vU/oE4F5QBJbUx20dy2nVwz+olJ8vOCrfLRBMRAp93z/uAD8jMY1CZ/th6bKRziC/Rqa
         zKSyC5ia/NEI3bNXkY+2qNlprabTePuB9si9yvrYNX8xgySHx1qVup7hQP40EfzwONAX
         2Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RpJJksH0wfu/m1hwkaHpI10R0iz63qY9JlRehAsmSG4=;
        b=Yzai6EoxFrc47IIc3lt5J8lRdzxWGv04DsmX1yoi1uwk0YqXVem/YKCBJICWrvhjrp
         WgpOzYI3j4ATLUhkwqWapwNmIlSnQ7PYRuK1XT539bipV/Q0bDCLZP7hhhGEcvldI2AN
         XAEXTH5Max+KRx/eqoMK7r6XlCM9zs3xgRXWo0tbQj2LQtMZkepTNpKY08bQavD7w6qo
         ZCKYOgLuwkr4rpC3E86sJ7q34BqB6ok+doykul/YzVpgO3ncl6qNrUSTzKEebM8g+6DO
         rSSXJD0CIp8EhLpFo9Tat3NZeK1KJjarQw9fjf35XP3RUDhxhUmrD32rTLRDHDNqWHmz
         I55Q==
X-Gm-Message-State: AOAM532mljEJQ2S0erS+YESxRXRNtuPOw3SeGcrXV0XPJ6utp+K8yvif
        FINiAA7UPPByCdXxhbOwGok=
X-Google-Smtp-Source: ABdhPJyTE3kGibu4AKZzVSRAmH3Y/noKIiLHxSXqmFeNwFfPhf2WonD+XppKjW3aV6MZN7M8s6Lhtw==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr15573294wmh.21.1648144020925;
        Thu, 24 Mar 2022 10:47:00 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm7180786wmn.46.2022.03.24.10.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 10:47:00 -0700 (PDT)
Message-ID: <9925aacc-104f-b5b4-dd9d-26a9950b392b@gmail.com>
Date:   Thu, 24 Mar 2022 18:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 11/22] arm64: dts: mt8192: Add efuse node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-12-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-12-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2022 15:45, Allen-KH Cheng wrote:
> Add efuse node for mt8192 SoC
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 75c21edccf85..6220d6962f58 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -937,6 +937,21 @@
>   			status = "disabled";
>   		};
>   
> +		efuse: efuse@11c10000 {
> +			compatible = "mediatek,efuse";
> +			reg = <0 0x11c10000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			lvts_e_data1: data1@1c0 {
> +				reg = <0x1c0 0x58>;
> +			};
> +
> +			svs_calibration: calib@580 {
> +				reg = <0x580 0x68>;
> +			};
> +		};
> +
>   		i2c3: i2c@11cb0000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11cb0000 0 0x1000>,
