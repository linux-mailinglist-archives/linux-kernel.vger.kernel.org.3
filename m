Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21B1511920
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbiD0Oa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbiD0Oaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:30:55 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E159FDA;
        Wed, 27 Apr 2022 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651069663; x=1682605663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M3SYFGLPWzKvtp1WGADcPgzrAp27QvnoGE8k0g5v2OY=;
  b=tlNcXdd6MfaddGC0FAtk4FdAsF++y2C6e//raC6TsJGo+ufrZJ21eCtx
   5UWePTfpJGyNB1DTy5kc8yGG7vUaEc9MUi7eXXOeX28NE7jI/i3bUTyFU
   RAOpyxDZqV0y6YUr8X0lgA7G98RBU/JLsSgcBH4Upt14widtbby4UD0Z8
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2022 07:27:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 07:27:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 07:27:42 -0700
Received: from [10.253.36.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 07:27:38 -0700
Message-ID: <5752f130-c040-6156-44dc-497011f2a78e@quicinc.com>
Date:   Wed, 27 Apr 2022 22:27:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 10/10] ARM: dts: msm: Add tpdm mm/prng for sm8250
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220425040304.37487-1-quic_jinlmao@quicinc.com>
 <20220425040304.37487-11-quic_jinlmao@quicinc.com>
 <a5daf7ed-9baa-5684-4823-30b0cca69488@somainline.org>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <a5daf7ed-9baa-5684-4823-30b0cca69488@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Konrad for the review.

On 4/26/2022 7:49 PM, Konrad Dybcio wrote:
>
> On 25/04/2022 06:03, Mao Jinlong wrote:
>> Add tpdm mm and tpdm prng for sm8250.
>>
>> +---------------+                +-------------+
>> |  tpdm@6c08000 |                |tpdm@684C000 |
>> +-------|-------+                +------|------+
>>          |                               |
>> +-------|-------+                       |
>> | funnel@6c0b000|                       |
>> +-------|-------+                       |
>>          |                               |
>> +-------|-------+                       |
>> |funnel@6c2d000 |                       |
>> +-------|-------+                       |
>>          |                               |
>>          |    +---------------+          |
>>          +----- tpda@6004000  -----------+
>>               +-------|-------+
>>                       |
>>               +-------|-------+
>>               |funnel@6005000 |
>>               +---------------+
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 170 +++++++++++++++++++++++++++
>>   1 file changed, 170 insertions(+)
>
> Hi,
>
>
> some of the previous comments (uppercase hex instead of lowercase and 
> wrong commit title) still haven't been addressed.

I will double check and address your comments.

Thanks

Jinlong Mao

>
>
> Konrad
>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> index 53ab2b457a2f..ce558a2639e7 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> @@ -4703,6 +4703,73 @@
>>               };
>>           };
>>   +        tpda@6004000 {
>> +            compatible = "arm,primecell";
>> +            reg = <0 0x06004000 0 0x1000>;
>> +            reg-names = "tpda-base";
>> +
>> +            clocks = <&aoss_qmp>;
>> +            clock-names = "apb_pclk";
>> +
>> +            out-ports {
>> +                port {
>> +                    reg = <0>;
>> +                    tpda_out_funnel_qatb: endpoint {
>> +                        remote-endpoint = <&funnel_qatb_in_tpda>;
>> +                    };
>> +                };
>> +            };
>> +
>> +            in-ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@9 {
>> +                    reg = <9>;
>> +                    tpda_9_in_tpdm_mm: endpoint {
>> +                        remote-endpoint = <&tpdm_mm_out_tpda9>;
>> +                    };
>> +                };
>> +
>> +                port@23 {
>> +                    reg = <23>;
>> +                    tpda_23_in_tpdm_prng: endpoint {
>> +                        remote-endpoint = <&tpdm_prng_out_tpda_23>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +
>> +        funnel@6005000 {
>> +            compatible = "arm,primecell";
>> +
>> +            reg = <0 0x06005000 0 0x1000>;
>> +            reg-names = "funnel-base";
>> +
>> +            clocks = <&aoss_qmp>;
>> +            clock-names = "apb_pclk";
>> +
>> +            out-ports {
>> +                port {
>> +                    funnel_qatb_out_funnel_in0: endpoint {
>> +                        remote-endpoint = <&funnel_in0_in_funnel_qatb>;
>> +                    };
>> +                };
>> +            };
>> +
>> +            in-ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@0 {
>> +                    reg = <0>;
>> +                    funnel_qatb_in_tpda: endpoint {
>> +                        remote-endpoint = <&tpda_out_funnel_qatb>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +
>>           funnel@6041000 {
>>               compatible = "arm,coresight-dynamic-funnel", 
>> "arm,primecell";
>>               reg = <0 0x06041000 0 0x1000>;
>> @@ -4722,6 +4789,13 @@
>>                   #address-cells = <1>;
>>                   #size-cells = <0>;
>>   +                port@6 {
>> +                    reg = <6>;
>> +                    funnel_in0_in_funnel_qatb: endpoint {
>> +                        remote-endpoint = 
>> <&funnel_qatb_out_funnel_in0>;
>> +                    };
>> +                };
>> +
>>                   port@7 {
>>                       reg = <7>;
>>                       funnel0_in7: endpoint {
>> @@ -4836,6 +4910,23 @@
>>               };
>>           };
>>   +        tpdm@684C000 {
>> +            compatible = "arm,primecell";
>> +            reg = <0 0x0684C000 0 0x1000>;
>> +            reg-names = "tpdm-base";
>> +
>> +            clocks = <&aoss_qmp>;
>> +            clock-names = "apb_pclk";
>> +
>> +            out-ports {
>> +                port {
>> +                    tpdm_prng_out_tpda_23: endpoint {
>> +                        remote-endpoint = <&tpda_23_in_tpdm_prng>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +
>>           funnel@6b04000 {
>>               compatible = "arm,coresight-dynamic-funnel", 
>> "arm,primecell";
>>               arm,primecell-periphid = <0x000bb908>;
>> @@ -4920,6 +5011,85 @@
>>               };
>>           };
>>   +        tpdm@6c08000 {
>> +            compatible = "arm,primecell";
>> +            reg = <0 0x06c08000 0 0x1000>;
>> +            reg-names = "tpdm-base";
>> +
>> +            clocks = <&aoss_qmp>;
>> +            clock-names = "apb_pclk";
>> +
>> +            out-ports {
>> +                port {
>> +                    tpdm_mm_out_funnel_dl_mm: endpoint {
>> +                        remote-endpoint = <&funnel_dl_mm_in_tpdm_mm>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +
>> +        funnel@6c0b000 {
>> +            compatible = "arm,coresight-dynamic-funnel", 
>> "arm,primecell";
>> +
>> +            reg = <0 0x06c0b000 0 0x1000>;
>> +            reg-names = "funnel-base";
>> +
>> +            clocks = <&aoss_qmp>;
>> +            clock-names = "apb_pclk";
>> +
>> +            out-ports {
>> +                port {
>> +                    funnel_dl_mm_out_funnel_dl_center: endpoint {
>> +                        remote-endpoint = 
>> <&funnel_dl_center_in_funnel_dl_mm>;
>> +                    };
>> +                };
>> +            };
>> +
>> +            in-ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@3 {
>> +                    reg = <3>;
>> +                    funnel_dl_mm_in_tpdm_mm: endpoint {
>> +                        remote-endpoint = <&tpdm_mm_out_funnel_dl_mm>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +
>> +        funnel@6c2d000 {
>> +            compatible = "arm,coresight-dynamic-funnel", 
>> "arm,primecell";
>> +
>> +            reg = <0 0x06c2d000 0 0x1000>;
>> +            reg-names = "funnel-base";
>> +
>> +            clocks = <&aoss_qmp>;
>> +            clock-names = "apb_pclk";
>> +
>> +            out-ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                port {
>> +                    tpdm_mm_out_tpda9: endpoint {
>> +                        remote-endpoint = <&tpda_9_in_tpdm_mm>;
>> +                    };
>> +                };
>> +            };
>> +
>> +            in-ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@2 {
>> +                    reg = <2>;
>> +                    funnel_dl_center_in_funnel_dl_mm: endpoint {
>> +                        remote-endpoint = 
>> <&funnel_dl_mm_out_funnel_dl_center>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +
>>           etm@7040000 {
>>               compatible = "arm,coresight-etm4x", "arm,primecell";
>>               reg = <0 0x07040000 0 0x1000>;
