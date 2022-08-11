Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF1F58F674
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiHKDlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiHKDlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:41:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D476C76B;
        Wed, 10 Aug 2022 20:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660189280; x=1691725280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IhRcMxs48MRd6o5zhtgL0HKWqHEawUSuUlG+92FojtE=;
  b=A6inff8yAEZN+rsuIwvrN1FaNso3DqF1GlzwYBmgzvFHWmPMeWjrIdcD
   D4xh4RZ3Pb6oAtR6emYpYExtzJ/XWLAg78SoJCCZabeWebF0Gn5H6/8tg
   TkjYc6qPUT51KaFRr7INXNCaMFmKPyk91eQv3XtbsdHcs303SBlAniaOP
   Yy8geNmX7no721EVdPQTZcZBPm+uEVUBMGmqiGEqjYNNs5sjaGa/VCVgc
   4GYvHyfDRt+Q1KsrftA6DRja6XFsDXJPkFGMCk2EmkJHE2VByot58Xqmm
   wg0kahsId+ervcGhnSDny9FAMOPKSl489+MVYL3ZuQ8ar/75YZWXcu9I/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="291249556"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="291249556"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 20:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="673533615"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2022 20:41:18 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLz4Q-00013Y-0g;
        Thu, 11 Aug 2022 03:41:18 +0000
Date:   Thu, 11 Aug 2022 11:41:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikhail Khelik <mkhelik@cisco.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-doc@vger.kernel.org
Subject: [hverkuil-media-tree:hdcp 1/4] htmldocs:
 Documentation/output/videodev2.h.rst:6: WARNING: undefined label:
 v4l2-event-hdcp-status (if the link has no caption the label must precede a
 section header)
Message-ID: <202208111154.lpAXlMNe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git hdcp
head:   da521c491aa5d01b7a920ef66c8d9aef36f14a02
commit: 53bddd8330386202cfeae0ebf555e2a6b95ddafe [1/4] HDCP api designed
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-status (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-stage1done (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-stage2done (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hpcp-err (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-err-badbksv (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-err-pimismatch (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-err-pjmismatch (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-err-io (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-err-reptimeout (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-err-maxcascade (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-err-shamismatch (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-event-hdcp-err-maxdev (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2_g_hdcp_tx_data (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2_s_hdcp_rx_data (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2_g_hdcp_rx_data (if the link has no caption the label must precede a section header)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
