Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4554B52B2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiERG5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiERG4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F6211C23;
        Tue, 17 May 2022 23:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76A2760DEF;
        Wed, 18 May 2022 06:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3444C385A5;
        Wed, 18 May 2022 06:56:44 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     geert@linux-m68k.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 0/3] m68k: build fixes and cleanup
Date:   Wed, 18 May 2022 16:56:36 +1000
Message-Id: <20220518065639.2432213-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series is primarily to fix the build problem reported by
the kernel build robot for undefined references to "mach_set_rtc_pll"
and "mach_get_rtc_pll".

I noticed a couple of other problems along the way, so patches 2 and 3
are an additional cleanup and fix. Geert can you shed any light on what
the changes in patch 2?

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

---
 arch/m68k/kernel/setup_mm.c     |    2 --
 arch/m68k/Kconfig.cpu           |    2 +-
 arch/m68k/hp300/config.c        |    7 -------
 arch/m68k/include/asm/machdep.h |    1 -
 arch/m68k/kernel/setup_mm.c     |    7 -------
 arch/m68k/kernel/setup_no.c     |    1 -
 arch/m68k/kernel/time.c         |    9 +++++++++
 arch/m68k/q40/config.c          |    7 -------
 8 files changed, 10 insertions(+), 26 deletions(-)


