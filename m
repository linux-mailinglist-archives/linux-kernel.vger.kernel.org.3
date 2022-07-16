Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449B5576B86
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 05:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiGPDyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 23:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPDyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 23:54:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33A2ED5E;
        Fri, 15 Jul 2022 20:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657943639; x=1689479639;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kZ9ynVEnzgyabIgMweE3DJ5l93w8y9E+zGrLGoc1QH8=;
  b=QYExSBVa7gU5GUNTudjbfEMD5bKGWDiY5bA5PCPjD1DDESWYFF5SoYtG
   ubF9P6J9Kjs/fV4FPKBELiG77852eChth0ItUtQoBPJ7Ik+Ick/gW4Vgz
   igsludkkOnOYQCrxAjCb+iO4/sKajetKWvemJ46g0PRyzbjQxX9rhCjoc
   oUBR8NHi9vT8ikbn4dlzQD8F4HxL3Yo/iDAxiNeJH6fL5wteAACP1KNBX
   bNTjnpwpToCR3iFhbGY+ukIcKNEyBuyMlmOw7W4YlaqKv1A0jfFW4PU64
   d4wbTLR2/BR0ZvUV+XYozalXQk6WNYwT+C+09CNLm8MI3zh7knfalFT6y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="311614328"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="311614328"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 20:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="923743211"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2022 20:53:57 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCYsO-000178-I5;
        Sat, 16 Jul 2022 03:53:56 +0000
Date:   Sat, 16 Jul 2022 11:52:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-doc@vger.kernel.org
Subject: [mchehab-media-next:master 323/358] htmldocs:
 Documentation/output/videodev2.h.rst:6: WARNING: undefined label:
 v4l2-colorspace-last (if the link has no caption the label must precede a
 section header)
Message-ID: <202207161116.S0RCaz3D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/mchehab/media-next.git master
head:   ca24fef0f2c857b0533f21f9a8a756f9e73d60fb
commit: 718d2153ad0de0c7c0b6891eaa7f9918d68b6d5e [323/358] media: v4l2: Make colorspace validity checks more future-proof
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-colorspace-last (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-xfer-func-last (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-ycbcr-enc-last (if the link has no caption the label must precede a section header)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
