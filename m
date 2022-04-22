Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356C150B42E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446090AbiDVJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445907AbiDVJie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:38:34 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C94527EE;
        Fri, 22 Apr 2022 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650620141; x=1682156141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a1NKqMAQrpDA9DNNjLiY6Z6HBalYNQgIEUbfmgCyV1o=;
  b=xsOWsvTUtrzwe1elaGXehg3zl6inUXZ9x3m5R5jLtbVcjdW44AOSfxjo
   Z+LCG8oXB8gKRc/haGgmYLVByMddgvm+QTDxgAwHk9tyqlIPeMkyoIjTa
   5BfmXAJnIiD3cE0vNjT0/1+V0FGL8UV4unM/bfzNP4l2wXKAv8nD9+EQO
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Apr 2022 02:35:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 02:35:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 02:35:40 -0700
Received: from [10.216.36.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 02:35:36 -0700
Message-ID: <c1dc4ce8-9dd5-d511-f022-5e71dd7c23ba@quicinc.com>
Date:   Fri, 22 Apr 2022 15:05:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add ldo_l17b regulator node
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650550779-8133-1-git-send-email-quic_srivasam@quicinc.com>
 <CAD=FV=VODaTxu+c8cXWyy8Mw1Qm145vwt-UspirE6k-XL-MZdg@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAD=FV=VODaTxu+c8cXWyy8Mw1Qm145vwt-UspirE6k-XL-MZdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your time Doug!!!

On 4/21/2022 9:50 PM, Doug Anderson wrote:
> Hi,
>
> On Thu, Apr 21, 2022 at 7:20 AM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
>> Add ldo_l17b in pm7325 regulator, which is required for
>> wcd codec vdd buck supply.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
> The ${SUBJECT} should probably mention qcard somehow? Right now your
> patch subject makes it sound like this applies to all sc7280 boards,
> but this only affects those including the qcard dtsi file.
Okay. Will update the subject accordingly.
>
>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>> index b833ba1..17d0c05 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>> @@ -113,6 +113,11 @@
>>                          regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>                  };
>>
>> +               vreg_l17b_1p8: ldo17 {
>> +                       regulator-min-microvolt = <1700000>;
>> +                       regulator-max-microvolt = <1900000>;
> All the other regulators in this file specify:
>
> regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>
> Why doesn't yours?
Okay. Will add initial mode.
