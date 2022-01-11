Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C6C48AD69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbiAKMPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:15:47 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:17595 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiAKMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641903342; x=1673439342;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0tHJK5Z23kWWB0+aVo8CNSTWYcqnW0l7qmhwpY4szPY=;
  b=p5Rd3/ACzo8INDGw2L8evxmftLHF4WmtZoEewVanSp42LwaiTlV9jl1o
   D1D9btnEiTPJf+jbw2hxeEYlQPUjxlET284cRq4I+UT9vGa49vwYt11//
   PDpjjYAIUt0BsMScyXw7r9cg6WEF4pLl1E5kFGOU8La7tPzjZGO/OKDzc
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 11 Jan 2022 04:15:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 04:15:25 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 11 Jan 2022 04:15:25 -0800
Received: from [10.216.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 11 Jan
 2022 04:15:20 -0800
Subject: Re: [PATCH V4 2/6] dt-bindings: regulator: Add pm8008 regulator
 bindings
To:     Mark Brown <broonie@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, <swboyd@chromium.org>,
        <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+qn2hA4MzNEqM+@sirena.org.uk>
 <30b21a08-f7f7-f3a6-a3ac-156c7f8964b1@quicinc.com>
 <Ya4UcxxEq9t+isxS@sirena.org.uk>
 <30ec6b4c-f2a8-d80e-a542-1c2b3f30c049@quicinc.com>
 <07dc5ba4-790b-0cb2-bc3e-2ce8d7e3e09d@quicinc.com>
 <YdxA5bwcwyJXcPDl@sirena.org.uk>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <9c4a995d-2dc0-1731-cca0-a013483a4fc0@quicinc.com>
Date:   Tue, 11 Jan 2022 17:45:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdxA5bwcwyJXcPDl@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/2022 7:51 PM, Mark Brown wrote:
> On Mon, Jan 10, 2022 at 06:42:08PM +0530, Satya Priya Kakitapalli (Temp) wrote:
>
>> To understand how other upstream mfd drivers are handling this I've gone
>> through some of them. Taking one example, mfd/stpmic1.c is a pmic  mfd
>> device which has a regulators sub-node with separate compatible, and has the
>> parent supplies listed under the regulators node.
> There are some devices that did get merged doing this, that doesn't mean
> it's a great idea though.

In that case, it would be helpful if you could provide an example which 
has the design you suggested.


