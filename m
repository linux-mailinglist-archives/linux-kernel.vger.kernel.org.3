Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20256A6FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiGGPbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbiGGPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:31:03 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5531229;
        Thu,  7 Jul 2022 08:30:59 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EJMlS012398;
        Thu, 7 Jul 2022 11:30:43 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h5u9s2qt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 11:30:43 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 267FUgMD040096
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 11:30:42 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Jul 2022 11:30:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Jul 2022 11:30:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Jul 2022 11:30:41 -0400
Received: from euswvd-wpr-621.reddog.microsoft.com ([10.140.226.135])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 267FTmbK008137;
        Thu, 7 Jul 2022 11:30:36 -0400
From:   Atif Ofluoglu <Atif.Ofluoglu@analog.com>
To:     <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Atif Ofluoglu <atif.ofluoglu@analog.com>
Subject: [PATCH 2/2] Added documentation for Maxim Integrated max20754 hwmon userspace sysfs.
Date:   Thu, 7 Jul 2022 15:29:18 +0000
Message-ID: <a8d037609be3e6f81bc15e2a6c24cb7809e3226b.1657204859.git.atif.ofluoglu@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657204859.git.atif.ofluoglu@analog.com>
References: <cover.1657204859.git.atif.ofluoglu@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: idAZ45jGNUBfSgPZSCJcyLjHp0DAxtBY
X-Proofpoint-ORIG-GUID: idAZ45jGNUBfSgPZSCJcyLjHp0DAxtBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
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

Signed-off-by: Atif Ofluoglu <atif.ofluoglu@analog.com>
---
 Documentation/hwmon/max20754.rst | 122 +++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/hwmon/max20754.rst

diff --git a/Documentation/hwmon/max20754.rst b/Documentation/hwmon/max20754.rst
new file mode 100644
index 000000000000..30cb1356cabf
--- /dev/null
+++ b/Documentation/hwmon/max20754.rst
@@ -0,0 +1,122 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver MAX20754
+======================
+
+Supported chips:
+
+  * Maxim MAX20754
+
+    Prefix: 'max20754'
+
+    Addresses scanned: -
+
+    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX20754.pdf
+    Application Note: 
+
+Author: Atif Emre Ofluoglu  <Atif.Ofluoglu@analog.com>
+
+
+Description
+-----------
+
+This driver supports MAX20754 Dual-Output, Configurable Multiphase 
+Power-Supply Controller with PMBus Interface and Internal Buck Converter.
+
+The driver is a client driver to the core PMBus driver.
+Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
+details.
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported.
+
+=============================== ===============================================
+in1_input   Measured voltage on Supply Voltage. 
+in1_label   "vin1"
+in1_alarm   Input voltage under-voltage alarm
+
+in2_label		"vout1"
+in2_input		Measured voltage on RAIL1.
+in2_min			Minimum output voltage.
+in2_max			Maximum output voltage.
+in2_lcrit		Critical minimum output voltage.
+in2_crit		Critical maximum output voltage.
+in2_lcrit_alarm		Output voltage critical low alarm.
+in2_crit_alarm    Output voltage critical high alarm.
+in2_min_alarm		Output voltage low alarm.
+in2_max_alarm		Output voltage high alarm.
+in2_rated_max   Maximum rated output voltage
+in2_rated_min   Minimum rated output voltage
+
+in3_label		"vout2"
+in3_input		Measured voltage on RAIL2.
+in3_min			Minimum output voltage.
+in3_max			Maximum output voltage.
+in3_lcrit		Critical minimum output voltage.
+in3_crit		Critical maximum output voltage.
+in3_lcrit_alarm		Output voltage critical low alarm.
+in3_crit_alarm    Output voltage critical high alarm.
+in3_min_alarm		Output voltage low alarm.
+in3_max_alarm		Output voltage high alarm.
+in3_rated_max   Maximum rated output voltage
+in3_rated_min   Minimum rated output voltage
+
+curr1_input Measured output current  on RAIL1.
+curr1_label "iout1"
+curr1_max		Maximum output current.
+curr1_max_alarm   Output current high alarm.
+curr1_crit    Critical maximum current
+curr1_crit_alarm    Current critical high alarm
+
+curr2_input   Measured output current on RAIL2.
+curr2_label   "iout2"
+curr2_max   Maximum output current.
+curr2_max_alarm   Output current high alarm.
+curr2_crit    Critical maximum current
+curr2_crit_alarm    Current critical high alarm
+
+temp1_input   Measured Temperature value of Die Core
+temp1_crit    Maximum Temperature value of Die Core
+temp1_crit_alarm    Maximum Temperature Alarm of Die Core
+temp1_max   Over Temperature Warning value of Die Core
+temp1_max_alarm Over Temperature Warning value of Die Core
+temp1_min  Under Temperature value of Die Core
+temp1_min_alarm Under Temperature Alarm of Die Core
+
+temp1_input   Measured Temperature value of Temperature Sense 1
+temp1_crit    Maximum Temperature value of Temperature Sense 1
+temp1_crit_alarm    Maximum Temperature Alarm of Temperature Sense 1
+temp1_max   Over Temperature Warning value of Temperature Sense 1
+temp1_max_alarm Over Temperature Warning value of Temperature Sense 1
+temp1_min  Under Temperature value of Temperature Sense 1
+temp1_min_alarm Under Temperature Alarm of Temperature Sense 1
+
+temp1_input   Measured Temperature value of Temperature Sense 1
+temp1_crit    Maximum Temperature value of Temperature Sense 1
+temp1_crit_alarm    Maximum Temperature Alarm of Temperature Sense 1
+temp1_max   Over Temperature Warning value ofTemperature Sense 1
+temp1_max_alarm Over Temperature Warning Temperature Sense 1
+temp1_min  Under Temperature value of Temperature Sense 1
+temp1_min_alarm Under Temperature Alarm of Temperature Sense 1
+
+vout1_command   Determine Voltage read format of RAIL1
+vout2_command   Determine Voltage read format of RAIL2
+
+on_off_config   Configures Power On/Off behavior.
+operation   Configures Power Supply Operation Mode.
\ No newline at end of file
-- 
2.25.1

