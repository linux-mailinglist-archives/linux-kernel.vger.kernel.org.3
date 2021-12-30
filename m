Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE3481C40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhL3Myu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhL3Myt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:54:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A4C061574;
        Thu, 30 Dec 2021 04:54:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j18so50295780wrd.2;
        Thu, 30 Dec 2021 04:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YFsE9Hzd6Rw74/QWXyvFaT9SGHT235vGJZ7VH+X9Vqg=;
        b=j1/mXzn1nmea5RST1mMajHuWCuVWhRqN+Lg+syW8EQjxxsP+3z/R93jwf8vgZWbZsm
         OcuVJ9XUPFPEAU9OtCF+ZwU71OGyQMuKXNmj1Jk9ebfSFlPExhHPMigoSVaJforhf6qJ
         MSrs2D6cozE43KuJe0O/r6SMBFCRBNmFMatKgoEH7XYm3mCx1BNX77iTI1GUfR0p3gq4
         tvNKAQZL15557qK/KTsRBQpJFU/bA6CtoGsG0s1HKrGsDf+LMsoSvwqw8ZP6GhC+jaNe
         hzqABqGTxll+o+q2ZW6rBTvjBRH1TaQ20zt2ZjIiL9k2BhLcnof9T1QFjiAB6uUXAa6m
         I6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YFsE9Hzd6Rw74/QWXyvFaT9SGHT235vGJZ7VH+X9Vqg=;
        b=LjxXxg/CDf7ZJ9poQDKh99O58i1YMr/qgmLIvdvTO609bVtBDiw2yWsvThbSshXz5x
         sfzlqjBzs/CDNOg2F8A1oVbvvnnp95pGbbk0btjKnPk9Bah/aC49OlLHJ+3w1YNuoYyO
         UBKgsKtBvGmoX/98WKSVbDajOVEwhJYkxfZyLtchMkuLPVc9tAH7Y8ypG0V5rHbKjo8g
         S4BFNI3RiPKkOQkC+InDBENo/XEMJjDL9e93WRxVzg8hqggq5qK6eGvpSgPY4VVaA0HJ
         3geSvLzB4J4xwwErEg6Y285ShyWpJJJz0TMuobQHXvX0dfOhabMsAmx1exCo9pyn+5jy
         r9nQ==
X-Gm-Message-State: AOAM533rrdOX6yO/zit2n2/tRaEUJ6c51bM8hHPhNOmfNnri970PLZ9b
        qSY2C6FLABl9L0oDF3Gr9LA=
X-Google-Smtp-Source: ABdhPJzPDe29tdWKwhekT4d7Z3/ncbk+zLexQx66U+rHmm1/X9HvJuKxKAeY5PKXovwjJaFWy4VXjw==
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr24876182wrx.189.1640868886447;
        Thu, 30 Dec 2021 04:54:46 -0800 (PST)
Received: from [192.168.1.145] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id j3sm23485981wrt.14.2021.12.30.04.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 04:54:45 -0800 (PST)
Message-ID: <20cf2c1e-d55b-5780-8c6e-4d8beaca5a65@gmail.com>
Date:   Thu, 30 Dec 2021 13:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v16 2/7] arm64: dts: mt8183: add svs device information
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210428065440.3704-1-roger.lu@mediatek.com>
 <20210428065440.3704-3-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20210428065440.3704-3-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2021 08:54, Roger Lu wrote:
> add compitable/reg/irq/clock/efuse setting in svs node
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 80519a145f13..441d617ece43 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -657,6 +657,18 @@
>   			status = "disabled";
>   		};
>   
> +		svs: svs@1100b000 {
> +			compatible = "mediatek,mt8183-svs";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_THERM>;
> +			clock-names = "main";
> +			nvmem-cells = <&svs_calibration>,
> +				      <&thermal_calibration>;
> +			nvmem-cell-names = "svs-calibration-data",
> +					   "t-calibration-data";
> +		};
> +
>   		pwm0: pwm@1100e000 {
>   			compatible = "mediatek,mt8183-disp-pwm";
>   			reg = <0 0x1100e000 0 0x1000>;
> @@ -941,9 +953,15 @@
>   			reg = <0 0x11f10000 0 0x1000>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;

Please add a new line between the different calibartion data, to improve 
readability.

Regards,
Matthias

> +			thermal_calibration: calib@180 {
> +				reg = <0x180 0xc>;
> +			};
>   			mipi_tx_calibration: calib@190 {
>   				reg = <0x190 0xc>;
>   			};
> +			svs_calibration: calib@580 {
> +				reg = <0x580 0x64>;
> +			};
>   		};
>   
>   		u3phy: usb-phy@11f40000 {
> 
