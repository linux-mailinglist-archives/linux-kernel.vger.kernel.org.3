Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB494B106D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiBJO3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:29:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242934AbiBJO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:29:51 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0708B398;
        Thu, 10 Feb 2022 06:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644503393; x=1676039393;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+FTgaWtC/fbl/lpxIMMrwrFu+pXJ8EqWfUdrXRGQUgY=;
  b=WuwaJBS/8djrJIBZ/oD04w/hmfo2yGpn2ulCvSUl0DUu+5LXrEh9dJWw
   4FYZ8z4g3gsYr5a9AcVmYqPJx5zYUUxMT2xJX1CkpuQ2wifYQI+2t011+
   Lfgvbj3BHqZeFC5DGUpFqXDOoeZ9ifkXGCCvLqa8VsMDlLomO3i2cMKWK
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 06:29:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:29:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 06:29:50 -0800
Received: from [10.216.9.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 10 Feb
 2022 06:29:47 -0800
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
 <a1c2a7e6-8d76-6ee6-4bc4-e7ea8013af02@quicinc.com>
 <CAE-0n52LqrdLXk4=WMQY3WXVYLjpwXH+FP2z71gKMAkjiPR4Xg@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <7a5e55b9-058f-e143-0d78-7a6d57498a50@quicinc.com>
Date:   Thu, 10 Feb 2022 19:59:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n52LqrdLXk4=WMQY3WXVYLjpwXH+FP2z71gKMAkjiPR4Xg@mail.gmail.com>
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


On 2/10/2022 5:33 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-09 06:26:58)
>> On 2/9/2022 2:42 AM, Stephen Boyd wrote:
>>> Quoting Srinivasa Rao Mandadapu (2022-02-08 07:34:14)
>>>
>>>> +                       pins = "gpio83";
>>>> +                       function = "gpio";
>>>> +                       drive-strength = <16>;
>>>> +                       output-high;
>>>> +       };
>>>> +
>>>> +       wcd938x_reset_sleep: wcd938x_reset_sleep {
>>>> +                       pins = "gpio83";
>>>> +                       function = "gpio";
>>>> +                       drive-strength = <16>;
>>>> +                       bias-disable;
>>>> +                       output-low;
>>> Why doesn't the device drive the reset gpio by requesting the gpio and
>>> asserting and deasserting it? We shouldn't need to use pinctrl settings
>>> to toggle reset gpios.
>> Okay. Verified without these nodes and didn't see any impact. But
>> similar way it's mentioned in sm8250-mtp.dts. Could You please suggest
>> on it how to go ahead on this?.
> I'd expect the wcd938x codec device node to have a 'reset-gpios'
> property like
>
> 	reset-gpios = <&tlmm 83 GPIO_ACTIVE_LOW>
>
> and then the driver to request that gpio via
>
> 	reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>
> so it gets the gpio during driver probe. Then the gpio can be deasserted
> during suspend and reasserted on resume, if that's even important?
Okay will remove it. Already wcd938x node has reset gpio. It seems these 
are redundant.
