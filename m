Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92CA533F88
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244648AbiEYOsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiEYOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:48:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E036CF41
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653490116; x=1685026116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I1J/xn+4QP1J2xa1QkYks2VmwD45ljeamgIxezfJlWI=;
  b=NoPiz+nVPfaYsVgP2u9pZmwfi3ktIqtFLwmk6m+mD3Eunt/39czXE2Lb
   LTq28lIpRc7avcANC5EBQVzB7JNqSye/ftZXGi9NRVb56Z52ryrq7XIIj
   y0k09zfMYYg3vttb62LCrG21mETSMDam31WptT9D3X14uNrCnUSJ0gaLd
   GwWnVb6MfEgofOK4iZVGZ63w6M0b5VAuMu+AHrc38TZKhTYotS8kX2Npg
   HL6QNrgpIHAPEHbN9bJ0GpP90AzFy/1XBYACVmBccpw59u1tFZFMMZ5v8
   jobIaJ6aiKw8nMlp5oGyn2tRNLPo1UQt4Gt60RAkwVIZMSHEWHKV/qAbx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253703386"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="253703386"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 07:48:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="549050137"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2022 07:48:33 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 0/2] bitops: __fls adjustments
Date:   Wed, 25 May 2022 16:48:42 +0200
Message-Id: <20220525144844.1571705-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently on few architectures __fls is defined incorrectly. Fix this
by adjusting declarations to asm-generic ones.

As far as I can tell there should be no functional changes, but I don't
have devices to test it, so it was only compile tested.

Amadeusz Sławiński (2):
  ARC: bitops: Change __fls to return unsigned long
  m68k: bitops: Change __fls to return and accept unsigned long

 arch/arc/include/asm/bitops.h  | 2 +-
 arch/m68k/include/asm/bitops.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

