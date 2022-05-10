Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE05212FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbiEJLEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiEJLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:04:05 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011C823AE4C;
        Tue, 10 May 2022 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652180409; x=1683716409;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cWiFpy1BulEe8GzbIrFAcOtXKxm6yh3lnWMPeKAd5LA=;
  b=nEylUt3h3JH5fVzleoJQMxcr0vs9+PRev0w5jVZ6afIlwVDZk7X+Mkcc
   yIuY0hIzgRxrco3ZNFH4NB0vnwhCmIcrJrF1HRjT3BCiUIUPPb70jKzkX
   gkaD8opgDZo9OsYsb5UeGPllhqd8z2eXDHLMOMo0AUZKy3WF2HnXsL44v
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 May 2022 04:00:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 04:00:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 04:00:07 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 04:00:02 -0700
Subject: Re: [PATCH 0/3] Add support for proxy interconnect bandwidth votes
To:     Stephen Boyd <swboyd@chromium.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>
CC:     <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <evgreen@chromium.org>,
        <dianders@chromium.org>, <mka@chromium.org>,
        <krzysztof.kozlowski@canonical.com>
References: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
 <CAE-0n51qygskCKAv7MwJmM8BVV2D0wT46YCBwxtGKybP4QA+jQ@mail.gmail.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <8a4ee54e-f648-97a9-e9a6-ccae6ca8ce10@quicinc.com>
Date:   Tue, 10 May 2022 16:29:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51qygskCKAv7MwJmM8BVV2D0wT46YCBwxtGKybP4QA+jQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 4:47 AM, Stephen Boyd wrote:
> Quoting Sibi Sankar (2022-02-13 20:34:09)
>> Add support for proxy interconnect bandwidth votes during modem bootup on
>> SC7280 SoCs.
>>
>> Sibi Sankar (3):
>>    dt-bindings: remoteproc: qcom: Add interconnects property
>>    remoteproc: qcom_q6v5_mss: Add support for interconnect bandwidth
>>      voting
>>    arm64: dts: qcom: sc7280: Add proxy interconnect requirements for
>>      modem
> 
> Is this patch series going to be resent? Does it need to be applied to
> sc7180 as well?

Stephen,
The proxy votes are needed on SC7180.

-Sibi
> 
