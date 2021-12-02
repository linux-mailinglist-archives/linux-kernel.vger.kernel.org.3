Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822C1466ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348626AbhLBUIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:08:36 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:1680 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234495AbhLBUIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638475500; x=1670011500;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=M6JRb1L5bI93eUvGCDqUCDgna5+vK0854mAKgmhopQc=;
  b=B03AGRBRbiV6D8ierfHkTF7vl1FRrw6tm7PvwiYUqDOHRPZOcjn8E1sH
   3K6Jx8lr7GAcxO/YD8cnfbMdjyGzWz5k9t+tzBO+opi11N9HgWvj7b0Pa
   p1pejHEm1dJAEO7zbEDLJRgJDj7z12oV4zRvcXkhVF80ulr4F3Rb3enA8
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Dec 2021 12:04:57 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 12:04:57 -0800
Received: from [10.110.122.223] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 2 Dec 2021
 12:04:56 -0800
Subject: Re: [PATCH 1/5] dt-bindings: platform: microsoft: Document surface
 xbl
To:     Jarrett Schultz <jaschultzms@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
References: <20211202191630.12450-1-jaschultz@microsoft.com>
 <20211202191630.12450-2-jaschultz@microsoft.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
Message-ID: <d85dba31-7d79-7c00-b930-41e513aa323d@quicinc.com>
Date:   Thu, 2 Dec 2021 12:04:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202191630.12450-2-jaschultz@microsoft.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/2021 11:16 AM, Jarrett Schultz wrote:
> Introduce yaml for surface xbl driver.
> 
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> 
> 

Is it not possible to send patch email from @microsoft.com ?

---Trilok Soni
