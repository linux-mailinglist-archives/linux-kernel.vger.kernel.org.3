Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2668C4E6329
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350047AbiCXMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350142AbiCXMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:20:23 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9D53C721;
        Thu, 24 Mar 2022 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648124324; x=1679660324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vaze49NlQFVnq6WSQPfu59MJJlPPke3jEqk0/bvhPKU=;
  b=mWz/ii+RBZGZlRVf4snYUNOZY3oFOg/nF/UMtM1RckK2dLoQi4qT4jvA
   CajuEHJkHLx4KpMAa/zbDuoPOdxNykSaLtRSvEIJZCSMj37+P5isv00fP
   RfcqrUwVS2V9WzZ9rwj08X7+Emc0EJv8z3cGRnO/7Ntz/c2AVPQpS0Bt7
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Mar 2022 05:18:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:18:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 05:18:43 -0700
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 05:18:39 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v4 10/10] ARM: dts: msm: Add tpdm mm/prng for sm8250
Date:   Thu, 24 Mar 2022 20:17:34 +0800
Message-ID: <20220324121734.21531-11-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tpdm mm and tpdm prng for sm8250.

+---------------+                +-------------+
|  tpdm@6c08000 |                |tpdm@684C000 |
+-------|-------+                +------|------+
        |                               |
+-------|-------+                       |
| funnel@6c0b000|                       |
+-------|-------+                       |
        |                               |
+-------|-------+                       |
|funnel@6c2d000 |                       |
+-------|-------+                       |
        |                               |
        |    +---------------+          |
        +----- tpda@6004000  -----------+
             +-------|-------+
                     |
             +-------|-------+
             |funnel@6005000 |
             +---------------+

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../arm64/boot/dts/qcom/sm8250-coresight.dtsi | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
index 1de42fd39248..9c710b69a804 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
@@ -44,6 +44,14 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			port@6 {
+				reg = <6>;
+				funnel_in0_in_funnel_qatb: endpoint {
+					remote-endpoint =
+						<&funnel_qatb_out_funnel_in0>;
+				};
+			};
+
 			port@7 {
 				reg = <7>;
 				funnel0_in7: endpoint {
@@ -523,4 +531,178 @@
 			};
 		};
 	};
+
+	tpdm@6c08000 {
+		compatible = "arm,primecell";
+		reg = <0 0x6c08000 0 0x1000>;
+		reg-names = "tpdm-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				tpdm_mm_out_funnel_dl_mm: endpoint {
+					remote-endpoint =
+						<&funnel_dl_mm_in_tpdm_mm>;
+				};
+			};
+		};
+	};
+
+	funnel@6c0b000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+
+		reg = <0 0x6c0b000 0 0x1000>;
+		reg-names = "funnel-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				funnel_dl_mm_out_funnel_dl_center: endpoint {
+					remote-endpoint =
+					  <&funnel_dl_center_in_funnel_dl_mm>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@3 {
+				reg = <3>;
+				funnel_dl_mm_in_tpdm_mm: endpoint {
+					remote-endpoint =
+					    <&tpdm_mm_out_funnel_dl_mm>;
+				};
+			};
+		};
+	};
+
+	funnel@6c2d000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+
+		reg = <0 0x6c2d000 0 0x1000>;
+		reg-names = "funnel-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port {
+				tpdm_mm_out_tpda9: endpoint {
+					remote-endpoint =
+					    <&tpda_9_in_tpdm_mm>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@2 {
+				reg = <2>;
+				funnel_dl_center_in_funnel_dl_mm: endpoint {
+					remote-endpoint =
+					<&funnel_dl_mm_out_funnel_dl_center>;
+				};
+			};
+		};
+	};
+
+	tpdm@684C000 {
+		compatible = "arm,primecell";
+		reg = <0 0x684C000 0 0x1000>;
+		reg-names = "tpdm-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				tpdm_prng_out_tpda_23: endpoint {
+					remote-endpoint =
+						<&tpda_23_in_tpdm_prng>;
+				};
+			};
+		};
+	};
+
+	tpda@6004000 {
+		compatible = "arm,primecell";
+		reg = <0 0x6004000 0 0x1000>;
+		reg-names = "tpda-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				reg = <0>;
+				tpda_out_funnel_qatb: endpoint {
+					remote-endpoint =
+						<&funnel_qatb_in_tpda>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@9 {
+				reg = <9>;
+				tpda_9_in_tpdm_mm: endpoint {
+					remote-endpoint =
+						<&tpdm_mm_out_tpda9>;
+				};
+			};
+
+			port@23 {
+				reg = <23>;
+				tpda_23_in_tpdm_prng: endpoint {
+					remote-endpoint =
+						<&tpdm_prng_out_tpda_23>;
+				};
+			};
+		};
+	};
+
+	funnel@6005000 {
+		compatible = "arm,primecell";
+
+		reg = <0 0x6005000 0 0x1000>;
+		reg-names = "funnel-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				funnel_qatb_out_funnel_in0: endpoint {
+					remote-endpoint =
+						<&funnel_in0_in_funnel_qatb>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				funnel_qatb_in_tpda: endpoint {
+					remote-endpoint =
+						<&tpda_out_funnel_qatb>;
+				};
+			};
+		};
+	};
 };
-- 
2.17.1

