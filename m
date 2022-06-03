Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4653C4BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiFCGJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiFCGJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:09:43 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F59C2AC71;
        Thu,  2 Jun 2022 23:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654236583; x=1685772583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kFDsYAwwyQEIROHoFgr6UXEiUnfVjD1ybd+VrPy8+F0=;
  b=ab1B78qKl75oHYVhyEmNEi+CZsRKGBBW1nHJaPCbjawGLgP6h51YvPcW
   6qsIUFYCGZHUOwvBw1inIpVbTcbnryvGozVSHXTbP5kxvW+3TmAbZRac8
   hleRGotrHacukhinROUX84Elr9aBY82mhXNCMy4uvH8sxJbfecYFD2G22
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Jun 2022 23:09:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 23:09:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 23:09:33 -0700
Received: from [10.216.32.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 2 Jun 2022
 23:09:27 -0700
Message-ID: <6250a441-6bcd-4ca8-782b-b7a8d9239e46@quicinc.com>
Date:   Fri, 3 Jun 2022 11:39:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: sc7280: Add compatible
 string for adsp based platforms
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@quicinc.com>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <perex@perex.cz>, <quic_plai@quicinc.com>,
        <quic_rohkumar@quicinc.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <tiwai@suse.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1654079415-26217-1-git-send-email-quic_srivasam@quicinc.com>
 <1654079415-26217-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50nfwZPdSS7Vw9FiV+Shfn9-bX44hfLq5ey9DBsAy0y4g@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n50nfwZPdSS7Vw9FiV+Shfn9-bX44hfLq5ey9DBsAy0y4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/2022 6:43 AM, Stephen Boyd wrote:
> Quoting Srinivasa Rao Mandadapu (2022-06-01 03:30:14)
>> Add compatible string to support adsp enabled sc7280 platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml    | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
>> index d32ee32..53c2c59 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
>> @@ -17,7 +17,9 @@ description: |
>>
>>   properties:
>>     compatible:
>> -    const: qcom,sc7280-lpass-lpi-pinctrl
>> +    enum:
>> +      - qcom,sc7280-lpass-lpi-pinctrl
>> +      - qcom,sc7280-lpass-adsp-lpi-pinctrl
> Can you confirm that this is the same hardware (i.e. same reg property)
> but just a different compatible string used to convey that the device is
> using "adsp" mode or not? If so, this looks to be a common pattern for
> the audio hardware here, where we have two "views" of the hardware, one
> for adsp mode and one for not adsp mode. I guess the not adsp mode is
> called "adsp bypass"?

Yes Your understanding is correct. The same hardware in scenario not using ADSP,

and in another enabling DSP.
>
> Is that right? Why are we conveying this information via the compatible
> string?

Could you please suggest better way!.  As pin control driver is the 
first one to probe, I am not getting better approach.

While up-streaming these drivers, concluded to use this approach.

