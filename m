Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7946532C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbhLAQsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:48:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:26294 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351603AbhLAQrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:47:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216512478"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="216512478"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:15 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="512783922"
Received: from razaahme-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.36.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:08 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [RFCv3 0/7] USI stylus support series
Date:   Wed,  1 Dec 2021 18:42:54 +0200
Message-Id: <20211201164301.44653-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another update here based on received feedback. Main change compared to v2:

- Dropped patch #5 : HID: core: map USI pen style reports directly
  This is not needed anymore, as the same result can be reached by
  modifying the flags of the relevant field in rdesc. This is done now
  as part of patch #7 in the BPF code.

I also dropped one of the fixes from my test branch [1] as pointed out
by Benjamin, it is not needed if the BPF program is executed with the
modalias link.

Updated test branch can be found from [2].

-Tero

[1]
https://github.com/t-kristo/linux/commit/81b27fd46780ce67c2706d586c0f4a437e87dbf6
(HID: bpf: fix file mapping)
[2] https://github.com/t-kristo/linux/commits/usi-5.16-rfc-v3-bpf


