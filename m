Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2049E00A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiA0LAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:00:49 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:24298 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231951AbiA0LAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643281248; x=1674817248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fng95TnrnpFY+4goE4+k1PeF/SO9+jopsRW0TRRLI8Y=;
  b=pcxJnNSy4Ad/7OYUx89rqflUvFYvMspQ2gqtLfcHREg+ygjdOav/pk2t
   I3FmxJgNMjCWy3mFo72cX2xZo7NxkAToMvBl7E/c4pdauJ4MPhPgU+itW
   lYhWUGNx8Ssfybzb2yixNTpx+eKWAwfc6rz2K8HzwXGuwEuQo3xaqSXNi
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jan 2022 03:00:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 03:00:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 03:00:47 -0800
Received: from [10.50.37.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 27 Jan
 2022 03:00:41 -0800
Message-ID: <4471933f-3b49-708d-5573-f2b7bdf3f1c4@quicinc.com>
Date:   Thu, 27 Jan 2022 16:30:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 4/6] arm64: dts: qcom: sc7280: Add EUD dt node and dwc3
 connector
Content-Language: en-CA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <greg@kroah.com>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>
References: <cover.1642768837.git.quic_schowdhu@quicinc.com>
 <3ca56ffa9e4aa73f3c3f36d0edad0827ee11d953.1642768837.git.quic_schowdhu@quicinc.com>
 <YfDOBuT/9dEEDG6/@builder.lan>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YfDOBuT/9dEEDG6/@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/2022 9:58 AM, Bjorn Andersson wrote:
> On Fri 21 Jan 07:53 CST 2022, Souradeep Chowdhury wrote:
>
>> Add the Embedded USB Debugger(EUD) device tree node. The
>> node contains EUD base register region and EUD mode
>> manager register regions along with the interrupt entry.
>> Also add the typec connector node for EUD which is attached to
>> EUD node via port. EUD is also attached to DWC3 node via port.
>> Also add the role-switch property to dwc3 node.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 39 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 937c2e0..daac831 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2583,6 +2583,14 @@
>>   				phys = <&usb_2_hsphy>;
>>   				phy-names = "usb2-phy";
>>   				maximum-speed = "high-speed";
>> +				usb-role-switch;
>> +				ports {
>> +					port@0 {
>> +						usb2_role_switch: endpoint {
>> +							remote-endpoint = <&eud_ep>;
>> +						};
>> +					};
>> +				};
>>   			};
>>   		};
>>   
>> @@ -2624,6 +2632,37 @@
>>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>>   
>> +		eud: eud@88e0000 {
>> +			compatible = "qcom,sc7280-eud","qcom,eud";
>> +			reg = <0 0x88e0000 0 0x2000>,
>> +			      <0 0x88e2000 0 0x1000>;
>> +			interrupt-parent = <&pdc>;
>> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> I find "interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;" cleaner
> than having to specify both parent and interrupts.
Ack
>
>> +			ports {
>> +				port@0 {
>> +					eud_ep: endpoint {
>> +						remote-endpoint = <&usb2_role_switch>;
>> +					};
>> +				};
>> +				port@1 {
>> +					eud_con: endpoint {
>> +						remote-endpoint = <&con_eud>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		eud_typec: connector {
> The connector should be a child of the Type-C controller, which I know
> differs between the various devices on this platform. So you should
> leave &eud_con without a remote-endpoint and then fill that in for each
> device, based on respective Type-C controller.
>
>
> But beyond that, I think this design looks good now!
Ack
>
> Regards,
> Bjorn
>
>> +			compatible = "usb-c-connector";
>> +			ports {
>> +				port@0 {
>> +					con_eud: endpoint {
>> +						remote-endpoint = <&eud_con>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>>   		nsp_noc: interconnect@a0c0000 {
>>   			reg = <0 0x0a0c0000 0 0x10000>;
>>   			compatible = "qcom,sc7280-nsp-noc";
>> -- 
>> 2.7.4
>>
