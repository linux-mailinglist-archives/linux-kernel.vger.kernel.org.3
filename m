Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F994900F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiAQFHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:07:34 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:12407 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbiAQFHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642396051; x=1673932051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5ZwymVr3jkawKV31tcO2DRz4wA5yk7+rY1ZZK56L5OI=;
  b=p/+065PB1TrYOpphY9+eBk9v4iG6sFdK7iUx5HeAGPXYIA1xdOnJQGXz
   yvXcrkRu7PRYqec8GUepc2dzKGlI3+5I+m8M809REMdiAo3WP0nKWlcyp
   ctc8c9VUBTdXM0fx93CBoL36/RUEY30El/wH5vXR7pSVA3N+huJtmTzA+
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Jan 2022 21:07:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:07:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:07:29 -0800
Received: from [10.50.10.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 16 Jan
 2022 21:07:24 -0800
Message-ID: <43850d22-0e50-76c4-2f05-b768401ff49c@quicinc.com>
Date:   Mon, 17 Jan 2022 10:37:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 5/7] arm64: dts: qcom: sc7280: Add EUD dt node and dwc3
 connector
Content-Language: en-CA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
        <tsoni@codeaurora.org>, <psodagud@codeaurora.org>,
        <satyap@codeaurora.org>, <pheragu@codeaurora.org>,
        <rnayak@codeaurora.org>, <sibis@codeaurora.org>,
        <saiprakash.ranjan@codeaurora.org>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
 <baf41480be71bd4472fe09c2993e43a780554d94.1641288286.git.quic_schowdhu@quicinc.com>
 <YdeO/T0kQtNQfmx+@ripper>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YdeO/T0kQtNQfmx+@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/2022 6:23 AM, Bjorn Andersson wrote:
> On Tue 04 Jan 03:58 PST 2022, Souradeep Chowdhury wrote:
>
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
> I think this is backwards.
>
> Iiuc you have dwc3 <-> EUD <-> connector, where the connector typically
> would be represented in relation to a Type-C controller.
>
> So I think this graph should be looking something like:
>
>
> dwc3 {
>      ports {
>          port {
>              dwc3_eud: endpoint {
>                  remote-endpoint = <&eud_ep>;
>              };
>          };
>      };
> };
>
> eud {
>      ports {
>          port {
>              eud_dwc3: endpoint {
>                  remote-endpoint = <&dwc3_eud>;
>              };
>          };
>
>          port {
>              eud_con: endpoint {
>                  remote-endpoint = <&con_eud>;
>              };
>          };
>      };
> };
>
> connector {
>      compatible = "usb-c-connector";
>
>      ports {
>          port {
>              con_eud: endpoint {
>                  remote-endpoint = <&eud_con>;
>              };
>          };
>      };
> };
>
> With EUD "forwarding" the role switching requests from the connector, or
> overriding them if the EUD is enabled.
>
> Alternatively the dwc3 would be in a graph with both the eud and the
> connector, but I don't know how to ensure that the EUD decision takes
> precedence over the type-c controllers role request...
>
>
> In the case of us having a type-c controller, such as the pmic_glink,
> the connector node would then be a child of the controller.
Ack. Will align the device tree with this structure.
>
> Regards,
> Bjorn
>
>> +					compatible = "qcom,usb-connector-eud",
>> +						     "usb-c-connector";
>> +					ports {
>> +						port@0 {
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
