Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318735403E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345079AbiFGQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345069AbiFGQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:38:56 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCD6814B4;
        Tue,  7 Jun 2022 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654619935; x=1686155935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uKV8Rrvy8kCqSKlM45aKJN6vfteKfERlb/gHHUZ2hGE=;
  b=eenzpvUgxXQaYdsJQYmJHLoYazvwDnOAI4KDAjGbDTl+g3zQzAgyPcKq
   FkEn23dldDXQrfHYuvtZyUc8QdA6zAL3NLW59CMRAjHJG6sFQjwQd907x
   1mxveKa4iESJVznu5hOOO4maN4zX9WEEEmHNKC5VFMpf7CpkOXzFvugHv
   M=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 09:38:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:38:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 09:38:54 -0700
Received: from [10.216.1.130] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 7 Jun 2022
 09:38:46 -0700
Message-ID: <5427aa79-b87c-74eb-def5-9b4e3299a331@quicinc.com>
Date:   Tue, 7 Jun 2022 22:08:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v12 00/12] Add soundcard support for sc7280 based
 platforms.
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <quic_tdas@quicinc.com>
References: <1653049124-24713-1-git-send-email-quic_srivasam@quicinc.com>
 <Yp5yUSvC05wOxtei@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Yp5yUSvC05wOxtei@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/7/2022 3:02 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Fri, May 20, 2022 at 05:48:32PM +0530, Srinivasa Rao Mandadapu wrote:
>> This patch set is to add bolero digital macros, WCD and maxim codecs nodes
>> for audio on sc7280 based platforms.
>>
>> This patch set depends on:
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638776
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=634597
>>      -- https://patchwork.kernel.org/project/linux-clk/list/?series=637999
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638002
> Another dependency (at least in terms of functionality) is:
>
> ASoC: qcom: soundwire: Add support for controlling audio CGCR from HLOS
> https://patchwork.kernel.org/patch/12853622/
This is landed today.
>
> And then there is this:
>
> arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers
> https://patchwork.kernel.org/project/linux-arm-msm/patch/20220523100058.26241-1-quic_tdas@quicinc.com/
>
> A previous version (v3) of that patch already landed (9499240d15f2
> "arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers"),
> it is not clear to me why it is still evolving as if that weren't the
> case.

I too have same doubt. the changes should be incremental and new patch. 
May be Taniya considered

the status in patchwork.kernel org, where still it's showing new.

>
>  From the newer version of the patch at least marking the 'lpasscc' node
> as disabled is needed.

yes, agree. And the node name changed to lpasscore to lpass_core.

Included Taniya in the mail chain for further discussion.

