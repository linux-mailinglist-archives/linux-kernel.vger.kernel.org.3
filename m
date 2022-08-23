Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5719159D091
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbiHWFfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbiHWFe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:34:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959215E54B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232893; x=1692768893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PsN5V3CIeVtDCk84BpPh+cydDpOnRZudvadHlLgeH+8=;
  b=eiBCaDoBdLtFEChKJfhBjVMKd5TPx3JZh2Yi+3uekgY1JYfYyxS3zrPe
   TcUnMTzw97OdJq9/NHSO3jnAafLrRhUUY4RfHgGfRMyFvNfwsaM4cZYgl
   4S9goeI1vtBM8wzQZUvRuIDvpj1LVSX7mVYbr6BAP6YsFFY2oThYtB8vg
   Lw1fmkD99XmPQgj51zH1G4+YU1FYU66PM5YM1+ceoaQ3c4HHdybV6Tjkf
   NTDp8wdDQx1rNVwXE/KLytteZ/0Zc0BLx2ibDcAwFS4wKVgdxvFbZ5xIz
   DrNMkqGnQzWbwTzWxA1i9EvQyYfk5qeNSz408JyLLso9OsVaam1fXGhzk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280568554"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280568554"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698558234"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:50 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 00/11] soundwire: register cleanups
Date:   Tue, 23 Aug 2022 13:38:35 +0800
Message-Id: <20220823053846.2684635-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean-up and reorder/regroup SoundWire SHIM registers.

Pierre-Louis Bossart (11):
  soundwire: intel: cleanup definition of LCOUNT
  soundwire: intel: regroup definitions for LCTL
  soundwire: intel: remove IPPTR unused definition
  soundwire: intel: cleanup SHIM SYNC
  soundwire: intel: remove unused PDM capabilities
  soundwire: intel: add comment for control stream cap/chmap
  soundwire: intel: cleanup PCM stream capabilities
  soundwire: intel: cleanup PCM Stream channel map and channel count
  soundwire: intel: cleanup IO control
  soundwire: intel: cleanup AC Timing Control
  soundwire: intel: cleanup WakeEnable and WakeStatus

 drivers/soundwire/intel.c           |  5 +--
 drivers/soundwire/intel_init.c      |  2 +-
 include/linux/soundwire/sdw_intel.h | 63 +++++++++++++++++------------
 3 files changed, 41 insertions(+), 29 deletions(-)

-- 
2.25.1

