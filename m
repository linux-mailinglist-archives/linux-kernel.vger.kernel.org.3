Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13B04E68C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352739AbiCXSiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiCXShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:37:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD65B8211
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:36:18 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F6121EC059E;
        Thu, 24 Mar 2022 19:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648146977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=FmIEnU2hXriloAXlm2b+2Muiw37M9fgpRSLXwj7bmYo=;
        b=B/+obV8OkNzd4niuHL2xgf5NKFFca++KlDdB4Y4g5HGKQm2CWQwii32H6fRQKA2LmNj9t3
        ZcEb2fD2kbkNv2YDdKW/3TNPbnpqicdXf3E8sqolkBgSGF7g0SvDnVoQGYK55ejtFD6SMF
        Iiq2pV70dHzPXxIgZ/CVSXRLZIf0KMA=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Some trivial noinstr fixes
Date:   Thu, 24 Mar 2022 19:36:04 +0100
Message-Id: <20220324183607.31717-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here are some trivial noinstr fixes which sprang up from recent clang
allmodconfigs.

Thx.

Borislav Petkov (3):
  task_stack, x86/cea: Force-inline stack helpers
  x86/kvm/svm: Force-inline GHCB accessors
  x86/mm: Force-inline __phys_addr_nodebug()

 arch/x86/include/asm/cpu_entry_area.h | 2 +-
 arch/x86/include/asm/page_64.h        | 2 +-
 arch/x86/include/asm/svm.h            | 8 ++++----
 include/linux/sched/task_stack.h      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.35.1

