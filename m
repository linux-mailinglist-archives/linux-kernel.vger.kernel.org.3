Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550CD5ADE4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 06:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiIFEHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 00:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIFEHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:07:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BC05509C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 21:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662437252; x=1693973252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ebI/IzYAS89ZIArMGgs5IodGYr+jx9qN+xQUrsrVPvs=;
  b=M/A2GaWN7YbHInYmeUXvvHda0ZlduumjBflPjjoh9kbaI4mUHveFA1Nt
   fDfX4R8Tx7tTltB3I40wGnKlmGa+eoqVZ5uPPAQX03kRHAfPC8G7JbgQi
   GWbLu6qilhpXc00hJSwaF0eWjeNRuDYEj4oyquf/2ncukZGMsy5xoc96C
   S3cLHXmysQh0vHoowqC/0NIaZ4ZgU4DpznfBGUMaY4tcCM5Um5CUyFP2L
   MfVNjFEyM/jLBHjxpsIkW1Zwzu8+V8MDWbRsnS/TgE2oW9oJ4Lh5cNqVN
   M7EAahzjeZ7HDAxmW/O7F4iCrsDQjrFX2i2+PDPy6SY0cG3EUHUqd48bs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276236291"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="276236291"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 21:07:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="644005007"
Received: from rongch2-desk.sh.intel.com (HELO localhost) ([10.239.159.175])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 21:07:21 -0700
From:   Rong Chen <rong.a.chen@intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Marek Vasut <marex@denx.de>, Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: usbc-tusb320: fix kernel-doc warning
Date:   Tue,  6 Sep 2022 12:04:29 +0800
Message-Id: <20220906040430.35896-1-rong.a.chen@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning:
drivers/extcon/extcon-usbc-tusb320.c:19: warning: expecting prototype
for drivers/extcon/extcon-tusb320.c(). Prototype was for TUSB320_REG8()
instead

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Rong Chen <rong.a.chen@intel.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index edb8c3f997c9..41041ff0fadb 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * drivers/extcon/extcon-tusb320.c - TUSB320 extcon driver
  *
  * Copyright (C) 2020 National Instruments Corporation
-- 
2.34.1

