Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5A56D72B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiGKHyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGKHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:54:19 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AB511465;
        Mon, 11 Jul 2022 00:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657526058; x=1689062058;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PNX5zeWScEfvXd7e/yKULO71QZJI9wmiUGZ4xVW8XFY=;
  b=a5cUioC4tu9KRZW5+59ucgSukb/XWLqF7LLNgqzjsKLSF5lk9qNrG7j8
   icyBWYgybmedYicsnmrIfdu0ghhdpw3Cwji6feG8Zf+h92hGu3H72qRQi
   ++Cj9FbjSXqVjdNu7XSq/d6Q8biso/HG897l3mhwsRZHlOUVqN9wevyzR
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 11 Jul 2022 00:54:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 00:54:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Jul 2022 00:54:17 -0700
Received: from [10.216.8.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Jul
 2022 00:54:13 -0700
Message-ID: <32cffa34-1088-5e25-3051-192e3049908f@quicinc.com>
Date:   Mon, 11 Jul 2022 13:24:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Move wcd specific pin conf
 to common file
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
References: <1657197381-1271-1-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53X8yyWr+Q+3RpciCeZcW+t+jgZs3eqNF9O8hJcw0cq0Q@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n53X8yyWr+Q+3RpciCeZcW+t+jgZs3eqNF9O8hJcw0cq0Q@mail.gmail.com>
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


On 7/8/2022 11:29 PM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-07-07 05:36:21)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
>> index 32a1e78..859faaa 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
>> @@ -5,6 +5,70 @@
>>    * Copyright (c) 2022, The Linux Foundation. All rights reserved.
>>    */
>>
>> +/* PINCTRL */
>> +
>> +&lpass_dmic01_clk {
>> +       drive-strength = <8>;
>> +       bias-disable;
>> +};
>> +
>> +&lpass_dmic01_clk_sleep {
>> +       drive-strength = <2>;
>> +};
>> +
>> +&lpass_dmic01_data {
>> +       bias-pull-down;
>> +};
>> +
>> +&lpass_dmic23_clk {
>> +       drive-strength = <8>;
>> +       bias-disable;
>> +};
>> +
>> +&lpass_dmic23_clk_sleep {
>> +       drive-strength = <2>;
>> +};
>> +
>> +&lpass_dmic23_data {
>> +       bias-pull-down;
>> +};
>> +
>> +&lpass_rx_swr_clk {
>> +       drive-strength = <2>;
>> +       slew-rate = <1>;
>> +       bias-disable;
>> +};
>> +
>> +&lpass_rx_swr_clk_sleep {
>> +       bias-pull-down;
>> +};
>> +
>> +&lpass_rx_swr_data {
>> +       drive-strength = <2>;
> I suspect this was discussed before, but why do we need to modify drive
> strengths on pins that aren't in output mode? I assume either rx_swr or
> tx_swr is unidirectional.

Actually this patch is just reorganization only. didn't do any 
modification of already reviewed patches.

Will test without drive strength again and post a fix patch post this 
patch accepted if required.

>
>> +       slew-rate = <1>;
>> +       bias-bus-hold;
>> +};
>> +
>> +&lpass_rx_swr_data_sleep {
>> +       bias-pull-down;
>> +};
>> +
>> +&lpass_tx_swr_clk {
>> +       drive-strength = <2>;
>> +       slew-rate = <1>;
>> +       bias-disable;
>> +};
>> +
>> +&lpass_tx_swr_clk_sleep {
>> +       bias-pull-down;
>> +};
>> +
>> +&lpass_tx_swr_data {
>> +       drive-strength = <2>;
>> +       slew-rate = <1>;
>> +       bias-bus-hold;
>> +};
>> +
>>   &mi2s1_data0 {
>>          drive-strength = <6>;
>>          bias-disable;
