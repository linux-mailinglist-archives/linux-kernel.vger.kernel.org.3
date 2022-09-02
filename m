Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103A75AA70C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 06:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiIBEga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiIBEgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:36:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB618B2742;
        Thu,  1 Sep 2022 21:36:18 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2821QlQE003688;
        Fri, 2 Sep 2022 04:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=EMrm9+nxvkldQmjZ7UJoxgDmauu9Gk07cjL7aDDRcWY=;
 b=FpcvL9SAUR4dwRhYEW84uA8qJcUvgaVj+hNs7E0hx4db7esGzKYsiUefG7/XQlmwXwas
 r1UVlstGhkdjuXMPMak4gIsYkJVuofbK8nxyntfL5hh6GFoiD3wmVF1jhTyUzbAATHvv
 YhBOvgJM7NVALkon8q22yVqbm0m8izckS20E1DPgZSUys0JCF2QSrF5vpJCKwrduZPz/
 xA9HfUBWMOVLV1IFTuNbFNlfbnagJ5LU/LoEBmBsPh9VX3fIG1LNCm+Vjp7WCjfc6pd1
 xILXGsfwKcuXVmE1XAHxzC8j+8WW5fXa+gPjzUrFP3pKB9JR3ZWwmLxGlSv3nduNEz+Z sw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jb5k90pxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 04:36:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2824aBsV016673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 04:36:12 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 21:36:09 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
Date:   Fri, 2 Sep 2022 10:05:11 +0530
Message-ID: <20220902043511.17130-5-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220902043511.17130-1-quic_rjendra@quicinc.com>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -G5lfprJ8nk2dx0MnqYktw8iQMtoOvTm
X-Proofpoint-GUID: -G5lfprJ8nk2dx0MnqYktw8iQMtoOvTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=883 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020020
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu and llcc BWMON nodes and their corresponding
OPP tables for sc7280 SoC.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2: no change

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 76 ++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 13d7f267b289..a839ba968d13 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3275,6 +3275,82 @@
 			};
 		};
 
+		pmu@9091000 {
+			compatible = "qcom,sc7280-llcc-bwmon";
+			reg = <0 0x9091000 0 0x1000>;
+
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <1804000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <2188000>;
+				};
+				opp-3 {
+					opp-peak-kBps = <3072000>;
+				};
+				opp-4 {
+					opp-peak-kBps = <4068000>;
+				};
+				opp-5 {
+					opp-peak-kBps = <6220000>;
+				};
+				opp-6 {
+					opp-peak-kBps = <6832000>;
+				};
+				opp-7 {
+					opp-peak-kBps = <8532000>;
+				};
+			};
+		};
+
+		pmu@90b6000 {
+			compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
+			reg = <0 0x090b6400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <2400000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <4800000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <7456000>;
+				};
+				opp-3 {
+					opp-peak-kBps = <9600000>;
+				};
+				opp-4 {
+					opp-peak-kBps = <12896000>;
+				};
+				opp-5 {
+					opp-peak-kBps = <14928000>;
+				};
+				opp-6 {
+					opp-peak-kBps = <17056000>;
+				};
+			};
+		};
+
 		dc_noc: interconnect@90e0000 {
 			reg = <0 0x090e0000 0 0x5080>;
 			compatible = "qcom,sc7280-dc-noc";
-- 
2.17.1

