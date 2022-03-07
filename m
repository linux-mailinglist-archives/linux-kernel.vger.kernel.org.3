Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3824D01CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbiCGOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiCGOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:50:34 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059B85978;
        Mon,  7 Mar 2022 06:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646664580; x=1678200580;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kCiyL7LJ6ect9V6yfLMZQN25/a2tH3wxzb1kcI/nvYo=;
  b=BeRLvvrnYp7syq5iTbEtMVDhgb5/du1NRqlFX4ixi/YwG56pzw89hp7Q
   ftLLikXy82Lb63qz0m2XAwl1x6yuptjmQYtFy4g5M442vsXwrxP1QrDHj
   kJGDBGaIjYHcy2QbP2laLWHGOjXRGo9BPwyfq2exRBttamHs/euSIuiSJ
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 07 Mar 2022 06:49:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 06:49:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Mar 2022 06:49:40 -0800
Received: from [10.216.48.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 7 Mar 2022
 06:49:35 -0800
Subject: Re: [PATCH V7 5/5] arm64: dts: qcom: sc7280: Add pm8008 support for
 sc7280-idp
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
 <1645182064-15843-6-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n509bg6RzieOtYuUvicU14D7bmgH-u02F1TB+hBZ+xH4CA@mail.gmail.com>
 <42570508-ed62-af26-220e-c776418a722e@quicinc.com>
 <CAE-0n50J=4qrkR9ycEGxbKVHwm9Om8S2YSJR_Y71_iErR-wAHw@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <7e3d1ff3-f1a0-3a4d-a056-e3dce1a9a28d@quicinc.com>
Date:   Mon, 7 Mar 2022 20:19:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n50J=4qrkR9ycEGxbKVHwm9Om8S2YSJR_Y71_iErR-wAHw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 3/1/2022 2:06 AM, Stephen Boyd wrote:
> Quoting Satya Priya Kakitapalli (Temp) (2022-02-28 06:25:06)
>> On 2/19/2022 7:31 AM, Stephen Boyd wrote:
>>> Quoting Satya Priya (2022-02-18 03:01:03)
>>>> +               pins = "gpio4";
>>>> +               function = "normal";
>>>> +               bias-disable;
>>>> +               output-high;
>>> Is this a reset signal? Should the driver be deasserting the reset when
>>> it is ready? That could be the same time the gpio is acquired.
>>
>> I didn't get your question exactly.. hope this answers your query
>>
>> The pm8008 chip needs this gpio to be toggled , in order to come out of
>> reset and start any transactions..
>>
>> Please let me know if you have more queries
> Yes that answers it for me. Thanks.
>
> This is a reset gpio and should be a DT property like
>
> 	reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_HIGH>
>
> in the pm8008 node. When the driver probes it should get the gpio and
> do any toggling to take it out of reset. It shouldn't be done through
> pinconf settings.


Okay, IIUC,  I have to remove the output-high here and add reset-gpios 
in pm8008 DT node. And then add below code in pm8008 mfd driver probe

+               chip->reset_gpio = devm_gpiod_get(chip->dev, "reset", 
GPIOD_OUT_HIGH);
+               if (IS_ERR(chip->reset_gpio)) {
+                       dev_err(chip->dev, "failed to acquire reset 
gpio\n");
+                       return PTR_ERR(chip->reset_gpio);
+               }
+               gpiod_set_value(chip->reset_gpio, 1);

This is working for me, Please let me know if I'm  missing something.

