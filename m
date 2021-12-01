Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A0464634
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 05:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhLAFCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:02:39 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:49685 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhLAFCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638334755; x=1669870755;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zi3Ni4efeR2heYySqn8vxzRN8Cn8WQlhVOJ6OgVH5Jk=;
  b=h9ZEit3CQiZKxWFjQlaF7NOLHrXTGNQJh3XXkj68ZQlg07c+9MX6TbV7
   YaKu/Jpkrb72dDutSjPlyZg5gIXek7+UOhua4KDXTpjhkHjG7Ove+IL3Z
   3NtEFDUN++L4GOJWe4nt4yz3I/MtO5E+AdyfYL2dkQLIzAOllp/rDW3VK
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Nov 2021 20:59:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 20:59:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 20:59:14 -0800
Received: from [10.216.2.11] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 30 Nov
 2021 20:59:10 -0800
Subject: Re: [PATCH 1/2] arm64: qcom: sc7280: Remove USB2 controller and phy
 nodes from common dtsi
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
References: <1637837815-8532-1-git-send-email-quic_c_sanm@quicinc.com>
 <1637837815-8532-2-git-send-email-quic_c_sanm@quicinc.com>
 <YaUVrDw9j0Aks/pn@google.com>
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Message-ID: <bf2473d4-5f3d-8666-a6e6-81551791a7dd@quicinc.com>
Date:   Wed, 1 Dec 2021 10:29:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaUVrDw9j0Aks/pn@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/29/2021 11:32 PM, Matthias Kaehlcke wrote:
> On Thu, Nov 25, 2021 at 04:26:54PM +0530, Sandeep Maheswaram wrote:
>> Remove USB2 controller and phy nodes from common dtsi file as it is
>> required only for SKU1 board.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> A series shouldn't break things if it is only applied partially (in order). In
> this case the USB2 controller wouldn't work on the SKU1 board if only this patch
> is applied. It should be squashed with patch 2 of this series ("arm64: qcom:
> sc7280: Add USB2 controller and phy nodes for SKU1 board").
>
> Also doing the move in a single patch instead of two separate patches for remove
> and add makes it easier to review the latter part, since it's evident from the
> patch itself that it's just a move.
Ok. Will do in next version.
