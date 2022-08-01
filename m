Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1AD5862D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbiHACwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiHACwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:52:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C9AAE7B;
        Sun, 31 Jul 2022 19:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=s8ez/7VBHWxgBY5IeBuqe1BKoB7CELG95CXU6zGOg1o=; b=jWAn3xKJGIL6pGz3sLsDFipQK2
        hW2UVrS44R9I+JxXFYC05STHuAuTfUe1M9v0PXF0dqLgpDksiFU/4IdEZCph11K4/m2kV4r2o1MGB
        pm4HEcZczeXYMEt2Fj+ThLloem4rSL/LKIkTQS04MBu6+wz3pCBu9zlv1ya/igZ1q5jdoQCiSsc/4
        Wu7wjkRpeNgELPsCEPtftpj1FI1mJkc/evaTkdO+EoUMzBerNpDMZz9RD9FP5ubncpqRzZmJzPnrl
        9L02k/rn0nDIacuhsYBOfPZ/TqZHH9B3UoKQOKPMVOVeEV0I6obXJMVDRF0LarRpNE5VOU7+uu4d5
        iNjmGS3g==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oILXQ-006ltP-68; Mon, 01 Aug 2022 02:52:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Documentation/ABI: correct possessive "its" typos
Date:   Sun, 31 Jul 2022 19:52:07 -0700
Message-Id: <20220801025207.29971-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct all uses of "it's" that are meant to be possessive "its".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-bus-bcma           |    2 +-
 Documentation/ABI/testing/sysfs-bus-fcoe           |    2 +-
 Documentation/ABI/testing/sysfs-bus-iio-proximity  |    2 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu |    2 +-
 Documentation/ABI/testing/sysfs-power              |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -296,7 +296,7 @@ Description:	Processor frequency boostin
 
 		This switch controls the boost setting for the whole system.
 		Boosting allows the CPU and the firmware to run at a frequency
-		beyond it's nominal limit.
+		beyond its nominal limit.
 
 		More details can be found in
 		Documentation/admin-guide/pm/cpufreq.rst
--- a/Documentation/ABI/testing/sysfs-bus-fcoe
+++ b/Documentation/ABI/testing/sysfs-bus-fcoe
@@ -31,7 +31,7 @@ Description:	'FCoE Controller' instances
 		1) Write interface name to ctlr_create 2) Configure the FCoE
 		Controller (ctlr_X) 3) Enable the FCoE Controller to begin
 		discovery and login. The FCoE Controller is destroyed by
-		writing it's name, i.e. ctlr_X to the ctlr_delete file.
+		writing its name, i.e. ctlr_X to the ctlr_delete file.
 
 Attributes:
 
--- a/Documentation/ABI/testing/sysfs-bus-bcma
+++ b/Documentation/ABI/testing/sysfs-bus-bcma
@@ -3,7 +3,7 @@ Date:		May 2011
 KernelVersion:	3.0
 Contact:	Rafał Miłecki <zajec5@gmail.com>
 Description:
-		Each BCMA core has it's manufacturer id. See
+		Each BCMA core has its manufacturer id. See
 		include/linux/bcma/bcma.h for possible values.
 
 What:		/sys/bus/bcma/devices/.../id
--- a/Documentation/ABI/testing/sysfs-bus-iio-proximity
+++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity
@@ -18,7 +18,7 @@ Description:
 		on the signal from which time of flight measurements are
 		taken.
 		The appropriate values to take is dependent on both the
-		sensor and it's operating environment:
+		sensor and its operating environment:
 		* as3935 (0-31 range)
 		18 = indoors (default)
 		14 = outdoors
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -152,7 +152,7 @@ Description:
 		case further investigation is required to determine which
 		device is causing the problem.  Note that genuine RTC clock
 		values (such as when pm_trace has not been used), can still
-		match a device and output it's name here.
+		match a device and output its name here.
 
 What:		/sys/power/pm_async
 Date:		January 2009
