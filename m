Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99574F2282
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiDEFRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiDEFQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:16:49 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFFD63ED;
        Mon,  4 Apr 2022 22:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649135683; x=1680671683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m2Juybz+7NJAfGc0rzJA3sylhlwpR0QLf56QMjyPRBU=;
  b=TyaZ/tjNjWPclkgE2XR+2ZFmvVYr7nPIxTc3k8a2wJWagaU+hWFvCF04
   P/fuNbOwp632GjqbIz/7KM6vrcKeayWGof3h/xUlOLIxO4qUwKL/MFJtZ
   cEmv/gkFtRRhJ0tCuA6YeHeYJMyC+85c88BSTs7TIJoYPSL7PUUyHiYbI
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Apr 2022 22:14:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:14:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 22:14:43 -0700
Received: from [10.216.10.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 22:14:39 -0700
Message-ID: <0860a936-9570-43e2-d9e0-afe71ad1914a@quicinc.com>
Date:   Tue, 5 Apr 2022 10:44:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1647863959-3289-1-git-send-email-quic_srivasam@quicinc.com>
 <1647863959-3289-3-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n5131FQaejVVHKwW9ZnoGM+uy6+jjJZMkh5Pa82=r5ojuQ@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n5131FQaejVVHKwW9ZnoGM+uy6+jjJZMkh5Pa82=r5ojuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/2022 2:00 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-03-21 04:59:18)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 688fa95..4a7b18a 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -462,7 +462,28 @@
>>          drive-strength = <10>;
>>   };
>>
>> +&sec_mi2s_data0 {
>> +       drive-strength = <6>;
>> +       bias-disable;
>> +};
>> +
>> +&sec_mi2s_sclk {
>> +       drive-strength = <6>;
>> +       bias-disable;
>> +};
>> +
>> +&sec_mi2s_ws {
>> +       drive-strength = <6>;
>> +};
>> +
>>   &tlmm {
>> +       amp_en: amp-en {
>> +               pins = "gpio63";
>> +               function = "gpio";
> I'm pretty sure 'function = "gpio"' isn't needed. When a gpio is
> requested with gpio functions it gets muxed to gpio function
> automatically. See commit 1de7ddb3a15c ("pinctrl: msm: Mux out gpio
> function with gpio_request()").
Okay. Will remove it.
>
>> +               bias-pull-down;
>> +               drive-strength = <2>;
>> +       };
>> +
>>          bt_en: bt-en {
>>                  pins = "gpio85";
>>                  function = "gpio";
