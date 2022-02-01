Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C34A57BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiBAH16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:27:58 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:46447 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiBAH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643700475; x=1675236475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W7GHtGGiLvtTayhJ4mO2oK96L/0WqB+0ryNcDPdY2zM=;
  b=xA9cDU4ntnSjCKBgkFlYXmnxh0cu6AbIyGLVpE8kBC1oFM56bbciIkRT
   WrquuprK3NiOEp57qW3UuQ6vlnZf6sS70I6x1wah4XBa6EZrvlhKgljpi
   Lc53b+wRhE571Y1q+30S+sL2BudTbTDIzCBNJVmzRkURjJXSAIiYF5ecz
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 31 Jan 2022 23:27:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:27:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 31 Jan 2022 23:27:38 -0800
Received: from [10.216.11.50] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 31 Jan
 2022 23:27:34 -0800
Message-ID: <01aac7b1-88e9-32e3-9b3c-625a2b03bdce@quicinc.com>
Date:   Tue, 1 Feb 2022 12:57:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/5] arm64: dts: qcom: sc7280: Fix gmu unit address
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <swboyd@chromium.org>,
        <kgodara@codeaurora.org>, <mka@chromium.org>,
        <sibis@codeaurora.org>, <pmaliset@codeaurora.org>,
        <quic_rjendra@quicinc.com>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220125224422.544381-1-dianders@chromium.org>
 <20220125144316.v2.1.I19f60014e9be4b9dda4d66b5d56ef3d9600b6e10@changeid>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20220125144316.v2.1.I19f60014e9be4b9dda4d66b5d56ef3d9600b6e10@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/2022 4:14 AM, Douglas Anderson wrote:
> When processing sc7280 device trees, I can see:
>
>    Warning (simple_bus_reg): /soc@0/gmu@3d69000:
>      simple-bus unit address format error, expected "3d6a000"
>
> There's a clear typo in the node name. Fix it.
>
> Fixes: 96c471970b7b ("arm64: dts: qcom: sc7280: Add gpu support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> (no changes since v1)
>
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 937c2e0e93eb..eab7a8505053 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1790,7 +1790,7 @@ opp-550000000 {
>   			};
>   		};
>   
> -		gmu: gmu@3d69000 {
> +		gmu: gmu@3d6a000 {
>   			compatible="qcom,adreno-gmu-635.0", "qcom,adreno-gmu";
>   			reg = <0 0x03d6a000 0 0x34000>,
>   				<0 0x3de0000 0 0x10000>,

My bad! Thanks for the fix.

fwiw, Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

-Akhil.

