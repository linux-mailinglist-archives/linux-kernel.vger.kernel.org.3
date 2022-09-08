Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C925B16DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiIHIZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiIHIY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:24:58 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBDC4DB0A;
        Thu,  8 Sep 2022 01:24:56 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2887VG2a030682;
        Thu, 8 Sep 2022 04:24:42 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jf8ybshry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 04:24:42 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2888Oe94026141
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Sep 2022 04:24:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 Sep 2022
 04:24:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 Sep 2022 04:24:39 -0400
Received: from ibrahim-vm.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.132])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2888OHWB032231;
        Thu, 8 Sep 2022 04:24:31 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v6 2/4] docs: hwmon: add max31760 documentation
Date:   Thu, 8 Sep 2022 11:23:56 +0300
Message-ID: <20220908082358.186268-3-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220908082358.186268-1-Ibrahim.Tilki@analog.com>
References: <20220908082358.186268-1-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: rqoYxd55YXNALoTSYgyrKO8c2LlyTLSF
X-Proofpoint-ORIG-GUID: rqoYxd55YXNALoTSYgyrKO8c2LlyTLSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080029
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding documentation for max31760 fan speed controller

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
---
 Documentation/hwmon/index.rst    |  1 +
 Documentation/hwmon/max31760.rst | 77 ++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/hwmon/max31760.rst

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index f7113b0f8..dba260013 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -133,6 +133,7 @@ Hardware Monitoring Kernel Drivers
    max20751
    max31722
    max31730
+   max31760
    max31785
    max31790
    max34440
diff --git a/Documentation/hwmon/max31760.rst b/Documentation/hwmon/max31760.rst
new file mode 100644
index 000000000..b1b55fb84
--- /dev/null
+++ b/Documentation/hwmon/max31760.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver max31760
+======================
+
+Supported chips:
+  * Analog Devices MAX31760
+
+    Prefix: 'max31760'
+
+    Addresses scanned: none
+
+    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31760.pdf
+
+
+Author: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
+
+Description
+-----------
+
+The MAX31760 integrates temperature sensing along with precision PWM fan
+control. It accurately measures its local die temperature and the remote
+temperature of a discrete diode-connected transistor, such as a 2N3906,
+or a thermal diode commonly found on CPUs, graphics processor units (GPUs),
+and other ASICs. Multiple temperature thresholds, such as local
+high/overtemperature (OT) and remote high/overtemperature, can be set by an
+I2C-compatible interface. Fan speed is controlled based on the temperature
+reading as an index to a 48-byte lookup table (LUT) containing
+user-programmed PWM values. The flexible LUT-based architecture enables
+the user to program a smooth nonlinear fan speed vs. temperature transfer
+function to minimize acoustic fan noise. Two tachometer inputs allow
+measuring the speeds of two fans independently. When the local or remote
+OT threshold is exceeded, the SHDN pin is asserted low and can be used to
+shut down the system. A dedicated ALERT pin reports that either a local or
+remote high-temperature threshold has been exceeded.
+
+Temperature measurement range: from -55°C to 125°C
+
+Temperature Resolution: 11 Bits, ±0.125°C
+
+Please refer how to instantiate this driver: Documentation/i2c/instantiating-devices.rst
+
+Lookup table for auto fan control
+---------------------------------
+
+========= =================================
+LUT Index Name
+========= =================================
+1         PWM value for T < +18°C
+2         PWM value for +18°C ≤ T < +20°C
+3         PWM value for +20°C ≤ T < +22°C
+...       ...
+47        PWM value for +108°C ≤ T < +110°C
+48        PWM value for T ≥ +110°C
+========= =================================
+
+Sysfs entries
+-------------
+
+=============================== =================================================================================
+fan[1-2]_input                  Fan speed (in RPM)
+fan[1-2]_enable                 Enable fan readings and fan fault alarms
+fan[1-2]_fault                  Fan fault status
+temp[1-2]_label                 "Remote" and "Local" temperature channel labels
+temp[1-2]_input                 Temperature sensor readings (in millidegrees Celsius)
+temp1_fault                     Remote temperature sensor fault status
+temp[1-2]_max                   Temperature max value. Asserts "ALERT" pin when exceeded
+temp[1-2]_max_alarm             Temperature max alarm status
+temp[1-2]_crit                  Temperature critical value. Asserts "SHDN" pin when exceeded
+temp[1-2]_crit_alarm            Temperature critical alarm status
+pwm1                            PWM value for direct fan control
+pwm1_enable                     1: direct fan control, 2: temperature based auto fan control
+pwm1_freq                       PWM frequency in hertz
+pwm1_auto_channels_temp         Temperature source for auto fan control. 1: temp1, 2: temp2, 3: max(temp1, temp2)
+pwm1_auto_point[1-48]_pwm       PWM value for LUT point
+pwm1_auto_point_temp_hyst       Temperature hysteresis for auto fan control. Can be either 2000mC or 4000mC
+=============================== =================================================================================
-- 
2.36.1

