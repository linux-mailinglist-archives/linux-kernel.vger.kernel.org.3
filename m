Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEFD51C0B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379546AbiEENdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379536AbiEENdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:33:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E2B21
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651757414; x=1683293414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B2BbQ2fTzBiSnoi8stMfX33JiZBCHAwXKd2fZWJjztQ=;
  b=hGA2GdRRTZ3d1cPDdHiPZsIJX+oJfPt14C86SdWrriCheDAe4EE4IaAZ
   JJlXgQCdiVvM2tCRLaSFWa920f8pPjT0G8wFClokaxmdlquknXz9Cjw+y
   XwzsK15iv3zqhPKiDux4tOGemIJjcbFgaer+VU5MV45QcmDbD2smJdram
   oDKNQ+WS8y3fJQJ66jIYdZLNqewg5pmXDZIf9gIB08lXj9symlK9SvNLp
   L5nMaoa7+al21AGtAuAse/NuN/XjzgcElxA4dP9Qw7MgUcT1G2ASZczWc
   YsDV8uwXVsjCZs5Sy8p/G2TniGxqz1tKN48z21SxRMvaMU7edThNe0/up
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268257580"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="268257580"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 06:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="694654601"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 06:30:13 -0700
From:   Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [PATCH] mailmap: add entry for martyna.szapar-mudlaw@intel.com
Date:   Thu,  5 May 2022 15:26:26 +0200
Message-Id: <20220505132624.41802-1-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate linux.intel.com account was created for submitting
and reviewing kernel patches, thus need to map previously used
primary Intel e-mail address.

Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 93458154ce7d..36a275ab8c52 100644
--- a/.mailmap
+++ b/.mailmap
@@ -249,6 +249,7 @@ Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
+Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
 Mathieu Othacehe <m.othacehe@gmail.com>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
-- 
2.31.1

