Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D606570861
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiGKQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGKQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:30:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8221BE94;
        Mon, 11 Jul 2022 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657557017; x=1689093017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M7gQthUQ8v0LKr/DjxFP5tYXmCHQe3FMOrvQefnZBAQ=;
  b=LtMk+DtscddZ7bXbLNwXgG3JsJc5kNcsh94PKXnkGgFNUif+lB1wjc+0
   ExcO7HqYcuUDu9WJkjMiS2BCkOmGFXZO6c6I8SDKe5VkxLLbNaLKo7Yqx
   fX2+UJy5BRXK1ez37lOiQW3jXYANpx0Oz0U6bUuA6OCVWqo5Xj37tQd/k
   B3kcQgvhEMk4XEZD0xbiPb0FymJy2nYdO0mfwuS2cvJgfp1nBMc4rfomf
   3I25UJ+r5mrsk9bOQN92lQ47Q8yeI5bNnCJ+6V++61pq6suJLO9LRsJjp
   qa0Yn/ZFQ19oQtRYm+u6Dl+q0aaBXG2Lkxi2IljtiaHRuR2YR9eIdGJs3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="282257602"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="282257602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 09:29:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="921846535"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 09:29:49 -0700
Date:   Mon, 11 Jul 2022 17:29:39 +0100
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
Subject: Re: [PATCH RESEND] crypto: qat - fix indentation in ABI documentation
Message-ID: <YsxP5n0rjUaX0mL8@silpixa00400314>
References: <202207090803.TEGI95qw-lkp@intel.com>
 <YsvuJsjxEjp/LHZa@silpixa00400314>
 <CAMusb+QfUZwq+JRkUrOLGO7mQLZbg_ueFVo2_PTSiSRiq7BoEA@mail.gmail.com>
 <YsxJnq32lAJIRSET@silpixa00400314>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsxJnq32lAJIRSET@silpixa00400314>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 05:05:18PM +0100, Giovanni Cabiddu wrote:
> On Mon, Jul 11, 2022 at 02:35:07PM +0200, Vlad Dronov wrote:
> > Hi,
> > 
> > On Mon, Jul 11, 2022 at 11:32 AM Giovanni Cabiddu
> > <giovanni.cabiddu@intel.com> wrote:
> > >
> > > On Sat, Jul 09, 2022 at 08:23:35AM +0800, kernel test robot wrote:
> > ...skip...
> > > > >> Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.
> > > >
> > > > vim +24 Documentation/ABI/testing/sysfs-driver-qat
> > > >
> > > >   > 24        Date:           June 2022
> > > I'm not able to spot what the issue is. Any suggestions?
> > 
> > Same here. I do not see what issue the test robot is reporting.
> I found what the issue is. It seems Sphinx doesn't like the extra
> indentation in the sections.

Resending including linux-crypto. Apologies for the duplicate.

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

