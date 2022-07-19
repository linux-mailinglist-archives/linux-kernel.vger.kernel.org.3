Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36C65791A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiGSEHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbiGSEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:07:18 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CD432EF9;
        Mon, 18 Jul 2022 21:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658203637; x=1689739637;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=jU56txNrlLvbYZzZ6gj0i6vcpYygudkLhnYlO1eIeYw=;
  b=PVEn2N6NhanL20A8FTCfn+OaN8DHZGIE4JEY9hy+2O37VBe19HPk5XS+
   s74j7Q0vVBcYn52sX1UVl3Ah2Y3hA6cF2hAYuV6+I2cEih8LLoWZnnckt
   WlAQVhg/bgNwVquaByonXU04FHGmAZKWxkOFgLIzN1TpgD9zlFPsJbMgP
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Jul 2022 21:07:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 21:07:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Jul 2022 21:07:16 -0700
Received: from [10.216.42.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Jul
 2022 21:07:10 -0700
Message-ID: <e4dcdd8d-18a9-8da3-7ac3-6cc792139f70@quicinc.com>
Date:   Tue, 19 Jul 2022 09:37:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Freedreno] [PATCH v2 5/7] arm64: dts: qcom: sc7280: Update gpu
 register list
Content-Language: en-US
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>, <quic_rjendra@quicinc.com>
CC:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220709112837.v2.5.I7291c830ace04fce07e6bd95a11de4ba91410f7b@changeid>
 <CAD=FV=XzvcjS51q78BZ=FPCEVUDMD+VKJ70ksCm5V4qwHN_wRg@mail.gmail.com>
 <c022538d-c616-8f1a-e1c2-c11b5f0de670@quicinc.com>
In-Reply-To: <c022538d-c616-8f1a-e1c2-c11b5f0de670@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/2022 11:10 AM, Akhil P Oommen wrote:
> On 7/12/2022 4:57 AM, Doug Anderson wrote:
>> Hi,
>>
>> On Fri, Jul 8, 2022 at 11:00 PM Akhil P Oommen 
>> <quic_akhilpo@quicinc.com> wrote:
>>> Update gpu register array with gpucc memory region.
>>>
>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> index e66fc67..defdb25 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> @@ -2228,10 +2228,12 @@
>>>                          compatible = "qcom,adreno-635.0", 
>>> "qcom,adreno";
>>>                          reg = <0 0x03d00000 0 0x40000>,
>>>                                <0 0x03d9e000 0 0x1000>,
>>> -                             <0 0x03d61000 0 0x800>;
>>> +                             <0 0x03d61000 0 0x800>,
>>> +                             <0 0x03d90000 0 0x2000>;
>>>                          reg-names = "kgsl_3d0_reg_memory",
>>>                                      "cx_mem",
>>> -                                   "cx_dbgc";
>>> +                                   "cx_dbgc",
>>> +                                   "gpucc";
>> This doesn't seem right. Shouldn't you be coordinating with the
>> existing gpucc instead of reaching into its registers?
>>
>> -Doug
> IIUC, qcom gdsc driver doesn't ensure hardware is collapsed since they 
> are vote-able switches. Ideally, we should ensure that the hw has 
> collapsed for gpu recovery because there could be transient votes from 
> other subsystems like hypervisor using their vote register.
> 
> I am not sure how complex the plumbing to gpucc driver would be to allow 
> gpu driver to check hw status. OTOH, with this patch, gpu driver does a 
> read operation on a gpucc register which is in always-on domain. That 
> means we don't need to vote any resource to access this register.
> 
> Stephen/Rajendra/Taniya, any suggestion?
> 
> -Akhil.
> 
> 
Gentle ping.

-Akhil

