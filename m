Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900C759FA98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiHXMzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbiHXMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:55:05 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB2A6DAE7;
        Wed, 24 Aug 2022 05:55:03 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OCqMhE012681;
        Wed, 24 Aug 2022 08:54:55 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j5ad43vy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 08:54:54 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27OCsrBV040113
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Aug 2022 08:54:53 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 24 Aug 2022 08:54:52 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 24 Aug 2022 08:54:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 24 Aug 2022 08:54:52 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27OCseST004251;
        Wed, 24 Aug 2022 08:54:42 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH 0/2] iio: adc: add max11205 adc driver
Date:   Wed, 24 Aug 2022 15:52:01 +0300
Message-ID: <20220824125203.685287-1-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vfrpV0RT2oP80eMNpU4JmBaL5hpF7jhU
X-Proofpoint-ORIG-GUID: vfrpV0RT2oP80eMNpU4JmBaL5hpF7jhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=624 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208240049
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for max11205 16-bit single-channel ultra-low power
delta-sigma adc.
The MAX11205 is compatible with the 2-wire interface and uses
SCLK and RDY/DOUT for serial communica- tions. In this mode, all
controls are implemented by tim- ing the high or low phase of the SCLK.
The 2-wire serial interface only allows for data to be read out through the
RDY/DOUT output.

Ramona Bolboaca (2):
  bindings: iio: adc: Add max11205 documentation file
  iio: adc: add max11205 adc driver

 .../bindings/iio/adc/maxim,max11205.yaml      |  65 ++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  14 ++
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max11205.c                    | 192 ++++++++++++++++++
 5 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
 create mode 100644 drivers/iio/adc/max11205.c

-- 
2.25.1

