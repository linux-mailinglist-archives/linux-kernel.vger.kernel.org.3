Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8541D4FF44C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiDMKBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbiDMKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:01:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56156C3F;
        Wed, 13 Apr 2022 02:58:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c64so1679703edf.11;
        Wed, 13 Apr 2022 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=3nCBmPZe2s1Tb5jToDoLn0hj8rLIj2CF7Q19aQNFA2k=;
        b=oA+nfF/+O4t/1mXfF66HZcSIp5InNnDHsNlvbV+VS6TR75OrILum37PYcnVYdg+1a2
         skENjWCYZrfZhMMywx9EHA3Iprh/z7FsQegwZdqpbc2HP5Zo6c6lBERdx8md32/4Gklp
         j9hWV0D1ngvf5AvGg5DVR5PYudBhXVEOHA7WUtfP0Qk2gS1cBlWUnUJZaa5XimuedrBG
         vhI4A0ejIkPTJb0ihg0fehGjz76N4sokDyfYqX1bnM6cB8OcE65WZbLiXtMBuPN9UA3l
         Xw1CFVg90sJ6j6ZjhnuAbPib/+QYSch3Igy4I1GNvP8R3bHbEixamaNKG890LyuDx+Pj
         33pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3nCBmPZe2s1Tb5jToDoLn0hj8rLIj2CF7Q19aQNFA2k=;
        b=qdrvpTElpl/QGZlx8SLObGMEaQqXJtjA4wXcw31KY4BWwNdCQoC5g2vlsNBkWXLqWN
         N2vpmTPR05cBSKx73HxiRUX/EOCDDu5616PTs3kjXJ/WUMILbZXWY2hRPV1hUf0kEYRh
         gTme4XwnqEWiwXhnmWa1qrHxW23nsB4qF3DBb5nG3b8c9mxfCmUxUCbynqSp6d0/lkYk
         3a2/SfTnPdg2nLcyYWitdhO4ckSIo4A+3OivbqFxruBr10OBn+xd+h9VaxsjpzsI+9BE
         UZxvrHsQQzeZZBOLzjM3pRQGMhFc1QaEkkZ1/Yp4t45SZlS6f6sUwK7vfLy3Qv9tJZtg
         1ifg==
X-Gm-Message-State: AOAM5305LTGXdfubkJ5nGHvRrxuwUkP8cvt7tuvMpy6vcN1WsC6kk17T
        el9VHq4P8BL+xUaBPpLFW5Y=
X-Google-Smtp-Source: ABdhPJz2quCohagy/UvRtbmxKt73u//23JTCO+NnnHAPzITLfw6JZlgfeUWdCkWsWilAMCt0oG9VFg==
X-Received: by 2002:a05:6402:458:b0:418:78a4:ac3f with SMTP id p24-20020a056402045800b0041878a4ac3fmr42146749edw.196.1649843934985;
        Wed, 13 Apr 2022 02:58:54 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl. [194.29.137.1])
        by smtp.gmail.com with ESMTPSA id 25-20020a170906311900b006e87e5dd529sm4282481ejx.70.2022.04.13.02.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 02:58:54 -0700 (PDT)
Message-ID: <f8c758a0-8e6d-85e6-3af2-640b33a92ce9@gmail.com>
Date:   Wed, 13 Apr 2022 11:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v5 09/10] ARM: dts: msm: Add coresight components for
 SM8250
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
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
From:   Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20220412125035.40312-10-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I added Bjorn, the linux-arm-msm maintainer to CC as he was missing for 
some reason.


On 12/04/2022 14:50, Mao Jinlong wrote:
> Add coresight device tree for sm8250. STM/ETM are added.
>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   .../arm64/boot/dts/qcom/sm8250-coresight.dtsi | 526 ++++++++++++++++++
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +
>   2 files changed, 528 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
> new file mode 100644
> index 000000000000..1de42fd39248
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
> @@ -0,0 +1,526 @@
> +// SPDX-License-Identifier: GPL-2.0

sm8250.dtsi is BSD-3-Clause. Please consider relicensing.


> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +&soc {
> +
> +	stm@6002000 {
> +		compatible = "arm,coresight-stm", "arm,primecell";
> +		reg = <0 0x06002000 0 0x1000>,

You don't need to break the line at so few characters.


> +		      <0 0x16280000 0 0x180000>;
> +		reg-names = "stm-base", "stm-stimulus-base";
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				stm_out: endpoint {
> +					remote-endpoint =
> +					  <&funnel0_in7>;

Same here.


> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6041000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x06041000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				funnel0_out: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_in0>;

And here.


> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@7 {
> +				reg = <7>;
> +				funnel0_in7: endpoint {
> +					remote-endpoint = <&stm_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6042000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x06042000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				funnel2_out: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_in2>;

And here.


> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@2 {
> +				reg = <4>;
> +				funnel2_in5: endpoint {
> +					remote-endpoint =
> +					  <&apss_merge_funnel_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6b04000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb908>;
> +
> +		reg = <0 0x6b04000 0 0x1000>;
> +		reg-names = "funnel-base";
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				merge_funnel_out: endpoint {
> +					remote-endpoint =
> +						<&etf_in>;
And here.


> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@7 {
> +				reg = <7>;
> +				funnel_swao_in_funnel_merg: endpoint {
> +					remote-endpoint=

And here.


> +						<&funnel_merg_out_funnel_swao>;
> +				};
> +			};
> +		};
> +
> +	};
> +
> +	funnel@6045000 {

The nodes are not sorted properly (by address). Please fix that.


> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x06045000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				funnel_merg_out_funnel_swao: endpoint {
> +					remote-endpoint = <&funnel_swao_in_funnel_merg>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@1 {
> +				reg = <0>;
> +				merge_funnel_in0: endpoint {
> +					remote-endpoint =
> +					  <&funnel0_out>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <1>;
> +				merge_funnel_in2: endpoint {
> +					remote-endpoint =
> +					  <&funnel2_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	replicator@6046000 {
> +		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +		reg = <0 0x06046000 0 0x1000>;
> +
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				replicator_out: endpoint {
> +					remote-endpoint = <&etr_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			port {
> +				replicator_cx_in_swao_out: endpoint {
> +					remote-endpoint = <&replicator_swao_out_cx_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	replicator@6b06000 {
> +		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +		reg = <0 0x06b06000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				replicator_swao_out_cx_in: endpoint {
> +					remote-endpoint = <&replicator_cx_in_swao_out>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			port {
> +				replicator_in: endpoint {
> +					remote-endpoint = <&etf_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etf@6b05000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0 0x6b05000 0 0x1000>;

Please pad the address to 8 chars.


> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				etf_out: endpoint {
> +					remote-endpoint =
> +					  <&replicator_in>;

And here.


> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@1 {
> +				reg = <0>;
> +				etf_in: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etr@6048000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0 0x06048000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,scatter-gather;
> +
> +		in-ports {
> +			port {
> +				etr_in: endpoint {
> +					remote-endpoint =
> +					  <&replicator_out>;

And here.


> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7040000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07040000 0 0x1000>;
> +
> +		cpu = <&CPU0>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm0_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in0>;

And here.


> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7140000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07140000 0 0x1000>;
> +
> +		cpu = <&CPU1>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm1_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in1>;

And here.


> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7240000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07240000 0 0x1000>;
> +
> +		cpu = <&CPU2>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm2_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in2>;

And here.


> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7340000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07340000 0 0x1000>;
> +
> +		cpu = <&CPU3>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm3_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in3>;

And here.


> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7440000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07440000 0 0x1000>;
> +
> +		cpu = <&CPU4>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm4_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in4>;

And here.


> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7540000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07540000 0 0x1000>;
> +
> +		cpu = <&CPU5>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm5_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in5>;

And here.


> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7640000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07640000 0 0x1000>;
> +
> +		cpu = <&CPU6>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm6_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in6>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7740000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07740000 0 0x1000>;
> +
> +		cpu = <&CPU7>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm7_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in7>;

And here.


> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@7800000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x07800000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				apss_funnel_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_merge_funnel_in>;

And here.


> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				apss_funnel_in0: endpoint {
> +					remote-endpoint =
> +					  <&etm0_out>;

And here.


> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				apss_funnel_in1: endpoint {
> +					remote-endpoint =
> +					  <&etm1_out>;

And here.


> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				apss_funnel_in2: endpoint {
> +					remote-endpoint =
> +					  <&etm2_out>;

And here.


> +				};
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				apss_funnel_in3: endpoint {
> +					remote-endpoint =
> +					  <&etm3_out>;

And here.


> +				};
> +			};
> +
> +			port@4 {
> +				reg = <4>;
> +				apss_funnel_in4: endpoint {
> +					remote-endpoint =
> +					  <&etm4_out>;

And here.


> +				};
> +			};
> +
> +			port@5 {
> +				reg = <5>;
> +				apss_funnel_in5: endpoint {
> +					remote-endpoint =
> +					  <&etm5_out>;

And here.


> +				};
> +			};
> +
> +			port@6 {
> +				reg = <6>;
> +				apss_funnel_in6: endpoint {
> +					remote-endpoint =
> +					  <&etm6_out>;

And here.


> +				};
> +			};
> +
> +			port@7 {
> +				reg = <7>;
> +				apss_funnel_in7: endpoint {
> +					remote-endpoint =
> +					  <&etm7_out>;

And here.


> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@7810000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x07810000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				apss_merge_funnel_out: endpoint {
> +					remote-endpoint =
> +					  <&funnel2_in5>;

And here.


> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			port@1 {
> +				reg = <0>;
> +				apss_merge_funnel_in: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_out>;
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index af8f22636436..115623392183 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -5434,3 +5434,5 @@
>   		};
>   	};
>   };
> +
> +#include "sm8250-coresight.dtsi"

Why should everybody want coresight? It's not enabled on (most) 
production devices and may cause a platform crash when you try to use it 
on such ones.


These nodes should probably be added to sm8250.dtsi, all with status = 
"disabled" by default, so that they don't break the devices that do not 
support it due to fuse configuration.


Konrad

