Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7FC589595
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 03:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbiHDBGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 21:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbiHDBGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 21:06:40 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59EB19011;
        Wed,  3 Aug 2022 18:06:35 -0700 (PDT)
X-QQ-mid: bizesmtp71t1659575187t85ngeye
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 09:06:26 +0800 (CST)
X-QQ-SSF: 01000000000000F0U000000A0000020
X-QQ-FEAT: 5x8Sgf4S6/gZdUNzdZEwCXFiaZbSU2QaoxikrzE53hiZI0w4SO/NwC76gzrgV
        Mb/HPALeSz0xmdjYVEenDSDi0FkH5q7W3ezT7aaqYjPI2lPI1Si/JgjmYUVId/5zgSWzLNJ
        GN61NEq+UOuNLyfuGbbQyfu9BEoSX71qIh4X6moVtWqmxda+rdMpRarrGYTm0HgW2SHUeFp
        Yj2eTVoaRTOvfhUzy+BKYkRsXZeWzMWPRqraNHyRSuvjW6kf2OuUyEFs7pfb96dq8O7Sngj
        JpeR2uSVu34czeir9vnddYF38FltUVyWK2fqEMgrMwoMKd0KwipFuO1Esd1mgXIdo+n6EfM
        pWNtHjMTZ2psYFcG3UpxSAuDxmQBytzwVgxRngBzV7CCwREf0w=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     sreekanth.reddy@broadcom.com
Cc:     sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: message: fusion: Fix comment typo
Date:   Thu,  4 Aug 2022 09:06:10 +0800
Message-Id: <20220804010610.5690-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `only' is typo in the comment, replace the second to `on'.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/message/fusion/mptbase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 9b3ba2df71c7..86e7510d7614 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -518,7 +518,7 @@ mpt_reply(MPT_ADAPTER *ioc, u32 pa)
 
 	/* Map DMA address of reply header to cpu address.
 	 * pa is 32 bits - but the dma address may be 32 or 64 bits
-	 * get offset based only only the low addresses
+	 * get offset based only on the low addresses
 	 */
 
 	reply_dma_low = (pa <<= 1);
-- 
2.35.1

