Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0F4B228B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348729AbiBKJzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:55:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiBKJzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:55:02 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4069EB;
        Fri, 11 Feb 2022 01:55:01 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21B1vwbT022442;
        Fri, 11 Feb 2022 04:54:54 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e46jc2krt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 04:54:54 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 21B9sriu051949
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Feb 2022 04:54:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 11 Feb
 2022 04:54:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Feb 2022 04:54:51 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.166])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21B9sh69002029;
        Fri, 11 Feb 2022 04:54:45 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/3] Add support for ADA4250 Programmable Instrumentation Amplifier
Date:   Fri, 11 Feb 2022 11:50:54 +0200
Message-ID: <20220211095057.54979-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: CFUDAWk46wUFnta7Kn16MjiRk6YMYM7N
X-Proofpoint-GUID: CFUDAWk46wUFnta7Kn16MjiRk6YMYM7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_03,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=723
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110056
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADA4250 is an instrumentation amplifier with SPI/pin-strap
progammable gains that is optimized for ultra-low power systems.
With a minimum supply voltage of 1.7V, 26uA of quiescent current,
a shutdown mode, a sleep mode, and a fast wake up settling time,
ADA4250 can be power cycled on a battery powered system for even
futher savings.

Antoniu Miclaus (3):
  iio:amplifiers:ada4250: add support for ADA4250
  dt-bindings:iio:amplifiers: add ada4250 doc
  MAINTAINERS: add maintainer for ADA4250 driver

 .../bindings/iio/amplifiers/adi,ada4250.yaml  |  48 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/amplifiers/Kconfig                |  11 +
 drivers/iio/amplifiers/Makefile               |   1 +
 drivers/iio/amplifiers/ada4250.c              | 367 ++++++++++++++++++
 5 files changed, 435 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 create mode 100644 drivers/iio/amplifiers/ada4250.c

-- 
2.35.1

