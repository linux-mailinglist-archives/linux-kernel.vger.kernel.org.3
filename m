Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE056A6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiGGPal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiGGPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:30:16 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44F524BC1;
        Thu,  7 Jul 2022 08:30:14 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267E47W9012214;
        Thu, 7 Jul 2022 11:29:59 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h5u9s2qkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 11:29:59 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 267FTwSO010596
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 11:29:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 7 Jul 2022
 11:29:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Jul 2022 11:29:57 -0400
Received: from euswvd-wpr-621.reddog.microsoft.com ([10.140.226.135])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 267FTmbI008137;
        Thu, 7 Jul 2022 11:29:50 -0400
From:   Atif Ofluoglu <Atif.Ofluoglu@analog.com>
To:     <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Atif Ofluoglu <atif.ofluoglu@analog.com>
Subject: [PATCH 0/2] Adding MAX20754 support
Date:   Thu, 7 Jul 2022 15:29:16 +0000
Message-ID: <cover.1657204859.git.atif.ofluoglu@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: WEmX6ZgaOqf0ReStf6cP6la3IZA3rsiO
X-Proofpoint-ORIG-GUID: WEmX6ZgaOqf0ReStf6cP6la3IZA3rsiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=695 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070061
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atif Ofluoglu <atif.ofluoglu@analog.com>

Adding support for Maxim MAX20754 Dual-Output, Configurable Multiphase Power-Supply Controller with PMBus Interface.

The driver is tested on MAX20754 evalution kit hardware.

Atif Ofluoglu (2):
  hwmon: (pmbus/max20754) Add support for MAX20754
  Added documentation for Maxim Integrated max20754 hwmon userspace
    sysfs.

 Documentation/hwmon/max20754.rst | 122 ++++++++++
 drivers/hwmon/pmbus/Kconfig      |   9 +
 drivers/hwmon/pmbus/Makefile     |   1 +
 drivers/hwmon/pmbus/max20754.c   | 390 +++++++++++++++++++++++++++++++
 4 files changed, 522 insertions(+)
 create mode 100644 Documentation/hwmon/max20754.rst
 create mode 100644 drivers/hwmon/pmbus/max20754.c

-- 
2.25.1

