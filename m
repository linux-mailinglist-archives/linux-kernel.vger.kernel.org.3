Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BDC50F19F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbiDZHCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbiDZHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:02:41 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F1606C8;
        Mon, 25 Apr 2022 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650956374; x=1682492374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aw5r7BrW1vwKf05/8tJIj1dopbQ3n7YUHorQBJQ/h8o=;
  b=v1QPtj84natss33sTLNDCdQ0LyYa8U3o3aR1ZiP/fU11uCBFYS0RzWVK
   2j2LrdnYSs6J8ZWs/ibJjyc/9TWoKuOxm4hkSWqdQ02w4pUkYv37miY28
   5+Z492nh2gPQjaXpTxa2upR1SEq248iT0lvvNEirnxS2/9Zptv1Y7MvHJ
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Apr 2022 23:59:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:59:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 23:59:33 -0700
Received: from [10.216.40.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Apr
 2022 23:59:29 -0700
Message-ID: <c625c66b-54f6-1796-4ccc-b807ca821ef3@quicinc.com>
Date:   Tue, 26 Apr 2022 12:29:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v10 00/12] Add soundcard support for sc7280 based
 platforms.
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
References: <1650636521-18442-1-git-send-email-quic_srivasam@quicinc.com>
 <YmbotwGzLn/Z9Fq5@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmbotwGzLn/Z9Fq5@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/26/2022 12:00 AM, Matthias Kaehlcke wrote:
> On Fri, Apr 22, 2022 at 07:38:29PM +0530, Srinivasa Rao Mandadapu wrote:
>> This patch set is to add bolero digital macros, WCD and maxim codecs nodes
>> for audio on sc7280 based platforms.
>>
>> This patch set depends on:
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=631506
> There's a newer version (v10) [1]
>
> which should be ready to land now that 'Add pin control support for lpass
> sc7280' [2] has landed in Linus' pinctrl tree
Yes. It's ready for landing. But will post the next version, as per new 
herobrine dts files for rev5+ boards.
>
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=601249
> These are flagged as 'Queued', so probably landing soon.
Yes. They may land soon.
>
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=634203
> There is a newer version [3] which seems ready to land.
Yes. It's reviewed.
>
>>      -- Clock reset control patches
> What is this? I don't think I have seen an upstream version of this.
> Please provide a link, or if it hasn't be posted upstream yet make sure
> it is done ASAP.
These patches are yet to upstream by Clock team. Requested them to do ASAP.
>
> [1]https://patchwork.kernel.org/project/linux-arm-msm/list/?series=632316
> [2] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=633019&state=*
> [3] https://patchwork.kernel.org/project/linux-arm-msm/patch/1650621734-10297-1-git-send-email-quic_srivasam@quicinc.com/
