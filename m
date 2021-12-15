Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A256475247
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbhLOFse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:48:34 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:58795 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhLOFsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639547312; x=1671083312;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KDoIk0DbDB7uOCFnMskiFXS0WSSem0vlI14LSf5zEeo=;
  b=O3OyrUzP3CjKxSJqPhZB1Qh4lnQIk9/jRNsaJU4LN5RJ5QhR2w2oxQTg
   sYea92Fx0qhAkpdLhYgG0/nuYGGCvlDhgyyAO12gfwga8ufKvTeYqsqCD
   KLjhk40eIZLrQ6faefBgMMNEE0GoJWfVlcl4c+QKv3ZpFstNk2T7ABnn7
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Dec 2021 21:48:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 21:48:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 14 Dec 2021 21:48:30 -0800
Received: from [10.216.21.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 14 Dec
 2021 21:48:26 -0800
Subject: Re: [PATCH v2] arm64: qcom: sc7280: Move USB2 controller nodes from
 common dtsi to SKU1
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
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Message-ID: <e605c057-a7a4-657a-06ee-f872e13e116e@quicinc.com>
Date:   Wed, 15 Dec 2021 11:18:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51S7gPnkgL40Lqj-8dgZ-jjfCmNGtnUDgqJ_Kw5dzc_sg@mail.gmail.com>
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

On 12/3/2021 4:22 AM, Stephen Boyd wrote:
> Quoting Sandeep Maheswaram (2021-12-01 21:17:28)
>> Move USB2 controller and phy nodes from common dtsi file as it is
>> required only for SKU1 board and change the mode to host mode as
>> it will be used in host mode for SKU1.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> ---
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Can you merge this change in qcom tree?
