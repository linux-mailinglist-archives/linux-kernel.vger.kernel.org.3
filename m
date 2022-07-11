Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E65709A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiGKSBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:01:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200AF33428;
        Mon, 11 Jul 2022 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657562505; x=1689098505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDwCYLXRHk6fLtW1OC/bfo5PDBdSCmEJitlahB7R/FQ=;
  b=ZoCw025aMXw/Ku05YWqqOvabAW10+UCmfwNpsyipbmPFfgSIvClcrCB+
   EM+ZyXtXNZAMY8rctUBjFF4crbFUSN9d1UP0idxQqdwAZjLdf9U6PwCIj
   e71HhgoXWP08/P5yNGUQvLyGAa3IrvKtmig4O6H78LujMUpHrVxH3ycxv
   8k4jGpS6MHLNpbfxE6zBR8QjwCB6q4WCMJ75rssvAenl4qRGQzVN0pUtJ
   idIj3x1I1RWcCCcyoCSYQthHC0fhsh5ixV+JHbFijfllTbLuyr2Fq4csA
   ik5U3VAqGkU7fZ9ouT7OIhIom47bPF9y25a0QCBSE33mMeJBSSNnAwSKE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348710263"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="348710263"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 11:01:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="921882166"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 11:01:41 -0700
Date:   Mon, 11 Jul 2022 19:01:32 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     lkp@intel.com, Vlad Dronov <vdronov@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH RESEND] crypto: qat - fix indentation in ABI documentation
Message-ID: <YsxlfOG17XQ+zLLZ@silpixa00400314>
References: <202207090803.TEGI95qw-lkp@intel.com>
 <YsvuJsjxEjp/LHZa@silpixa00400314>
 <CAMusb+QfUZwq+JRkUrOLGO7mQLZbg_ueFVo2_PTSiSRiq7BoEA@mail.gmail.com>
 <YsxJnq32lAJIRSET@silpixa00400314>
 <YsxP5n0rjUaX0mL8@silpixa00400314>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsxP5n0rjUaX0mL8@silpixa00400314>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 05:29:52PM +0100, Giovanni Cabiddu wrote:
> Resending including linux-crypto. Apologies for the duplicate.
Ouch, now I see that it didn't get picked up by
https://patchwork.kernel.org/project/linux-crypto/list/.
Re-sending again, now with the correct subject. Apologies.

----8<----

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Date: Mon, 11 Jul 2022 16:18:43 +0100
Subject: [PATCH] crypto: qat - fix indentation in ABI documentation
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland

Change the indentation in the file sysfs-driver-qat to resolve the
following warning when generating documentation with `make htmldocs`:

    Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.

Fixes: d4cfb144f605 ("crypto: qat - expose device config through sysfs for 4xxx")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-qat | 38 ++++++++++------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
index a600531e9562..741d97fa5ae1 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -8,12 +8,12 @@ Description:	Reports the current state of the QAT device and allows to
 		This attribute is RW.
 
 		Returned values:
-			up: the device is up and running
-			down: the device is down
+		up: the device is up and running
+		down: the device is down
 
 		Allowed values:
-			up: initialize and start the device
-			down: stop the device and bring it down
+		up: initialize and start the device
+		down: stop the device and bring it down
 
 		It is possible to transition the device from up to down only
 		if the device is up and vice versa.
@@ -30,16 +30,12 @@ Description:	Reports the current configuration of the QAT device and allows
 		This attribute is RW.
 
 		Returned values:
-			sym;asym:	the device is configured for running
-					crypto services
-			dc:		the device is configured for running
-					compression services
+		sym;asym:  the device is configured for running crypto services
+		dc:        the device is configured for running compression services
 
 		Allowed values:
-			sym;asym:	configure the device for running
-					crypto services
-			dc:		configure the device for running
-					compression services
+		sym;asym:  configure the device for running crypto services
+		dc:        configure the device for running compression services
 
 		It is possible to set the configuration only if the device
 		is in the `down` state (see /sys/bus/pci/devices/<BDF>/qat/state)
@@ -47,14 +43,14 @@ Description:	Reports the current configuration of the QAT device and allows
 		The following example shows how to change the configuration of
 		a device configured for running crypto services in order to
 		run data compression:
-			# cat /sys/bus/pci/devices/<BDF>/qat/state
-			up
-			# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
-			sym;asym
-			# echo down > /sys/bus/pci/devices/<BDF>/qat/state
-			# echo dc > /sys/bus/pci/devices/<BDF>/qat/cfg_services
-			# echo up > /sys/bus/pci/devices/<BDF>/qat/state
-			# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
-			dc
+		# cat /sys/bus/pci/devices/<BDF>/qat/state
+		up
+		# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
+		sym;asym
+		# echo down > /sys/bus/pci/devices/<BDF>/qat/state
+		# echo dc > /sys/bus/pci/devices/<BDF>/qat/cfg_services
+		# echo up > /sys/bus/pci/devices/<BDF>/qat/state
+		# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
+		dc
 
 		This attribute is only available for qat_4xxx devices.
-- 
2.36.1

