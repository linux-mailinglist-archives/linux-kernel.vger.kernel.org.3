Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE493596FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiHQNLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239953AbiHQNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:11:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F017232
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660741869; x=1692277869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nF9a1ygfaxp2mCx1j2qib7Mrnc7Es43ARNyD+iFbnpk=;
  b=AkqXEn8KO2L/JkxbJvlUKMUU6GGxkqAniF6v377hiIgNn7QtsBYJCYoP
   TfzOZ/dKgfTKSXw6pMyD6rJ5ov0fkYh6kcOuL0jcxaejhFV8KVMF3ieRN
   gCPpM8U0E/QST6nSVuFRhd7yjYrUuRK62Jzjn93GZDCP54T8UtNM19YAl
   VwZZlfbCjkqQq6vsYEWBAbVL5vJYCjfHJoN2J/GXwrpygY5EcjozlXx6F
   Yg3V7vjEwlUKu8PuTJxbl1g2ABhlGo4t90IfLLqq307TcqZNNmiDSuLNS
   fQibEdw0VBL0yUo+rWToL6R8Bz5yAXcV/GlP188MTdFCkNRaSzesV8FXJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378779124"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="378779124"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="667609938"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2022 06:11:08 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 0/4] ALSA: hda: Minor cleanups
Date:   Wed, 17 Aug 2022 15:11:33 +0200
Message-Id: <20220817131137.3978523-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

Amadeusz Sławiński (4):
  ALSA: hda: Move stream-register polling macros
  ALSA: hda: Rework snd_hdac_stream_reset() to use macros
  ALSA: hda: Remove unused MAX_PIN_CONFIGS constant
  ALSA: hda: Remove unused defines

 include/sound/hdaudio.h     |  6 ++++++
 include/sound/hdaudio_ext.h |  6 ------
 sound/hda/hdac_stream.c     | 27 +++++++--------------------
 sound/pci/hda/hda_intel.c   |  7 -------
 sound/pci/hda/hda_sysfs.c   |  2 --
 5 files changed, 13 insertions(+), 35 deletions(-)

-- 
2.25.1

