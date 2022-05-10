Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2E52132B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbiEJLKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiEJLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:10:45 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F7753B43;
        Tue, 10 May 2022 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652180808; x=1683716808;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WZ+KihdBIA9Ny1u9rrgyetEqOc7+kDgs+95xTy1MvPg=;
  b=y2PWjp6czOQYvcVnuPUKbMtyEdeeuPzgJ1VTf9OcWyWbpXIUugbEw9xF
   3pSbPZ/gFm8hD9nniFOZcInZc8MB3aF6avNELqsV4Tcrl8QwsSo7XEBj2
   j1dDUq3TtNSU1ji6lj1Q0C8MztEQT8HAtNfzW7QYu7pS0YZbCtMQizdyF
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 May 2022 04:06:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 04:06:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 04:06:47 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 04:06:39 -0700
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add SC7280 MSS
 bindings
To:     Matthias Kaehlcke <mka@chromium.org>, Rob Herring <robh@kernel.org>
CC:     <swboyd@chromium.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <mathieu.poirier@linaro.org>,
        <krzysztof.kozlowski@canonical.com>, <agross@kernel.org>,
        <dianders@chromium.org>, <ohad@wizery.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <evgreen@chromium.org>
References: <1652082798-5855-1-git-send-email-quic_sibis@quicinc.com>
 <1652082798-5855-2-git-send-email-quic_sibis@quicinc.com>
 <1652098858.589911.3576234.nullmailer@robh.at.kernel.org>
 <YnlpU+sCfO86+qc2@google.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <765e57e3-a780-3553-62b6-b8713a21c0d8@quicinc.com>
Date:   Tue, 10 May 2022 16:36:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YnlpU+sCfO86+qc2@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Matthias,
Thanks for taking time to review the series.

I'll re-order the clock names in the bindings and fix the pdc_sync typo
in the next re-spin. The interconnects missing warnings should go away
since patch 2 adds it.

-Sibi

On 5/10/22 12:49 AM, Matthias Kaehlcke wrote:
> On Mon, May 09, 2022 at 07:20:58AM -0500, Rob Herring wrote:
>> On Mon, 09 May 2022 13:23:17 +0530, Sibi Sankar wrote:
>>> Add MSS PIL loading bindings for SC7280 SoCs.
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>>   .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 261 +++++++++++++++++++++
>>>   1 file changed, 261 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> The culprit is this snippet in arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi:
> 
> /* Modem setup is different on Chrome setups than typical Qualcomm setup */
> &remoteproc_mpss {
> 	status = "okay";
> 	compatible = "qcom,sc7280-mss-pil";
> 	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> 	memory-region = <&mba_mem>, <&mpss_mem>;
> };
> 
> The original compatible string from sc7280.dtsi is 'qcom,sc7280-mpss-pas'.
> 
>> remoteproc@4080000: clock-names:1: 'snoc_axi' was expected
>> 	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-idp.dtb
>>
>> remoteproc@4080000: clock-names:2: 'offline' was expected
>> 	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-idp.dtb
> 
> The fix probably consists in adding overrides for 'clocks' and
> 'clock-names' to the extension in sc7280-chrome-common.dtsi, unless
> we add a dedicated 'qcom,sc7280-mss-pil' node to sc7280.dtsi. This
> can be done once the binding landed.
> 
>> remoteproc@4080000: 'interconnects' is a required property
>> 	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-idp.dtb
> 
> This can be fixed by adding an 'interconnects' to either the
> extension in sc7280-chrome-common.dtsi, or the original node if
> 'qcom,sc7280-mpss-pas' uses the same interconnect.
> 
>> remoteproc@4080000: reset-names:1: 'pdc_sync' was expected
>> 	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
>> 	arch/arm64/boot/dts/qcom/sc7280-idp.dtb
>>
> 
> This could be fixed by aligning the reset names of the
> 'qcom,sc7280-mpss-pas' and 'qcom,sc7280-mss-pil' bindings.
> The reset is called 'pdc_reset' for 'mpss-pas', and 'pdc_sync'
> for 'mpss-pil'.
> 
