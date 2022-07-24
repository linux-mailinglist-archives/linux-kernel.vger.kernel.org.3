Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A357F399
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiGXHKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGXHKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:10:32 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0613D11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:10:27 -0700 (PDT)
X-QQ-mid: bizesmtp83t1658646617tjaeqp23
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:10:16 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: 7jw2iSiCazpDLTDr4HOaN8SJ7zetT2RY2zS9DJNDlFgShqayluQZkuTk9rVYG
        eF1lNTbG9EbW4E48abZnaPlsnX3zTUBHLau+d8Z55dx54fMOBMTamppm83BchDEwGqNkm87
        oDjAzdZ90VkFTuXuTGooGQTjd/RR71fp/9OAvDKpKKIf2VHnNE8NPwXcpp/gQkzQJzCi0YO
        iCwALCPvCnOA+mRDhjAZTNFBKIu41VmXf0zkI1WwVCYTzQ1kSR63LgesCIISD9c8+gJcLLP
        5W2yAtIOxaZxuw9pb92j79nWQ/MRwzJ5SukUVe0bA6dK/diZKAEbKtQPAhPpskulI3viNLi
        t5H7Bk+tgONF4RzB/oUTGfQfhv3BHgwPEVR/bpf71LSCcUTE4s=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] pci/asihpi: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:10:09 +0800
Message-Id: <20220724071009.9274-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 sound/pci/asihpi/hpi6205.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 3d6914c64c4a..27e11b5f70b9 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -445,7 +445,7 @@ void HPI_6205(struct hpi_message *phm, struct hpi_response *phr)
 /* SUBSYSTEM */
 
 /** Create an adapter object and initialise it based on resource information
- * passed in in the message
+ * passed in the message
  * *** NOTE - you cannot use this function AND the FindAdapters function at the
  * same time, the application must use only one of them to get the adapters ***
  */
-- 
2.36.1

