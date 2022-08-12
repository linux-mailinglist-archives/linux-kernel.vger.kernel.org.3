Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8C59145F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiHLQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiHLQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:55:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4050A65654;
        Fri, 12 Aug 2022 09:55:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C9Co0Y020599;
        Fri, 12 Aug 2022 16:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=t310YLd67tLsjHRetcgbaAikt91hXVDCnh9v5VN5pyA=;
 b=EtW8+QhwS7dmORe8MNdpTLDpQ4mjbWQp/nRe3nqyhCb0pSiD1lqO4TCMSHepRqo0zFVO
 uXywomIL0aK4cSTfi2/MN52kF81HuP0dxFbeluETBrwaTbt5zI7NhnZMk13Fbs2dqETt
 0Ye0gvsJYsSJwtiAfa5VKq84Ah9wEtJgoggRzx23b3qmq165UiQqzMizgsywo5BAdhz/
 +8JKVrIpV87gNzIqh/mksbsgQoQKowhBanJmvlcbduJDjqjkoyDd+/GxgUx06A4zqYvG
 MyEIJERpy01vupdi/cmyHqG9m0Xmc//bgobe50mD5lYfHoKmvvaMDAFGqBWyA4oESheL XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hwh7cj522-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 16:55:31 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27CGtUpT031698;
        Fri, 12 Aug 2022 16:55:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3hvd90gwmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 16:55:30 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27CGtTdb031693;
        Fri, 12 Aug 2022 16:55:29 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 27CGtTKR031692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 16:55:29 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 12 Aug 2022 09:55:26 -0700
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v3 0/3] arm64: dts: qcom: add dts for sa8540p-ride board
Date:   Fri, 12 Aug 2022 22:24:50 +0530
Message-ID: <20220812165453.11608-1-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KCpGhEnRDfCja8gnoedMyy_SEU3Q0u5t
X-Proofpoint-ORIG-GUID: KCpGhEnRDfCja8gnoedMyy_SEU3Q0u5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=623 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208120045
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the Qualcom sa8540p-ride automotive development
board, also called as Qdrive-3 board.

Changes in v3:
 - Added Acked-by tag (Krzysztof)
 - Renamed dtsi to sa8540p-adp.dtsi (John)
 - Removed copyright from sa8295-adp.dts and sa8295-adp.dtsi(John)
 - Added cover letter

Apologies for breaking the thread in previous version(v2).
References to previous version(v2)  patches:
 - https://lore.kernel.org/linux-arm-msm/20220722142515.18592-1-quic_ppareek@quicinc.com/
 - https://lore.kernel.org/linux-arm-msm/20220722143232.7903-1-quic_ppareek@quicinc.com/
 - https://lore.kernel.org/linux-arm-msm/20220722143711.17563-1-quic_ppareek@quicinc.com/


Parikshit Pareek (3):
  dt-bindings: arm: qcom: Document additional sa8540p device
  arm64: dts: qcom: sa8295p: move common nodes to dtsi
  arm64: dts: qcom: introduce sa8540p-ride dts

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 377 +----------------
 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  15 +
 arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi     | 384 ++++++++++++++++++
 5 files changed, 402 insertions(+), 376 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi

-- 
2.17.1

