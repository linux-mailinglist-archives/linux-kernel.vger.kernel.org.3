Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51B8483386
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbiACOhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:37:55 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:51769 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235213AbiACOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641220554; x=1672756554;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Kkn0XEM2sZCVDqxZ85uch+XeIVY/Ku5AixlF8FXOOyo=;
  b=Br/3wSIyEYJXGQ3sw0GBE57ghvq2wU/RPC4qifGOPSlnCkFoOi2Tqrk+
   Y8GltsshTfPbmRRhN+2/QKtq1EQ3oN9APzNf6mORb6V8fVXe+lziz0wEu
   2iuJk8qSXHDJG9DX3l9UHEMtPuBJVlnipor3q8P5BfDRwEzR2t01RlEu5
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Jan 2022 06:35:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 06:35:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 3 Jan 2022 06:35:51 -0800
Received: from [10.216.7.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 3 Jan 2022
 06:35:45 -0800
Subject: Re: [PATCH V4 1/6] dt-bindings: regulator: Add
 "regulator-min-dropout-voltage-microvolt"
To:     Mark Brown <broonie@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, <swboyd@chromium.org>,
        <subbaram@codeaurora.org>, Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-2-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+o9sQpECZSrieN@sirena.org.uk>
 <d828f2a1-03e8-d6ee-4ab7-39bf677093b7@quicinc.com>
 <Ya5VhkggWdjYyTHL@sirena.org.uk>
 <6a44cb99-6894-c9ce-4f1e-5dee0939598c@quicinc.com>
 <Ya97cnuwM+MuNMg3@sirena.org.uk>
 <23a47965-4ea9-5f6c-7e3c-27f5bd35f5b7@quicinc.com>
 <YbPCjbnH6cXQqy6S@sirena.org.uk>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <012a0a96-ab0e-e844-12e1-f2272bf2506d@quicinc.com>
Date:   Mon, 3 Jan 2022 20:05:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbPCjbnH6cXQqy6S@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/11/2021 2:41 AM, Mark Brown wrote:
> On Wed, Dec 08, 2021 at 04:56:48PM -0800, David Collins wrote:
>> On 12/7/21 7:19 AM, Mark Brown wrote:
>>> On Tue, Dec 07, 2021 at 08:36:11PM +0530, Satya Priya Kakitapalli (Temp) wrote:
>>> that regulator.  We absolutely can and do expect this to be board
>>> independent, it's a function of the design of the regulator.  Sharing
>>> the input supply has no impact on this, the input voltage that the
>>> regulator needs just get fed into the requiremnts on the supply voltage.
>> The PM8008 LDOs are low noise LDOs intended to supply noise sensitive
>> camera sensor hardware.  They can maintain output regulation with a
>> fixed headroom voltage.  However, in order to guarantee high PSRR, the
>> headroom voltage must be scaled according to the peak load expected from
>> the each LDO on a given board.  Thus, we included support for a DT
>> property to specify the headroom per LDO to meet noise requirements
>> across boards.
> Interesting...  how much extra headroom are we talking about here?  I'd
> be unsurprised to see this usually just quoted as part of the standard
> headroom requirement and this smells like the sort of thing that's going
> to be frequently misused.  If the gains are something worth writing home
> about


> I'd think we should consider if it's better to support this
> dynamically at runtime based on load information and provide options for
> configuring the peak load information through DT instead for static
> configurations.  That would fit in with the stuff we have for managing
> modes on DCDCs (which isn't really deployed but is there) and the API we
> have for allowing client drivers to indicate their load requirements at
> runtime that fits in with that.  That'd allow us to only boost the
> headroom when it's really needed.

This means Dynamic headroom control feature needs to be implemented. I 
need to explore more on this and gather info from team, Could we merge 
the present driver with "static headroom" for now? I'll do a follow up 
series to implement this feature.


