Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43434B1066
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiBJO2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:28:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242909AbiBJO14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:27:56 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2CD21C;
        Thu, 10 Feb 2022 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644503277; x=1676039277;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bqs2yU4FRtIKgztQwYdP5aUA/kaXzF+Ng5jdx6HVnAE=;
  b=v7OxZ1h02y/sqYxcebX9u6kKI0tNSSe/xQnCJMgPvL19whCdWvK8Bqbd
   wHGOa0+3lJNgOhvJZlT9rUK3qwc/VaMQCSi0oSCcAJu5gU7r50njoRLC7
   auY8ftOeAJQGMktVlEGi/pffmFiX7uahivlST3LDJ0LBK6ueEftRDQrAv
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2022 06:27:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:27:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 06:27:56 -0800
Received: from [10.216.9.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 10 Feb
 2022 06:27:52 -0800
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
 <1644334454-16719-3-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n52LGY2amCKo+40D4BoSsANs7JeQ0t_4QfeXNC5q64Ccwg@mail.gmail.com>
 <c17e95f7-9c42-657a-8525-3937d4b27fb8@quicinc.com>
 <CAE-0n51o3ohrVO-HCeVOTz=JwePA63yMrNpFsY4sFOiv6rQwEA@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <42e27aa2-afb6-656d-9b56-c822a8c510ad@quicinc.com>
Date:   Thu, 10 Feb 2022 19:57:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51o3ohrVO-HCeVOTz=JwePA63yMrNpFsY4sFOiv6rQwEA@mail.gmail.com>
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


On 2/10/2022 5:35 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-09 06:01:21)
>> On 2/9/2022 2:41 AM, Stephen Boyd wrote:
>>> Quoting Srinivasa Rao Mandadapu (2022-02-08 07:34:13)
>>>> +                       data {
>>>> +                               pins = "gpio7";
>>>> +                               function = "dmic1_data";
>>>> +                               drive-strength = <8>;
>>>> +                               input-enable;
>>>> +                       };
>>>> +               };
>>>> +
>>>> +               dmic01_sleep: dmic01-sleep-pins {
>>>> +                       clk {
>>>> +                               pins = "gpio6";
>>>> +                               function = "dmic1_clk";
>>>> +                               drive-strength = <2>;
>>>> +                               bias-disable;
>>>> +                               output-low;
>>>> +                       };
>>>> +
>>>> +                       data {
>>>> +                               pins = "gpio7";
>>>> +                               function = "dmic1_data";
>>>> +                               drive-strength = <2>;
>>>> +                               pull-down;
>>>> +                               input-enable;
>>> Why does input-enable matter? It's not a gpio.
>> Actually the same is fallowed in sm8250.dtsi. Verified without it and
>> working fine. Need take call on it.
> Is that because the pin is already an input by default? What does gpio
> debugfs say for this pin? Does it also work if you make it
> output-low/output-high here? I thought that the gpio itself isn't muxed
> out to the pad unless the function is "gpio" so I hope the input/output
> settings have no effect here.

Pin is in by default. debugfs says

gpio7 : in 1 8mA no pull

verified in downstream code also. Same is followed there also.

