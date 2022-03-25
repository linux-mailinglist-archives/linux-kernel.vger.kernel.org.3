Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835844E7187
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiCYKuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbiCYKuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:50:12 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B860E5;
        Fri, 25 Mar 2022 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648205315; x=1679741315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6SYE30WL/ZVQGNoFhLYXCXzeHh3vABfM/UDz9rezytY=;
  b=BLVEMKyp1xiZHoFVxZL835rWC+2M+bbaWa6nIdnoHLS37lAFCH1XDwo5
   UleUaKz6mbbX3jgWJFAvYvLL2vC1+hD+aCE26rDk56c5sEsQ5UHPRfFDC
   j9sBofiDPQacnPw48jW1M2Ds6YvYZObf34THBFhURxgfXyMr8niXDZfib
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Mar 2022 03:48:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 03:48:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 03:48:33 -0700
Received: from [10.216.19.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 25 Mar
 2022 03:48:28 -0700
Message-ID: <1e3d636a-f349-00d1-f9c5-0cdd19d42fbd@quicinc.com>
Date:   Fri, 25 Mar 2022 16:18:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 5/6] dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx65
 support
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <rnayak@codeaurora.org>, <collinsd@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
 <1647410837-22537-6-git-send-email-quic_rohiagar@quicinc.com>
 <CACRpkdaSGHno4pfnhi_rKeHWyOOCGDnku+jhyLHGrSfHr06m7g@mail.gmail.com>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <CACRpkdaSGHno4pfnhi_rKeHWyOOCGDnku+jhyLHGrSfHr06m7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2022 4:10 AM, Linus Walleij wrote:
> On Wed, Mar 16, 2022 at 7:07 AM Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
>> Add support for the PMX65 GPIO support to the Qualcomm PMIC GPIO
>> binding.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> After the merge window can you resend this binding and the pinctrl
> patch separately so I can merge them to the pinctrl tree?

Sure, Will do.
Thanks.

>
> Yours,
> Linus Walleij
