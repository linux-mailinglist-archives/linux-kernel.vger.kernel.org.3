Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAC84B0F92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbiBJOBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:01:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiBJOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:01:17 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15639A;
        Thu, 10 Feb 2022 06:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644501679; x=1676037679;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qe9MXECg7yOyYY9awU7kKLHuhF7vbhlkrcPO0J0a62Y=;
  b=zbBPF8m9QBewPnUheCn8uQZwLeXYeTv6StSMowR4v4IhmzkDbyDcEel8
   Lm70ljgEgZhiOxBSBkdEXg8AMO15pcesd0+ZZfFDWrrLa7D5NjyOpLtWw
   SjACV/SWUoFgW8NWPkwWCTnIgCX/ck3umLjglUZ9qvF0tCl3BHtDsJjcH
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 06:01:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:01:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 06:01:17 -0800
Received: from [10.216.9.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 10 Feb
 2022 06:01:13 -0800
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
 <1644334454-16719-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50PAtGfvHXjNrvQYe6edNEfJvEc1uYZFUeW2KHxn6fsBA@mail.gmail.com>
 <30805a84-b523-842c-d223-bc0d2043fa00@quicinc.com>
 <CAE-0n538CdY3a64jG556se=AhgJpXr_oENG_spGM29c5gdQRYQ@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <5a955a2e-c594-4320-2a9b-9d92d1999f9b@quicinc.com>
Date:   Thu, 10 Feb 2022 19:31:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n538CdY3a64jG556se=AhgJpXr_oENG_spGM29c5gdQRYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 2/10/2022 5:37 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-09 05:42:40)
>> On 2/9/2022 2:38 AM, Stephen Boyd wrote:
>>> Quoting Srinivasa Rao Mandadapu (2022-02-08 07:34:12)
>>>>    &qspi_cs0 {
>>>>           bias-disable;
>>>> @@ -491,6 +524,13 @@
>>>>    };
>>>>
>>>>    &tlmm {
>>>> +       amp_en: amp-en {
>>>> +               pins = "gpio63";
>>>> +               function = "gpio";
>>>> +               bias-disable;
>>> Is there an external pull?
>> I think no external pull. In trogdor mentioned bias-pull-down but you
>> suggested to remove it.
> Maybe on trogdor there was an external pull inside the amp that this pin
> is connected to? Usually we have a comment like /* Has external
> pull-{up,down} */ so please add that here depending on which way the
> pull goes.

As per Anderson suggestion we removed bias-pull-down. Actually, it's 
up-streamed for same platform in sc7280-herobrine.dtsi.

We will fallow the same. It contains bias-pull-down.

