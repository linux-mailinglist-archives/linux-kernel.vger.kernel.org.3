Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5F8482A45
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 07:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiABG1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 01:27:24 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:53069 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231982AbiABG1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 01:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641104843; x=1672640843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KNjbPSw0dS/30AtlU76DflNFpjpfBnTRJdGVbLSGOkQ=;
  b=Wott16rALNDzrLWNAh8zd1LrcYYnrR61/L9O2cR/rYZQyZDFZejsF4tb
   e2Z5E8p5FqUxBHgEin8cTTwIVCThNlAQ7BrkGzIYsCWb83GhP+SvOCqt/
   oBgHR73QH2fUiNZG3QeKB68twSwI/87N7k5OYK4L1XQ9xBdcikFo58azx
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jan 2022 22:27:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 22:27:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sat, 1 Jan 2022 22:27:22 -0800
Received: from [10.216.52.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sat, 1 Jan 2022
 22:27:18 -0800
Message-ID: <3741398c-b3e2-4872-d08f-9de02fe3cab9@quicinc.com>
Date:   Sun, 2 Jan 2022 11:57:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
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
 <39d259cf-5663-5073-f16b-71a21f0e62e3@quicinc.com>
 <CGROQPIOKGRH.2UVREF2IWAOIC@otso>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <CGROQPIOKGRH.2UVREF2IWAOIC@otso>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On 12/29/2021 3:11 PM, Luca Weiss wrote:
> Hi Maulik,
>
> On Mon Dec 20, 2021 at 1:24 PM CET, Maulik Shah wrote:
>> Hi Luca,
>>
>> On 12/13/2021 8:52 PM, Luca Weiss wrote:
>>> Convert the PDC interrupt controller bindings to YAML.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>> This patch depends on the following patch, which fixed sm8250 & sm8350
>>> compatibles and adds sm6350.
>>> https://lore.kernel.org/linux-arm-msm/20211213082614.22651-4-luca.weiss@fairphone.com/
>>>
>>> Also, if somebody has a better suggestion for the register names,
>>> the second one is pulled from downstream commit message which calls it
>>> both "SPI config registers" and "interface registers":
>>> https://source.codeaurora.org/quic/la/kernel/msm-4.19/commit/?id=cdefb63745e051a5bcf69663ac9d084d7da1eeec
>> Thanks for the patch. Please use "apss-shared-spi-cfg" name for the
>> second reg.
>>
>> It was intended in [1] to remove it since there are no user in upstream
>> for second reg. but it should be fine to convert existing to yaml first
>> and then look to fix that.
>>
> Do you have a full-text version of that? I'd use it instead of this in
> the binding.
>
>    - description: PDC interface register region
you can use below description,

description: Edge or Level config register for SPI interrupts

Thanks,
Maulik
