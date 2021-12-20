Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72C47A97C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhLTMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:24:55 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:5339 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhLTMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640003095; x=1671539095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7sbN8IGbQB2gnzro+dgzGKfUcYLtao5VZ814EIMlDic=;
  b=r060cWcepUupLTecM5mlLcPX5Dore5M9ZcZjqRf2/+Qwm6RtthtxaR6W
   6acYlnReyxXjhFc+xaW/OyUYVY2/NqT4BSUWcpSWbXVrLWY8LSXzqI++g
   SH4BhWAYBW+zC0ra5ik6FW9uQji/VNU1IAhLYWziUKPPpa5zXhCFK7vyi
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 Dec 2021 04:24:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 04:24:53 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 04:24:53 -0800
Received: from [10.216.5.83] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 20 Dec
 2021 04:24:48 -0800
Message-ID: <39d259cf-5663-5073-f16b-71a21f0e62e3@quicinc.com>
Date:   Mon, 20 Dec 2021 17:54:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] dt-bindings: qcom,pdc: convert to YAML
To:     Luca Weiss <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20211213152208.290923-1-luca.weiss@fairphone.com>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <20211213152208.290923-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On 12/13/2021 8:52 PM, Luca Weiss wrote:
> Convert the PDC interrupt controller bindings to YAML.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> This patch depends on the following patch, which fixed sm8250 & sm8350
> compatibles and adds sm6350.
> https://lore.kernel.org/linux-arm-msm/20211213082614.22651-4-luca.weiss@fairphone.com/
>
> Also, if somebody has a better suggestion for the register names,
> the second one is pulled from downstream commit message which calls it
> both "SPI config registers" and "interface registers":
> https://source.codeaurora.org/quic/la/kernel/msm-4.19/commit/?id=cdefb63745e051a5bcf69663ac9d084d7da1eeec

Thanks for the patch. Please use "apss-shared-spi-cfg" name for the 
second reg.

It was intended in [1] to remove it since there are no user in upstream 
for second reg. but it should be fine to convert existing to yaml first 
and then look to fix that.

[1] 
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=449725&state=%2A&archive=both

[2] 
https://patchwork.kernel.org/project/linux-arm-msm/patch/1616409015-27682-1-git-send-email-mkshah@codeaurora.org/

Thanks,
Maulik
>
>   .../interrupt-controller/qcom,pdc.txt         | 77 -----------------
>   .../interrupt-controller/qcom,pdc.yaml        | 86 +++++++++++++++++++
>   2 files changed, 86 insertions(+), 77 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>
