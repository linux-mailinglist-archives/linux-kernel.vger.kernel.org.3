Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3358EB96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiHJLzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiHJLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:55:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ADA60505;
        Wed, 10 Aug 2022 04:55:31 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A7p5Yg009081;
        Wed, 10 Aug 2022 11:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=KuRqcISvELy7dFk8pALjApwwMqYKP60nfEQLYae+sr8=;
 b=InSG319s/jr5pqwh7O9vQClLZzyRD5wVXvKEBKSs1Ip5uYgFVn5G4b/ZENT+chhY5iUp
 SoeN6GMxJcP3xAxTAsppGx8mb9YxZTB5EreO8ZHhawWjyt1V4f4FFIGeFYv1VE5Ru+wh
 25jgY5KZ1tpl/YBR8t1OIa7nDhnTYdQJ/FZxjNfO1PjBx+zC85qB4FDjvo8VwKwhj/Hx
 SSBTOr0b59z6VhLjJ+Hec2mFNSSBex2qgI2ir0tR8qtJoqMD+uTcf3i6IOGvBAKU1Y0h
 QLOrX6KGCR6kjNgRqK1I7Q6fI6OfneeOQrVVMIjebO1gobPD/k5YhKCc8HT5T/HBmkNB 2A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwr8tdgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 11:55:24 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27ABtN0Y007554
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 11:55:23 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 04:55:23 -0700
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 04:55:19 -0700
Date:   Wed, 10 Aug 2022 17:25:15 +0530
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sa8295p: move common nodes to
 dtsi
Message-ID: <20220810115515.GA12905@hu-ppareek-blr.qualcomm.com>
References: <20220722143232.7903-1-quic_ppareek@quicinc.com>
 <Yt/w5lvPQF2pKlmY@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yt/w5lvPQF2pKlmY@hovoldconsulting.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vvQ001i3Fp1OJ52IVao1lT8OT3DxPOCJ
X-Proofpoint-ORIG-GUID: vvQ001i3Fp1OJ52IVao1lT8OT3DxPOCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=915 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 03:49:26PM +0200, Johan Hovold wrote:
> On Fri, Jul 22, 2022 at 08:02:32PM +0530, Parikshit Pareek wrote:
> > There are many ADP boards with lot of common features. Move common
> > nodes to sa8xxxp-auto.dtsi files. This will be base for many ADP boards
> > to be introduced in near future.
> > 
> > Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> > ---
> > 
> > Changes since v1:
> > - Add , after year 2022, in the license header
> > - Rename the dtsi which is suitable for common to many ADP boards
> > - Split the patch in introducing common dtsi file, and adding new board
> >   file
> > 
> >  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 378 +----------------
> >  .../arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi | 385 ++++++++++++++++++
> >  2 files changed, 387 insertions(+), 376 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi
> 
> Not sure about the name; sa8540-adp.dtsi seems like a better choice, but
> I'd need to know more about how these two relate to each other.
> 
> What differs between sa8295p-adp and sa8540p-adp? That should go in the
> commit message too.
The sa8540-adp has connectors for PCIe,ethernet-switch and different USB ports than sa8295p-adp.
So far, as we checked, such differences are on connector level and don't need any device tree level
modification. If any is needed, intention is to do that in future patches.
> 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > index 9398f0349944..3cc92162ba02 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > @@ -2,388 +2,14 @@
> >  /*
> >   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> >   * Copyright (c) 2022, Linaro Limited
> > + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> 
> I'm pretty sure you can't claim copyright for just moving code around
> (same for the new file).
> 
> >   */
> 
> Johan
Regards,
Parikshit Pareek
