Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5892488F66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiAJE4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:56:17 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:61660 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233263AbiAJE4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641790576; x=1673326576;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uLGYrAM8396ivFrmaozwhMsLlpDBalBeGLFUuXrJHTs=;
  b=TBSkxEr7l727cIgMnMJko6mL5juXSH7arSTBqY2e4/gHlPe6r9oR5Mo5
   RL8V1EHKADu1nq1katTZusQGwngrTxbdDKjh9NrcgaWPGFougFtjgMLYW
   LPJZPzJDTJZPHsCKBo/8kQaIJ2zA1PObzUsyR5Mdc7Mxme1ZBVa46dKs1
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jan 2022 20:56:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 20:56:15 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 20:56:15 -0800
Received: from [10.216.2.252] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 9 Jan 2022
 20:56:11 -0800
Subject: Re: [PATCH v2] arm64: qcom: sc7280: Move USB2 controller nodes from
 common dtsi to SKU1
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>
References: <1638422248-24221-1-git-send-email-quic_c_sanm@quicinc.com>
 <CAE-0n51S7gPnkgL40Lqj-8dgZ-jjfCmNGtnUDgqJ_Kw5dzc_sg@mail.gmail.com>
 <e605c057-a7a4-657a-06ee-f872e13e116e@quicinc.com>
Message-ID: <135e8171-c210-1f70-e26f-167f8fdfcc74@quicinc.com>
Date:   Mon, 10 Jan 2022 10:26:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e605c057-a7a4-657a-06ee-f872e13e116e@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 12/15/2021 11:18 AM, Sandeep Maheswaram wrote:
> Hi Bjorn,
>
> On 12/3/2021 4:22 AM, Stephen Boyd wrote:
>> Quoting Sandeep Maheswaram (2021-12-01 21:17:28)
>>> Move USB2 controller and phy nodes from common dtsi file as it is
>>> required only for SKU1 board and change the mode to host mode as
>>> it will be used in host mode for SKU1.
>>>
>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>> ---
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Can you merge this change in qcom tree?

Is this patch merged in qcom tree ? If not can you please do so.

Regards

Sandeep


