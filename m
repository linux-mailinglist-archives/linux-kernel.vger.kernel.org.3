Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E3F49A848
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1317423AbiAYDB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:01:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:16189 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3415309AbiAYBkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643074813; x=1674610813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o9Was9ki72grzMbUkZV5f169uo+CSki1buMNORj9WMM=;
  b=Iosa+Kgzx0kFeJdFxfW8uK+QuingCN9G16mSMlvGKUnkajpDY+ZElQpS
   GTLjyzf4S5hvYD4cSO61srK1b0FrNqu3BDAaUDMupzWlpuYoMHVEXbOia
   nnlsgbCruCX2nJUzB7bm7Qasxv1DGZWmIX9YBlfbHfSon/K09AJzSwejS
   ysFkjlUFDioS/zkmbfzDws7egrHObwjgmSNosgBTtLcC1VM2R+EySeihZ
   86xsrGEVqNOrhtws6CHxSPOKdN8dxKe+/jdfYl62Yy3KoGD8KtcJaSctp
   JMpgRlzhx81IeUnGsYgkzUqgJy2zVSqHG0jwV7+hHPzpUhQEeTAP4sdpH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="245971866"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="245971866"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:17:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="695635197"
Received: from kerguder-mobl.ger.corp.intel.com (HELO localhost) ([10.249.158.133])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:17:44 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v6 13/13] docs: Add PECI documentation
Date:   Tue, 25 Jan 2022 02:11:04 +0100
Message-Id: <20220125011104.2480133-14-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125011104.2480133-1-iwona.winiarska@intel.com>
References: <20220125011104.2480133-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a brief overview of PECI and PECI wire interface.
The documentation also contains kernel-doc for PECI subsystem internals
and PECI CPU Driver API.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/index.rst      |  1 +
 Documentation/peci/index.rst | 16 +++++++++++
 Documentation/peci/peci.rst  | 51 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  1 +
 4 files changed, 69 insertions(+)
 create mode 100644 Documentation/peci/index.rst
 create mode 100644 Documentation/peci/peci.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 2b4de3926858..deaa7f669fcd 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -138,6 +138,7 @@ needed).
    scheduler/index
    mhi/index
    tty/index
+   peci/index
 
 Architecture-agnostic documentation
 -----------------------------------
diff --git a/Documentation/peci/index.rst b/Documentation/peci/index.rst
new file mode 100644
index 000000000000..989de10416e7
--- /dev/null
+++ b/Documentation/peci/index.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+====================
+Linux PECI Subsystem
+====================
+
+.. toctree::
+
+   peci
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/peci/peci.rst b/Documentation/peci/peci.rst
new file mode 100644
index 000000000000..331b1ec00e22
--- /dev/null
+++ b/Documentation/peci/peci.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+========
+Overview
+========
+
+The Platform Environment Control Interface (PECI) is a communication
+interface between Intel processor and management controllers
+(e.g. Baseboard Management Controller, BMC).
+PECI provides services that allow the management controller to
+configure, monitor and debug platform by accessing various registers.
+It defines a dedicated command protocol, where the management
+controller is acting as a PECI originator and the processor - as
+a PECI responder.
+PECI can be used in both single processor and multiple-processor based
+systems.
+
+NOTE:
+Intel PECI specification is not released as a dedicated document,
+instead it is a part of External Design Specification (EDS) for given
+Intel CPU. External Design Specifications are usually not publicly
+available.
+
+PECI Wire
+---------
+
+PECI Wire interface uses a single wire for self-clocking and data
+transfer. It does not require any additional control lines - the
+physical layer is a self-clocked one-wire bus signal that begins each
+bit with a driven, rising edge from an idle near zero volts. The
+duration of the signal driven high allows to determine whether the bit
+value is logic '0' or logic '1'. PECI Wire also includes variable data
+rate established with every message.
+
+For PECI Wire, each processor package will utilize unique, fixed
+addresses within a defined range and that address should
+have a fixed relationship with the processor socket ID - if one of the
+processors is removed, it does not affect addresses of remaining
+processors.
+
+PECI subsystem internals
+------------------------
+
+.. kernel-doc:: include/linux/peci.h
+.. kernel-doc:: drivers/peci/internal.h
+.. kernel-doc:: drivers/peci/core.c
+.. kernel-doc:: drivers/peci/request.c
+
+PECI CPU Driver API
+-------------------
+.. kernel-doc:: drivers/peci/cpu.c
diff --git a/MAINTAINERS b/MAINTAINERS
index d821aeaaa2d3..06449cc42a10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15112,6 +15112,7 @@ M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/peci/
+F:	Documentation/peci/
 F:	drivers/peci/
 F:	include/linux/peci-cpu.h
 F:	include/linux/peci.h
-- 
2.31.1

