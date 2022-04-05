Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53174F2249
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiDEE4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiDEE4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:56:41 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857D358390;
        Mon,  4 Apr 2022 21:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649134396; x=1680670396;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KsPTLE7Nz91fYwJnF0OStlCu2cPHLPfrkrKyxaT8oYk=;
  b=fTPF1JZiI/dRfgY8HmhOP8b6HMZed5qn5ibmoSv/3Me2SV4oNVEa27WW
   6+apw2m+dPfN0zuLRRIpfZLONgAQ3vqjlPEmDTqQEA1KYH/M4uoaSEQ6O
   R38G/7aJJtOcBAUcCcx9XHh5wQJmzgbjlJWvuGCzQOkiMLE+2b3BvjgZ2
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 04 Apr 2022 21:53:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 21:53:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 21:53:15 -0700
Received: from [10.216.10.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 21:53:11 -0700
Message-ID: <ef4c0532-dbf2-7ce3-3852-4b3887567423@quicinc.com>
Date:   Tue, 5 Apr 2022 10:23:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: sc7280: Add dt nodes for sound
 card
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1647865696-19192-1-git-send-email-quic_srivasam@quicinc.com>
 <1647865696-19192-4-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n535vbyis3APbVpSoKg8p7017HcYZHSoC=rtfngKp-3U9w@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n535vbyis3APbVpSoKg8p7017HcYZHSoC=rtfngKp-3U9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/2022 1:24 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!
> Quoting Srinivasa Rao Mandadapu (2022-03-21 05:28:16)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index ca799c2..369c1e9 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -84,6 +84,99 @@
>>                  pinctrl-names = "default";
>>                  pinctrl-0 = <&nvme_pwren>;
>>          };
>> +
>> +       sound: sound-card {
> How about
>
> 	sound: sound {
>
> It's not an actual sound card that you can plug in right?
Yes, it's not plug in sound-card. will change accordingly.
>
>> +               compatible = "google,sc7280-herobrine";
>> +               model = "sc7280-wcd938x-max98360a-1mic";
>> +               status = "okay";
> This status can be left out as it's the default.
Okay. will change accordingly.
