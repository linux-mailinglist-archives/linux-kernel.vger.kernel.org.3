Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F222F4E6357
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350200AbiCXMac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbiCXMa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:30:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F20A94EC;
        Thu, 24 Mar 2022 05:28:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w4so6386242wrg.12;
        Thu, 24 Mar 2022 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0ov3ZR+ak5DEDpTymdl0/BQjBNtuGJXsPc9qEMjlbkQ=;
        b=hVtw6rp+xuX0d32ARb62dUhqM4R3VC5pofs48O+4O920vt8CSq/sMLpt+8+LAZTn6e
         VIElYkUtW8LSN1yoQMFd2i9puNjj5gYEvYDBOb3SSsgi3tPQAHlmFxSvRgtvszbt6FyO
         NmOZEEZDK1GdAONx5AAxdMlRMLuKDF0uAD55768LvcmNbHzBYo4INUMN+su5fvumLCJ1
         7ktrUpLJEE/CMXKFSi0V3hAuB4a5tjC8+ZX/61G0VwG54/3FBkrPk9WXLZmeRHMYXL8P
         XdaRpRUztUdXn2sXDoBLQN3klBO9J8OPo2ShA+q9B8maZSx5U5yC9a+7/BJ9zNKLqQix
         g6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0ov3ZR+ak5DEDpTymdl0/BQjBNtuGJXsPc9qEMjlbkQ=;
        b=JIE/7IGhW+VHth6LxugJU6ZeMFGOdKbfrvRmH5mPN01Fgao3WWDa6r9+9kJ4GVJv3f
         v63iKoRTIvxt7ebaCYhR/C+nvYXTv089dWMN9/daWb+Ta8Xi6uts7dwrdYlNXyiqQpHx
         l3LfeYGamFbhV0P5URFwusEU3EE1pDiU4Y5QSHdqWC8cPOtSNqrkGwCxLh+7Dwqsh7f/
         2ZEj4WhnukhbXCnnQcLahe5heS+MUWaJNfiPmMkKt6vhxwT/mafGqodH2o8keKSYLcEX
         8L0bpmTcQRxMltzTGD7VcPCQEcp7moW88LjUd0B10nRpWf4Bgxvbrs1Kbw6FWWiCVsS+
         W3Hg==
X-Gm-Message-State: AOAM5330URMBCb+Z5MS+DxsL6+K393gROTNGF8T1dmTEjQPYRtvIGMgQ
        5UTizzDOGxBG9+Qrsudn5wg=
X-Google-Smtp-Source: ABdhPJzsygHW9SyBpZIAEvN/v/Oz7TkRtXHqmlOfpcjumaG0XM8yQr5RnjRWRQydHA0frLg8LXHT8A==
X-Received: by 2002:a05:6000:168e:b0:204:fe5:a55 with SMTP id y14-20020a056000168e00b002040fe50a55mr4282985wrd.453.1648124936591;
        Thu, 24 Mar 2022 05:28:56 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm3913847wri.0.2022.03.24.05.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 05:28:56 -0700 (PDT)
Message-ID: <0bd165e6-6d2c-7586-44c3-9c257843600f@gmail.com>
Date:   Thu, 24 Mar 2022 13:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 05/22] arm64: dts: mt8192: Add usb-phy node
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
 <20220318144534.17996-6-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-6-allen-kh.cheng@mediatek.com>
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
> Add xhci node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 195d50894df4..28b93b76fe17 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -875,6 +875,28 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		u3phy0: t-phy@11e40000 {
> +			compatible = "mediatek,mt8192-tphy",
> +				     "mediatek,generic-tphy-v2";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x11e40000 0x1000>;
> +
> +			u2port0: usb-phy@0 {
> +				reg = <0x0 0x700>;
> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +			};
> +
> +			u3port0: usb-phy@700 {
> +				reg = <0x700 0x900>;
> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +
>   		i2c0: i2c@11f00000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11f00000 0 0x1000>,
