Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E0246517D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350895AbhLAP1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:27:06 -0500
Received: from relay08.th.seeweb.it ([5.144.164.169]:34701 "EHLO
        relay08.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350898AbhLAP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:27:03 -0500
Received: from [192.168.1.101] (83.6.166.111.neoplus.adsl.tpnet.pl [83.6.166.111])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8DF103F750;
        Wed,  1 Dec 2021 16:23:41 +0100 (CET)
Message-ID: <eb2373bc-f9f5-d97a-13ec-d3d580566101@somainline.org>
Date:   Wed, 1 Dec 2021 16:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 12/15] arm64: dts: qcom: sm8450-qrd: include pmic files
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-13-vkoul@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211201072915.3969178-13-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12.2021 08:29, Vinod Koul wrote:
> SM8450 QRD platform has bunch of PMICs, include the common ones PM8350,
> PM8350b and PMR735b
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> index 3e65d662ab8c..48228888f500 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> @@ -8,6 +8,9 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm8450.dtsi"
> +#include "pm8350.dtsi"
> +#include "pm8350b.dtsi"
> +#include "pmr735b.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. SM8450 QRD";
>
Again, this could have gone into a single "add board DTS" patch, but this

works too, I guess..


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

