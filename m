Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A39149687A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiAVAE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:04:58 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:4706 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbiAVAE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642809897; x=1674345897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M4xJpCeE5aKhJ84AV5MByeatBIkGIFocgtR0PeuZbQA=;
  b=hkjdMJiF8jjFsvgrR4mAKbXSqynY/x6TiTJyQosEPgJOFqkxN7HqDtvT
   dexoILSoPWpD22NjM8qNeMSWkjtItubg+7elTfHKT3spvVlc/tm7+YVQ0
   MFoNqNlKJn2G8OwZbf9DHXcSYb1WYPdPtK0JXsK0fg29WwJB0/ivxIEgg
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jan 2022 16:04:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 16:04:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 21 Jan 2022 16:04:56 -0800
Received: from [10.110.112.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 21 Jan
 2022 16:04:56 -0800
Message-ID: <11a2047f-86b8-1bea-ff99-d708429327fd@quicinc.com>
Date:   Fri, 21 Jan 2022 16:04:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] Add support for pm8941-pwrkey.c
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <skakit@codeaurora.org>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
 <CAE-0n530ddsusCO7ZB1X2GZ8NN4dPphdhAYCbexEr5jRPoACVA@mail.gmail.com>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CAE-0n530ddsusCO7ZB1X2GZ8NN4dPphdhAYCbexEr5jRPoACVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2022 7:51 PM, Stephen Boyd wrote:
> "Add support" in the subject sounds like it is new. Maybe "extend
> pm8941-pwrkey driver" would be more appropriate.

Will update subject in upcoming version.

> Quoting Anjelique Melendez (2022-01-20 12:41:30)
>> This change series includes support and fixes in pm8941-pwrkey.c.
>> Change details and description can be found in each patch. Thanks!
>>
>> David Collins (3):
>>   input: misc: pm8941-pwrkey: simulate missed key press events
>>   input: misc: pm8941-pwrkey: add software key press debouncing support
>>   input: misc: pm8941-pwrkey: avoid potential null pointer dereference

