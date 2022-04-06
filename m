Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F64F5F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiDFNTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiDFNS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:18:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21285487836;
        Wed,  6 Apr 2022 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649239022; x=1680775022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ERPgTnXmQsu31W+J+z1B28Xpq+U2xik3DY6Aw2uFZUs=;
  b=uUq9cEFsJSkRVYq49Dflp/x9OfatQeEeHi2FB1cOFrF8MAmcxPAKXkOg
   f3+EuDyDNCO+vDGnLYMVJUhQajMLMElMhAMkxCMg2qhHZyKDknnA4Pf8n
   hbZrlYCGErUp//iko6jm3w7nPrIH3duQxh469mw1KbAj1WpDQNd4gKxXP
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Apr 2022 02:57:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 02:57:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 02:57:00 -0700
Received: from [10.216.35.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 02:56:52 -0700
Message-ID: <278b3ab9-a790-76f2-df6d-97b37d5e5e23@quicinc.com>
Date:   Wed, 6 Apr 2022 15:26:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Add reset entries for
 SDCC controllers
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <krzk+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>
CC:     <quic_rampraka@quicinc.com>, <quic_pragalla@quicinc.com>,
        <quic_sartgarg@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_sayalil@quicinc.com>
References: <1647532165-6302-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1647532165-6302-3-git-send-email-quic_c_sbhanu@quicinc.com>
 <CAE-0n53BBzgU6AJ70JNUBBkDZ1c9ZmpX8ZXLcxLxmmg1=UnSLw@mail.gmail.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <CAE-0n53BBzgU6AJ70JNUBBkDZ1c9ZmpX8ZXLcxLxmmg1=UnSLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review.

Please find the inline comments.

Thanks,
Sajida

On 4/2/2022 3:39 AM, Stephen Boyd wrote:
> Quoting Shaik Sajida Bhanu (2022-03-17 08:49:25)
>> Add gcc hardware reset entries for eMMC and SD card.
>>
>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index c07765d..cd50ea3 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -881,6 +881,10 @@
>>                          mmc-hs400-1_8v;
>>                          mmc-hs400-enhanced-strobe;
>>
>> +                       /* gcc hardware reset entry for eMMC */
> Please don't add this worthless comment.
>
>> +                       resets = <&gcc GCC_SDCC1_BCR>;
>> +                       reset-names = "core_reset";
> A "_reset" postfix is redundant. In fact, reset-names shouldn't even be
> required.
Ok
>> +
>>                          sdhc1_opp_table: opp-table {
>>                                  compatible = "operating-points-v2";
>>
>> @@ -2686,6 +2690,10 @@
>>
>>                          qcom,dll-config = <0x0007642c>;
>>
>> +                       /* gcc hardware reset entry for SD card */
> Please don't add this worthless comment.
Sure will remove the comment.
>> +                       resets = <&gcc GCC_SDCC2_BCR>;
>> +                       reset-names = "core_reset";
>> +
>>                          sdhc2_opp_table: opp-table {
>>                                  compatible = "operating-points-v2";
>>
