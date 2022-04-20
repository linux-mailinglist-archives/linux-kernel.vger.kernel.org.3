Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECAC508E09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380900AbiDTRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380881AbiDTRKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:10:40 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D252B1838D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:07:52 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5C5423F7E6;
        Wed, 20 Apr 2022 19:07:50 +0200 (CEST)
Message-ID: <3d72faf6-e574-63af-e0e0-3d7035dc56a0@somainline.org>
Date:   Wed, 20 Apr 2022 19:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v5 09/10] ARM: dts: msm: Add coresight components for
 SM8250
To:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com>
 <20220412125035.40312-10-quic_jinlmao@quicinc.com>
 <f8c758a0-8e6d-85e6-3af2-640b33a92ce9@gmail.com>
 <4464bd92-c104-3c3c-d077-d1b8ced76410@quicinc.com>
 <CAJ9a7VhxPiA_arCg2LRki8eqx-OyipTxLp7TbiVfe2Dajm3wig@mail.gmail.com>
 <68f40eec-6398-2340-7ed2-ba904fa587a6@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <68f40eec-6398-2340-7ed2-ba904fa587a6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/04/2022 11:53, Jinlong Mao wrote:
> Hi Mike & Konrad,
>
>
> On 4/14/2022 9:40 PM, Mike Leach wrote:
>> Hi
>>
>> On Wed, 13 Apr 2022 at 17:45, Jinlong Mao <quic_jinlmao@quicinc.com> 
>> wrote:
>>> Hi Konrad,
>>>
>>> Thank you for the review.
>>>
>>> On 4/13/2022 5:58 PM, Konrad Dybcio wrote:
>>>> Hi,
>>>>
>>>>
>>>> I added Bjorn, the linux-arm-msm maintainer to CC as he was missing
>>>> for some reason.
>>>>
>>>>
>>>> On 12/04/2022 14:50, Mao Jinlong wrote:
>>>>> Add coresight device tree for sm8250. STM/ETM are added.
>>>>>
>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>>> ---
>>>>>    .../arm64/boot/dts/qcom/sm8250-coresight.dtsi | 526 
>>>>> ++++++++++++++++++
>>>>>    arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +
>>>>>    2 files changed, 528 insertions(+)
>>>>>    create mode 100644 arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
>>>>> b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..1de42fd39248
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
>>>>> @@ -0,0 +1,526 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> sm8250.dtsi is BSD-3-Clause. Please consider relicensing.
>>>>
>>>>
>>>>> +/*
>>>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights
>>>>> reserved.
>>>>> + */
>>>>> +
>>>>> +&soc {
>>>>> +
>>>>> +    stm@6002000 {
>>>>> +        compatible = "arm,coresight-stm", "arm,primecell";
>>>>> +        reg = <0 0x06002000 0 0x1000>,
>>>> You don't need to break the line at so few characters.
>>>>
>>>>
>>>>> +              <0 0x16280000 0 0x180000>;
>>>>> +        reg-names = "stm-base", "stm-stimulus-base";
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                stm_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&funnel0_in7>;
>>>> Same here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    funnel@6041000 {
>>>>> +        compatible = "arm,coresight-dynamic-funnel", 
>>>>> "arm,primecell";
>>>>> +        reg = <0 0x06041000 0 0x1000>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                funnel0_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&merge_funnel_in0>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        in-ports {
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <0>;
>>>>> +
>>>>> +            port@7 {
>>>>> +                reg = <7>;
>>>>> +                funnel0_in7: endpoint {
>>>>> +                    remote-endpoint = <&stm_out>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    funnel@6042000 {
>>>>> +        compatible = "arm,coresight-dynamic-funnel", 
>>>>> "arm,primecell";
>>>>> +        reg = <0 0x06042000 0 0x1000>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                funnel2_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&merge_funnel_in2>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        in-ports {
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <0>;
>>>>> +
>>>>> +            port@2 {
>>>>> +                reg = <4>;
>>>>> +                funnel2_in5: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_merge_funnel_out>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    funnel@6b04000 {
>>>>> +        compatible = "arm,coresight-dynamic-funnel", 
>>>>> "arm,primecell";
>>>>> +        arm,primecell-periphid = <0x000bb908>;
>>>>> +
>>>>> +        reg = <0 0x6b04000 0 0x1000>;
>>>>> +        reg-names = "funnel-base";
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                merge_funnel_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                        <&etf_in>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        in-ports {
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <0>;
>>>>> +
>>>>> +            port@7 {
>>>>> +                reg = <7>;
>>>>> +                funnel_swao_in_funnel_merg: endpoint {
>>>>> +                    remote-endpoint=
>>>> And here.
>>>>
>>>>
>>>>> + <&funnel_merg_out_funnel_swao>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +    };
>>>>> +
>>>>> +    funnel@6045000 {
>>>> The nodes are not sorted properly (by address). Please fix that.
>>>>
>>>>
>>>>> +        compatible = "arm,coresight-dynamic-funnel", 
>>>>> "arm,primecell";
>>>>> +        reg = <0 0x06045000 0 0x1000>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                funnel_merg_out_funnel_swao: endpoint {
>>>>> +                    remote-endpoint = <&funnel_swao_in_funnel_merg>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        in-ports {
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <0>;
>>>>> +
>>>>> +            port@1 {
>>>>> +                reg = <0>;
>>>>> +                merge_funnel_in0: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&funnel0_out>;
>>>>> +                };
>>>>> +            };
>>>>> +
>>>>> +            port@2 {
>>>>> +                reg = <1>;
>>>>> +                merge_funnel_in2: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&funnel2_out>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    replicator@6046000 {
>>>>> +        compatible = "arm,coresight-dynamic-replicator",
>>>>> "arm,primecell";
>>>>> +        reg = <0 0x06046000 0 0x1000>;
>>>>> +
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                replicator_out: endpoint {
>>>>> +                    remote-endpoint = <&etr_in>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        in-ports {
>>>>> +            port {
>>>>> +                replicator_cx_in_swao_out: endpoint {
>>>>> +                    remote-endpoint = <&replicator_swao_out_cx_in>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    replicator@6b06000 {
>>>>> +        compatible = "arm,coresight-dynamic-replicator",
>>>>> "arm,primecell";
>>>>> +        reg = <0 0x06b06000 0 0x1000>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                replicator_swao_out_cx_in: endpoint {
>>>>> +                    remote-endpoint = <&replicator_cx_in_swao_out>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        in-ports {
>>>>> +            port {
>>>>> +                replicator_in: endpoint {
>>>>> +                    remote-endpoint = <&etf_out>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etf@6b05000 {
>>>>> +        compatible = "arm,coresight-tmc", "arm,primecell";
>>>>> +        reg = <0 0x6b05000 0 0x1000>;
>>>> Please pad the address to 8 chars.
>>>>
>>>>
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                etf_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&replicator_in>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        in-ports {
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <0>;
>>>>> +
>>>>> +            port@1 {
>>>>> +                reg = <0>;
>>>>> +                etf_in: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&merge_funnel_out>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etr@6048000 {
>>>>> +        compatible = "arm,coresight-tmc", "arm,primecell";
>>>>> +        reg = <0 0x06048000 0 0x1000>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +        arm,scatter-gather;
>>>>> +
>>>>> +        in-ports {
>>>>> +            port {
>>>>> +                etr_in: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&replicator_out>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etm@7040000 {
>>>>> +        compatible = "arm,coresight-etm4x", "arm,primecell";
>>>>> +        reg = <0 0x07040000 0 0x1000>;
>>>>> +
>>>>> +        cpu = <&CPU0>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +        arm,coresight-loses-context-with-cpu;
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                etm0_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_funnel_in0>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etm@7140000 {
>>>>> +        compatible = "arm,coresight-etm4x", "arm,primecell";
>>>>> +        reg = <0 0x07140000 0 0x1000>;
>>>>> +
>>>>> +        cpu = <&CPU1>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +        arm,coresight-loses-context-with-cpu;
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                etm1_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_funnel_in1>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etm@7240000 {
>>>>> +        compatible = "arm,coresight-etm4x", "arm,primecell";
>>>>> +        reg = <0 0x07240000 0 0x1000>;
>>>>> +
>>>>> +        cpu = <&CPU2>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +        arm,coresight-loses-context-with-cpu;
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                etm2_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_funnel_in2>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etm@7340000 {
>>>>> +        compatible = "arm,coresight-etm4x", "arm,primecell";
>>>>> +        reg = <0 0x07340000 0 0x1000>;
>>>>> +
>>>>> +        cpu = <&CPU3>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +        arm,coresight-loses-context-with-cpu;
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                etm3_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_funnel_in3>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etm@7440000 {
>>>>> +        compatible = "arm,coresight-etm4x", "arm,primecell";
>>>>> +        reg = <0 0x07440000 0 0x1000>;
>>>>> +
>>>>> +        cpu = <&CPU4>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +        arm,coresight-loses-context-with-cpu;
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                etm4_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_funnel_in4>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etm@7540000 {
>>>>> +        compatible = "arm,coresight-etm4x", "arm,primecell";
>>>>> +        reg = <0 0x07540000 0 0x1000>;
>>>>> +
>>>>> +        cpu = <&CPU5>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +        arm,coresight-loses-context-with-cpu;
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                etm5_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_funnel_in5>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etm@7640000 {
>>>>> +        compatible = "arm,coresight-etm4x", "arm,primecell";
>>>>> +        reg = <0 0x07640000 0 0x1000>;
>>>>> +
>>>>> +        cpu = <&CPU6>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +        arm,coresight-loses-context-with-cpu;
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                etm6_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_funnel_in6>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    etm@7740000 {
>>>>> +        compatible = "arm,coresight-etm4x", "arm,primecell";
>>>>> +        reg = <0 0x07740000 0 0x1000>;
>>>>> +
>>>>> +        cpu = <&CPU7>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +        arm,coresight-loses-context-with-cpu;
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                etm7_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_funnel_in7>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    funnel@7800000 {
>>>>> +        compatible = "arm,coresight-dynamic-funnel", 
>>>>> "arm,primecell";
>>>>> +        reg = <0 0x07800000 0 0x1000>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                apss_funnel_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_merge_funnel_in>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        in-ports {
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <0>;
>>>>> +
>>>>> +            port@0 {
>>>>> +                reg = <0>;
>>>>> +                apss_funnel_in0: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&etm0_out>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +
>>>>> +            port@1 {
>>>>> +                reg = <1>;
>>>>> +                apss_funnel_in1: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&etm1_out>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +
>>>>> +            port@2 {
>>>>> +                reg = <2>;
>>>>> +                apss_funnel_in2: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&etm2_out>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +
>>>>> +            port@3 {
>>>>> +                reg = <3>;
>>>>> +                apss_funnel_in3: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&etm3_out>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +
>>>>> +            port@4 {
>>>>> +                reg = <4>;
>>>>> +                apss_funnel_in4: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&etm4_out>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +
>>>>> +            port@5 {
>>>>> +                reg = <5>;
>>>>> +                apss_funnel_in5: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&etm5_out>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +
>>>>> +            port@6 {
>>>>> +                reg = <6>;
>>>>> +                apss_funnel_in6: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&etm6_out>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +
>>>>> +            port@7 {
>>>>> +                reg = <7>;
>>>>> +                apss_funnel_in7: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&etm7_out>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    funnel@7810000 {
>>>>> +        compatible = "arm,coresight-dynamic-funnel", 
>>>>> "arm,primecell";
>>>>> +        reg = <0 0x07810000 0 0x1000>;
>>>>> +
>>>>> +        clocks = <&aoss_qmp>;
>>>>> +        clock-names = "apb_pclk";
>>>>> +
>>>>> +        out-ports {
>>>>> +            port {
>>>>> +                apss_merge_funnel_out: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&funnel2_in5>;
>>>> And here.
>>>>
>>>>
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        in-ports {
>>>>> +            port@1 {
>>>>> +                reg = <0>;
>>>>> +                apss_merge_funnel_in: endpoint {
>>>>> +                    remote-endpoint =
>>>>> +                      <&apss_funnel_out>;
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>>>> b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>>>> index af8f22636436..115623392183 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>>>> @@ -5434,3 +5434,5 @@
>>>>>            };
>>>>>        };
>>>>>    };
>>>>> +
>>>>> +#include "sm8250-coresight.dtsi"
>>>> Why should everybody want coresight? It's not enabled on (most)
>>>> production devices and may cause a platform crash when you try to use
>>>> it on such ones.
>>>>
>>>>
>>>> These nodes should probably be added to sm8250.dtsi, all with status =
>>>> "disabled" by default, so that they don't break the devices that do
>>>> not support it due to fuse configuration.
>>>>
>>> I will address your comments above.
>>> I create coresight dtsi because of that there are dozens of coresight
>>> nodes for qualcomm HW.
>>> Add all the nodes in a separate file is easy to maintain.
>>> For disabling all the nodes by default, i will check internally and get
>>> back to you.
>>>
>> If the nodes are "disabled", then the base .dts files for platforms
>> that do include coresight would have to be updated to enable all those
>> nodes - which leaves potential for errors if nodes are accidentally
>> omitted.
>>
>> Because sm8250-coresight.dtsi contains only Coresight devices, would
>> it not be better to include this directly in the base .dts file for
>> platforms that do have Coresight, and omit it from those that do not.
>>
>> Regards
>>
>> Mike
>>
> I checked internally. These coresight nodes are tested on our secure 
> device.

I had an opportunity to confirm this, sorry for spreading unnecessary 
FUD, but this used to be an issue on some older boards.


> They won't cause any crash issue on secure device with fuse blown.
> If any platform doesn't need to coresight support, it can control by 
> the coresight kernel configs.

No, the arm64 kernel is supposed to run on hundreds if not thousands of 
boards with a common config (just like on x86/_64 machines). Our job is 
to make it fully functional with the arm64 defconfig, and that's what 
the status property is effectively for in device trees. You don't get to 
decide what is enabled or not in the config based on individual device 
capabilities.


Since we've established that Coresight doesn't break secure devices, I 
take back that status = "disabled" comment, it's not necessary. Please 
move all the nodes to the SoC dtsi though, as they are specific only to 
sm8250 and won't be included anywhere else.


Konrad

>
>
> Regards
> Jinlong Mao
>
>
>>> Thanks
>>> Jinlong Mao
>>>
>>>
>>>> Konrad
>>>>
>>
>>
