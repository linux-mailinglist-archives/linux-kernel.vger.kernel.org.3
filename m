Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6C46E9C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhLIOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:20:38 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:51974 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbhLIOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639059416; x=1670595416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=zCV/o4MZswpET3jmHvOYj26gTy/f1Uf64OvOr/HEOaU=;
  b=jiONEJiy6nyLFeZlBWqu2f/HiYy7ldQen5NjXqMGLx8xvKySLaa0/avV
   993IShA4hpX2csp5aVEOVn2NEKYvCYbL+rPuT2G8vBdgGcLZGyB/y5hKD
   WyS2SkW2Q/AmskMz3fP6sO2jfBE9eD/7G6y0hZwHKXJqh9Ai245jGc7y6
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 09 Dec 2021 06:16:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:16:56 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:55 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:51 -0800
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
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 6/9] docs: sysfs: coresight: Add sysfs ABI documentation for TPDM
Date:   Thu, 9 Dec 2021 22:15:40 +0800
Message-ID: <20211209141543.21314-7-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API usage document for sysfs API in TPDM driver.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm     | 12 ++++++++++++
 MAINTAINERS                                          |  1 +
 2 files changed, 13 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
new file mode 100644
index 000000000000..fdd0bd0e1c33
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -0,0 +1,12 @@
+What:		/sys/bus/coresight/devices/<tpdm-name>/available_datasets
+Date:		December 2021
+KernelVersion	5.16
+Contact:	Jinlong Mao or Tao Zhang
+Description:	(Read) Show available datasets for TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/integration_test
+Date:		December 2020
+KernelVersion	5.16
+Contact:	Jinlong Mao or Tao Zhang
+Description:	(Write) Run integration test for tpdm.
+
diff --git a/MAINTAINERS b/MAINTAINERS
index d763ba684b99..7e2898f1550b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15566,6 +15566,7 @@ M:	Jinlong Mao <quic_jinlmao@quicinc.com>
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 M:	Suzuki K Poulose <suzuki.poulose@arm.com>
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
 F:	Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
 F:	drivers/hwtracing/coresight/coresight-tpdm.c
 
-- 
2.17.1

