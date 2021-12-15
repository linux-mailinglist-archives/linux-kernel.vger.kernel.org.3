Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418C84758F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbhLOMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:36:28 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:39932 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242501AbhLOMg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639571786; x=1671107786;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9sxC78XQygJZeeTD71208lt2TeMRHyLi6SvJ7Zq/WFw=;
  b=ON1S5jMx2f/vFcntmwR/wUmx7NzV3yYtA44TYWiikp+MfqoGZPQ2dP+1
   3OUiiGqa0yWad6vVbjovPe0tf2G512647Y8JwLeI8GSuq3Ovo3DVHSFGJ
   1GxL9+zgdjV+v1dsNCsSUVRBCxm1zLFvA/ojsIDyCYGOiJdeM5z+plfn4
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Dec 2021 04:36:26 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 04:36:25 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 04:36:25 -0800
Received: from [10.50.9.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 15 Dec
 2021 04:36:19 -0800
Message-ID: <0e8322f2-0a6b-5b9f-09b1-b1e870cd6dd8@quicinc.com>
Date:   Wed, 15 Dec 2021 18:06:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 6/8] arm64: dts: qcom: sc7280: Add EUD dt node and dwc3
 connector
Content-Language: en-CA
To:     Rob Herring <robh@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
 <d035e37829c6f9ec8f01d1137020af635e34966f.1638430506.git.quic_schowdhu@quicinc.com>
 <YbemBSexMQRCVGYl@robh.at.kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YbemBSexMQRCVGYl@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/2021 1:29 AM, Rob Herring wrote:
> On Thu, Dec 02, 2021 at 03:21:25PM +0530, Souradeep Chowdhury wrote:
>> Add the Embedded USB Debugger(EUD) device tree node. The
>> node contains EUD base register region and EUD mode
>> manager register regions along with the interrupt entry.
>> Also add the connector to EUD which is mapped as the child
>> of dwc3. The connector is attached to EUD via port. Also add
>> the role-switch property to dwc3 node.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 53a21d0..2d14e5c 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -1315,6 +1315,18 @@
>>   				phys = <&usb_2_hsphy>;
>>   				phy-names = "usb2-phy";
>>   				maximum-speed = "high-speed";
>> +				usb-role-switch;
>> +				usb_con: eud_usb_connector {
>> +					compatible = "qcom,usb-connector-eud",
>> +						     "usb-c-connector";
>> +					ports {
>> +						port@0 {
> It is already defined that port@0 of the connector is USB HS data. Is
> that the case here? What about the SS lines?

As per the yaml documentation this is to be used for USB HS lines but in 
this case I am using the port to get the connector fwnode from the eud 
driver and then perform the role switch from the connector parent which 
is the dwc3 controller.  Should I update the yaml file to include this 
description?

>  From the description, it sounds like the data path is DWC3 -> EUD ->
> connector. The DT structure doesn't match that.

EUD is an independent QCOM IP , it is a mini usb hub which can only 
function in device mode. That's why it has been mapped as a separate 
device tree node connected to the type c connector via port endpoint to 
perform a role switch when necessary. I have kept EUD and connector at 
the same level as there is no direct data path from EUD to the connector 
and both are at a level below the controller.

>
>> +							usb2_role_switch: endpoint {
>> +								remote-endpoint = <&eud_ep>;
>> +							};
>> +						};
>> +					};
>> +				};
>>   			};
>>   		};
>>   
>> @@ -1339,6 +1351,19 @@
>>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>>   
>> +		eud:  eud@88e0000 {
>> +			compatible = "qcom,sc7280-eud","qcom,eud";
>> +			reg = <0 0x88e0000 0 0x2000>,
>> +			      <0 0x88e2000 0 0x1000>;
>> +			interrupt-parent = <&pdc>;
>> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
>> +			port {
>> +				eud_ep: endpoint {
>> +					remote-endpoint = <&usb2_role_switch>;
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
>>
