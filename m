Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB35577E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiFWKar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiFWKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:30:45 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624F04A3E2;
        Thu, 23 Jun 2022 03:30:41 -0700 (PDT)
X-QQ-mid: bizesmtp87t1655980220tgs2spg2
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:30:16 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000D00A0000000
X-QQ-FEAT: 0Eq+cbWb7RykbQkz594CL+OpPtXFI9VBWbjLZ64okZcXuAB/mi7dxZAF7eoEn
        tLLwY+kL6rR/yFGZGWFJETTpzPIzQiD3nDN+6LQtI+T2r/txxC1MCXkI9vBapvFiIcsgWkT
        TcN/ycOzUO4InStyt73dsMjHWik8Qtwv5vKUaJdQFDISKi3qE4MVc1CiTUuRwIs3ENJ6vNz
        rjHnlfTDWj0jTPQJp7Ow7WErE3HlA2io+NdubIgQMm/M69dO0TYgd3g23r7uM7n89tuMS2V
        yY4e8FJ2WQpHekopUtiAyiRp2RVDL2MnsCJntz4dBB09iKsF5xDbilLtIE2wqayFo/1JDM7
        skQMpj7a1UgjsUTc4wbAqepsdvAyAMm7izKvtax
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     leitao@debian.org, nayna@linux.ibm.com, pfsmorigo@gmail.com,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] crypto: vmx - drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:30:14 +0800
Message-Id: <20220623103014.41269-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/crypto/vmx/ghashp8-ppc.pl
line - 19

"# GHASH for for PowerISA v2.07."

changed to:

"# GHASH for PowerISA v2.07."

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/crypto/vmx/ghashp8-ppc.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/vmx/ghashp8-ppc.pl b/drivers/crypto/vmx/ghashp8-ppc.pl
index 09bba1852eec..041e633c214f 100644
--- a/drivers/crypto/vmx/ghashp8-ppc.pl
+++ b/drivers/crypto/vmx/ghashp8-ppc.pl
@@ -16,7 +16,7 @@
 # details see https://www.openssl.org/~appro/cryptogams/.
 # ====================================================================
 #
-# GHASH for for PowerISA v2.07.
+# GHASH for PowerISA v2.07.
 #
 # July 2014
 #
-- 
2.17.1

