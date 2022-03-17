Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8504DC8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiCQOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiCQOV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:21:26 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248316CE51;
        Thu, 17 Mar 2022 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647526809; x=1679062809;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=27vm0JIz+Qk23Y8+teO3yhtr05xWyYX+RKmIIsewghA=;
  b=nx3frnG0dDXW2EICpNBnRbUHYfbn1cEpcnkIf80pS2oGFJozwDEQpx9C
   U5Al3MGbOybFCBrfhjOA97C3EJOk7n6Z8ViLEbJFRQC2azEAHvooTKz37
   Qqang4dwwo+D11PzHgHpwAYnQSqDeMzSYMQo8DmDIGkHafDMOd8rbwtSk
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Mar 2022 07:20:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:20:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 17 Mar 2022 07:20:08 -0700
Received: from [10.216.33.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 17 Mar
 2022 07:20:04 -0700
Message-ID: <f8fb6ac8-7f97-a3d6-a9b6-1eee4d0ffd86@quicinc.com>
Date:   Thu, 17 Mar 2022 19:50:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
References: <1644591438-6514-1-git-send-email-quic_srivasam@quicinc.com>
 <1644591438-6514-3-git-send-email-quic_srivasam@quicinc.com>
 <CAD=FV=Xm7UVXX9NQfKs+BymsZpG+aoYqvXXRL5WhJjEZRqi7ug@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAD=FV=Xm7UVXX9NQfKs+BymsZpG+aoYqvXXRL5WhJjEZRqi7ug@mail.gmail.com>
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


On 3/1/2022 6:40 AM, Doug Anderson wrote:
Thanks for your time Doug!!!
> Hi,
>
> On Fri, Feb 11, 2022 at 6:57 AM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
>> @@ -1750,6 +1751,64 @@
>>                          #clock-cells = <1>;
>>                  };
>>
>> +               lpass_cpu: audio-subsystem@3260000 {
>> +                       compatible = "qcom,sc7280-lpass-cpu";
>> +                       reg = <0 0x3260000 0 0xC000>,
>> +                             <0 0x3280000 0 0x29000>,
>> +                             <0 0x3340000 0 0x29000>,
>> +                             <0 0x336C000 0 0x3000>,
>> +                             <0 0x3987000 0 0x68000>,
>> +                             <0 0x3B00000 0 0x29000>;
> Lower case hex, please. ...and pad the address to 8 digits here (just
> don't do it in the unit address in the node name).
Okay.
>
>
>> +                       reg-names = "lpass-rxtx-cdc-dma-lpm",
>> +                                   "lpass-rxtx-lpaif",
>> +                                   "lpass-va-lpaif",
>> +                                   "lpass-va-cdc-dma-lpm",
>> +                                   "lpass-hdmiif",
>> +                                   "lpass-lpaif";
> The order of "reg" and "reg-names" needs to match the bindings
> exactly. It's almost certainly easier to change your device tree since
> the bindings have already landed.
>
> That means that "lpass-hdmiif" will be first. ...and it will also
> change your node name since the first "reg" listed will now be
> 3987000.
Okay. will sort it accordingly.
>
>
>> +                       iommus = <&apps_smmu 0x1820 0>,
>> +                                <&apps_smmu 0x1821 0>,
>> +                                <&apps_smmu 0x1832 0>;
>> +                       status = "disabled";
>> +
>> +                       power-domains = <&rpmhpd SC7280_LCX>;
>> +                       power-domain-names = "lcx";
> power-domain-names is not in the bindings.
Okay. will update it.
>
>
>> +                       required-opps = <&rpmhpd_opp_nom>;
>> +
>> +                       clocks = <&lpass_aon LPASS_AON_CC_AUDIO_HM_H_CLK>,
>> +                                <&lpasscore LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK>,
>> +                                <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM_CLK>,
>> +                                <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM0_CLK>,
>> +                                <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM1_CLK>,
>> +                                <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM2_CLK>,
>> +                                <&lpasscore LPASS_CORE_CC_EXT_IF0_IBIT_CLK>,
>> +                                <&lpasscore LPASS_CORE_CC_EXT_IF1_IBIT_CLK>,
>> +                                <&lpass_aon LPASS_AON_CC_VA_MEM0_CLK>;
>> +                       clock-names = "aon_cc_audio_hm_h",
>> +                                     "core_cc_sysnoc_mport_core",
>> +                                     "audio_cc_codec_mem",
>> +                                     "audio_cc_codec_mem0",
>> +                                     "audio_cc_codec_mem1",
>> +                                     "audio_cc_codec_mem2",
>> +                                     "core_cc_ext_if0_ibit",
>> +                                     "core_cc_ext_if1_ibit",
>> +                                     "aon_cc_va_mem0";
> Clocks do not match bindings.
Okay. Will change accordingly.
>
>
>> +                       #sound-dai-cells = <1>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +                       interrupt-names = "lpass-irq-lpaif",
>> +                                         "lpass-irq-vaif",
>> +                                         "lpass-irq-rxtxif",
>> +                                         "lpass-irq-hdmi";
> interrupt-names ordering does not match bindings.
Okay. will sort it.
>
>
> -Doug
