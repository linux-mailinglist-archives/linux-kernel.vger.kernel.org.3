Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0AD4AF403
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiBIO1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiBIO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:27:03 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735D8C06157B;
        Wed,  9 Feb 2022 06:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644416826; x=1675952826;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=epGqPg8z8P+UPOQgQalxESfWXq7yaTif/iFh1nkz2mE=;
  b=qbaHPlnpcwUf8zu+vGsg2rXZCnGnmBYnqmfarQgNYFpdaPO3ORG2ToKc
   wuND/0gZpDadf92hxILVxlFae57KuVR4HYU9Zhcs19EoOD6w6gX3nFci3
   33A26ifDC1KFPyQ6WOrK1sBxoWO1Mx4s1/dj1kzDeXmTh8MopKAlx3CoA
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 06:27:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:27:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 06:27:05 -0800
Received: from [10.216.41.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 06:27:01 -0800
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7280: Add wcd9380 pinmux
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
 <1644334454-16719-4-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50jBeOnkpogPFm+zqTf8bqQs-Bo0Gma658uFE6aA=Edxg@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <a1c2a7e6-8d76-6ee6-4bc4-e7ea8013af02@quicinc.com>
Date:   Wed, 9 Feb 2022 19:56:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n50jBeOnkpogPFm+zqTf8bqQs-Bo0Gma658uFE6aA=Edxg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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


On 2/9/2022 2:42 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-08 07:34:14)
>> Add pinmux to reset wcd codec, conneceted on SC7280 based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 4704a93..6b38fa1 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -594,6 +594,21 @@
>>                   */
>>                  bias-pull-up;
>>          };
>> +
>> +       wcd938x_reset_active: wcd938x_reset_active {
> No underscore in node names.
Okay. will remove it.
>
>> +                       pins = "gpio83";
>> +                       function = "gpio";
>> +                       drive-strength = <16>;
>> +                       output-high;
>> +       };
>> +
>> +       wcd938x_reset_sleep: wcd938x_reset_sleep {
>> +                       pins = "gpio83";
>> +                       function = "gpio";
>> +                       drive-strength = <16>;
>> +                       bias-disable;
>> +                       output-low;
> Why doesn't the device drive the reset gpio by requesting the gpio and
> asserting and deasserting it? We shouldn't need to use pinctrl settings
> to toggle reset gpios.
Okay. Verified without these nodes and didn't see any impact. But 
similar way it's mentioned in sm8250-mtp.dts. Could You please suggest 
on it how to go ahead on this?.
