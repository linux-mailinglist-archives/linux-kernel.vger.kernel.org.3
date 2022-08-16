Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770F6595939
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiHPLCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiHPLCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:02:04 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D7264B;
        Tue, 16 Aug 2022 03:29:30 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G89a8a003193;
        Tue, 16 Aug 2022 06:29:21 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3hx8v6nrhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 06:29:21 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27GATJZa037542
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Aug 2022 06:29:19 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 16 Aug 2022 06:29:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 16 Aug 2022 06:29:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 16 Aug 2022 06:29:18 -0400
Received: from george-precision5560.ad.analog.com ([10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27GAT2AO030411;
        Tue, 16 Aug 2022 06:29:07 -0400
From:   George Mois <george.mois@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lucas.p.stankus@gmail.com>, George Mois <george.mois@analog.com>
Subject: [PATCH 0/2] Add support for ADXL312 and ADXL314 accelerometers
Date:   Tue, 16 Aug 2022 13:28:26 +0300
Message-ID: <20220816102828.182345-1-george.mois@analog.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: WQs_oJE9Vd4gjH4zpWWmxCY2yPnH-Ztz
X-Proofpoint-GUID: WQs_oJE9Vd4gjH4zpWWmxCY2yPnH-Ztz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_07,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=765 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160040
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADXL312 and ADXL314 are small, thin, low power, 3-axis accelerometers
with high resolution (13-bit) measurement up to +/-12 g and +/- 200 g
respectively.

Implement support for ADXL312 and ADXL314 by extending the ADXL313
driver.

George Mois (2):
  bindings: iio: accel: extend adxl313 documentation file
  drivers: iio: accel adxl312 and adxl314 support

 .../bindings/iio/accel/adi,adxl313.yaml       |   8 +-
 drivers/iio/accel/adxl313.h                   |  17 +-
 drivers/iio/accel/adxl313_core.c              | 165 +++++++++++++-----
 drivers/iio/accel/adxl313_spi.c               |  42 ++++-
 4 files changed, 181 insertions(+), 51 deletions(-)

-- 
2.30.2

