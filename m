Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22BB511F58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiD0RIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243738AbiD0RIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:08:16 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7231176;
        Wed, 27 Apr 2022 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651079105; x=1682615105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kH97Sa0KlbrtltI15F5auUcDYmFi5BlYiDogm4o3Nj0=;
  b=J4QwnSA7i1s0vrqKcy+jSBVkoC6LBpOP+foSLyNlECztLrswI3nzLYJW
   P08c1MmL01UYqffem+zsegeMwP0GINgwMLNYAKO81Jnzuq5jPciHcSIXR
   VD372h9gMiIonn/YQ4d+52eReGfgyhh29YMnCubkvzIhM5u8l8aYupw6D
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2022 10:05:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:05:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 10:05:04 -0700
Received: from [10.216.24.54] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 10:04:59 -0700
Message-ID: <81e586fd-f3c5-b7cf-938b-817d1acbe734@quicinc.com>
Date:   Wed, 27 Apr 2022 22:34:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v11 4/4] arm64: dts: qcom: sc7280-herobrine: Add lpi
 pinmux properties for CRD 3.0/3.1
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650957666-6266-1-git-send-email-quic_srivasam@quicinc.com>
 <1650957666-6266-5-git-send-email-quic_srivasam@quicinc.com>
 <YmhsGMd49+AS+K3C@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmhsGMd49+AS+K3C@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/2022 3:33 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Tue, Apr 26, 2022 at 12:51:06PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> Subject: arm64: dts: qcom: sc7280-herobrine: Add lpi pinmux properties for CRD 3.0/3.1
>>
>> Add LPASS LPI pinctrl properties, which are required for Audio
>> functionality on herobrine based platforms of rev5+
>> (aka CRD 3.0/3.1) boards.
> Same as for patch [2/4], the patch alleges to configure the CRD 3.x
> config but sets it for all herobrine base boards, which isn't correct.
>
> Please move it to sc7280-herobrine-crd.dts
Okay. Will do accordingly.
