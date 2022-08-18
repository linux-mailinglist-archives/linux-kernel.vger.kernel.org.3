Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815B598580
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbiHROOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiHROOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:14:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A8A861CC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660832083; x=1692368083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZhOBlyLmWbCSd5npf+S55l4gbzaVMkSPYKPfp8DWzD0=;
  b=V7tRDdHu+OFEm1E2/JG3ZheHVgL0J+4iQkLWyJzQtor8Nsj2NdcEWrT7
   Jl7yDRKwgA1D7Ll+3voHrolG6q70Tg9ISkwx55iYLk2v9OMWfPqERKEzu
   cJgNT5QBcjGzLl6pP+/9x0yqf7EGD3n0NkLpRH7fWompZoAsKITp4ITbK
   0dlY51aNjfQYazXLIXUmzj+4gpYKfgkl+4fQg6cbvy8vlDbi1LrI7F9fS
   Mfx7yZrJSsv0mEYGtQgSAFpheU5D6JrGjYWGn91MYjzci/NifnX2Z49ky
   Y3v/MtDvzcSkzAcPYJRad2VSqLirDn5vIBks8SW1P07GqqFFPrr0457qK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="272533249"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="272533249"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 07:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="584222210"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2022 07:14:41 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 0/4] hda: Minor cleanups
Date:   Thu, 18 Aug 2022 16:15:13 +0200
Message-Id: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First two patches are small refactoring of code to use poll macros
instead of open coding register checks.
Following two patches remove unused defines from code.

v2:
 * Fix includes

Amadeusz Sławiński (4):
  ALSA: hda: Move stream-register polling macros
  ALSA: hda: Rework snd_hdac_stream_reset() to use macros
  ALSA: hda: Remove unused MAX_PIN_CONFIGS constant
  ALSA: hda: Remove unused defines

 include/sound/hdaudio.h     |  7 +++++++
 include/sound/hdaudio_ext.h |  6 ------
 sound/hda/hdac_stream.c     | 26 ++++++--------------------
 sound/pci/hda/hda_intel.c   |  7 -------
 sound/pci/hda/hda_sysfs.c   |  2 --
 5 files changed, 13 insertions(+), 35 deletions(-)

-- 
2.25.1

