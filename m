Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846D45480B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiFMHic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiFMHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD211BEBE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:38:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655105903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FfuJm+Q1XWElBSQiI3vWBk6AuHcBAeUKJ7DGD16JIU=;
        b=aGxpcWw5aCMJJKYGSsE9wCTuSvY1K3HtbJIfzWrAFS7LCAV2z7Djj9BwTYzSD9fSvmrFYt
        XPIzjmD37LGldN8cjPUSvc7T+Hk+bJEUAf/rMc5j1A2yYzfkP5/Njdvow8hLjLmvFL3T7D
        ANV4yhlVlTHbBMBp3kzcvGTQc5R0dQKQPVcejMtL00rj1O2Y7IE7raCIwPqG85/vY6k1z0
        e5mvLrS322N6VFQsUmhK4S33IP0NN+NasoHAz99PkmCN17IFT1Y3yxryh2xKiRPi1GZm1T
        FXiM8e6L17PeMv2rPnA1uauZA7Ne0Kxl15wVh5zMeYuEzMzra495XkDUngQrSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655105903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FfuJm+Q1XWElBSQiI3vWBk6AuHcBAeUKJ7DGD16JIU=;
        b=+mqzcI4DUAIbUdHSoP7Ow7xBn6328Uh6ESq5vLAyA5R2XxClAwKeE3T1Z84lcMIpod2PsL
        dHtSP48G86djYxCw==
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>
Subject: [PATCH] x86/crypto: Remove stray comment terminator
In-Reply-To: <202206110936.UIMGLIoN-lkp@intel.com>
References: <202206110936.UIMGLIoN-lkp@intel.com>
Date:   Mon, 13 Jun 2022 09:38:23 +0200
Message-ID: <87v8t53te8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the SPDX patch script managed to confuse itself.

Fixes: 2eb72d6696c6 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_179.RULE")
Reported-by: kernel test robot <lkp@intel.com> 
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/crypto/crc32-pclmul_asm.S |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/crypto/crc32-pclmul_asm.S
+++ b/arch/x86/crypto/crc32-pclmul_asm.S
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
- */
-
 /*
  * Copyright 2012 Xyratex Technology Limited
  *
