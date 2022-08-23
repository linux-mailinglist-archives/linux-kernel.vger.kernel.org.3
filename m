Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3C959CED1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbiHWCy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbiHWCyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:54:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741F05A820;
        Mon, 22 Aug 2022 19:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ay5mWJCmRao7orkUjcgnlnNdFTL0xSDJ9G/Iykn7rLc=; b=jEdU0n8DZrItE9k0wgMsfS2s/r
        SylBlFWfHU9u1KX3+0m0F4veo5BMClzbJFErTbOIxKoUunFiQ2ZSUD8dUhjsL/XlTYmrnTlNGDpaJ
        rvNOSy8iT/uk5CvM5VOvpP7uNje0aRzgz1zns9ODu1QQx9mbeFQZ5Vube+AaEbd/b8+jQ3UL2hqeV
        d2T/bmWR4hCLBQcrPKOkV6K691grwlSOKtOMKkR2DZ6oPaXSrKaVbqypEAEUQ2weRIiOUKV7Gn/wj
        1j2GDy7QDfQ6f5mGSpp7phyDoa5JArGGIPX2npfSjSf/gYd+DAvxzqn+OhYkOlX0zrE6r+TMXIz1P
        lNOqVXGw==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQK3z-00Et5w-K4; Tue, 23 Aug 2022 02:54:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: [PATCH] MIPS: ath25: clean up non-kernel-doc comment warning
Date:   Mon, 22 Aug 2022 19:54:41 -0700
Message-Id: <20220823025441.30708-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use "/**" kernel-doc notation for comments that are not in
kernel-doc format.

Eliminates one warning:

arch/mips/pci/pci-ar2315.c:6: warning: This comment starts with
  '/**', but isn't a kernel-doc comment. Refer
  Documentation/doc-guide/kernel-doc.rst
    * Both AR2315 and AR2316 chips have PCI interface unit, which supports DMA

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
Fixes: 3ed7a2a702dc ("MIPS: ath25: add AR2315 PCI host controller driver")
  but backport is not needed.

 arch/mips/pci/pci-ar2315.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -2,7 +2,7 @@
 /*
  */
 
-/**
+/*
  * Both AR2315 and AR2316 chips have PCI interface unit, which supports DMA
  * and interrupt. PCI interface supports MMIO access method, but does not
  * seem to support I/O ports.
