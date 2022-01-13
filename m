Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D78048D620
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiAMKzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:55:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:24894 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbiAMKzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642071319; x=1673607319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R3MYWlXynIaGjskSt5vMg9we9n9h7ANzXPm+IB8MvMI=;
  b=UTA9n7NwNOS5wHvb199yGex6YWGIkOQqxf2QVQLi2gXPWe+YkJ4tMN0A
   rGPYfJTOU1K2RYgToATYnarIxc6FG08c5BXMEe+tX76mTDFAM5v/K/T5m
   pmwc8hm70vhHrhq/q3w0uXOyFyM1lsuxUVXs63+OZHPv0dK6jUBt0dlwd
   xvHYBSnKKpwI/RFQrUdYXtj7nvRpJjbb/72KOg6axqo2hJTrbZjPfubwn
   noJKcBAtfLebAtLKjxDFSHMop2ST8/gPXvAKjvvgTo3Bmi47CMfFhLb+V
   0i1lr4mYzP/3EVInHn+LpQucUMBnNsmkoy5JfDPQTMGYACrY6f3u+qSRD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307330236"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307330236"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475267030"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 02:55:17 -0800
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>, Brent Lu <brent.lu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ALSA: hda: intel-dsp-config: add JasperLake support
Date:   Thu, 13 Jan 2022 18:52:18 +0800
Message-Id: <20220113105220.1114694-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support JasperLake Chromebooks and fix a order issue in config table.

v2:
  - rebase to Takashi's tree
  - add a fix for config table

*** BLURB HERE ***

Brent Lu (2):
  ALSA: hda: intel-dsp-config: add JasperLake support
  ALSA: hda: intel-dsp-config: reorder the config table

 sound/hda/intel-dsp-config.c | 43 +++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 13 deletions(-)

-- 
2.25.1

