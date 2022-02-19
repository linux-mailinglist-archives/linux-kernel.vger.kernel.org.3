Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942704BC9CC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbiBSSYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:24:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiBSSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:24:51 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB8B12BF5B;
        Sat, 19 Feb 2022 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645295072; x=1676831072;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VS6tHIKsBZ6g2gxigj4Akj9iPgXhXwpFwPyKfVPvOFM=;
  b=S0yAPriSJVzKd1PxgDwgpKmCeqrxrrz7Q+NWK/b6uOYLHYavMc66SiD3
   yLp4DfAKeEuLPA6mMvNXin5pH9PPYwLr38odGimWk5A5OIMgxLV+YyVW1
   3GDA11uxcDSIb00y8wSil0ERGEIqEBPtOMibF7m+odahSrC6BSOqAmvQq
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 19 Feb 2022 10:24:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 10:24:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 19 Feb 2022 10:24:30 -0800
Received: from [10.216.20.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sat, 19 Feb
 2022 10:24:23 -0800
Message-ID: <628bfaf8-7f3b-ad79-15cb-c45c4a2b3dd2@quicinc.com>
Date:   Sat, 19 Feb 2022 23:54:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 4/7] pinctrl: qcom: Update lpi pin group structure
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <perex@perex.cz>, <quic_plai@quicinc.com>, <robh+dt@kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-5-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n51vhcUg5ng7FWzS0-09-zazCk5JKwpvLPfK4w15_r97kw@mail.gmail.com>
From:   "Srinivasa Rao Mandadapu (Temp)" <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n51vhcUg5ng7FWzS0-09-zazCk5JKwpvLPfK4w15_r97kw@mail.gmail.com>
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


On 2/19/2022 8:08 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-14 07:19:51)
>> @@ -150,20 +148,20 @@ enum sm8250_lpi_functions {
>>          LPI_MUX__,
>>   };
>>
>> -static const unsigned int gpio0_pins[] = { 0 };
>> -static const unsigned int gpio1_pins[] = { 1 };
>> -static const unsigned int gpio2_pins[] = { 2 };
>> -static const unsigned int gpio3_pins[] = { 3 };
>> -static const unsigned int gpio4_pins[] = { 4 };
>> -static const unsigned int gpio5_pins[] = { 5 };
>> -static const unsigned int gpio6_pins[] = { 6 };
>> -static const unsigned int gpio7_pins[] = { 7 };
>> -static const unsigned int gpio8_pins[] = { 8 };
>> -static const unsigned int gpio9_pins[] = { 9 };
>> -static const unsigned int gpio10_pins[] = { 10 };
>> -static const unsigned int gpio11_pins[] = { 11 };
>> -static const unsigned int gpio12_pins[] = { 12 };
>> -static const unsigned int gpio13_pins[] = { 13 };
>> +static int gpio0_pins[] = { 0 };
> Why do we lose const?
Const here is creating conflicts with gpio group_desc structure!!!
>
>> +static int gpio1_pins[] = { 1 };
>> +static int gpio2_pins[] = { 2 };
>> +static int gpio3_pins[] = { 3 };
>> +static int gpio4_pins[] = { 4 };
>> +static int gpio5_pins[] = { 5 };
>> +static int gpio6_pins[] = { 6 };
>> +static int gpio7_pins[] = { 7 };
>> +static int gpio8_pins[] = { 8 };
>> +static int gpio9_pins[] = { 9 };
>> +static int gpio10_pins[] = { 10 };
>> +static int gpio11_pins[] = { 11 };
>> +static int gpio12_pins[] = { 12 };
>> +static int gpio13_pins[] = { 13 };
>>   static const char * const swr_tx_clk_groups[] = { "gpio0" };
>>   static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
>>   static const char * const swr_rx_clk_groups[] = { "gpio3" };
