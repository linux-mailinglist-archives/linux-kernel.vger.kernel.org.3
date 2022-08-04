Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7981589584
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiHDA6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiHDA6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:58:51 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091E35F12C;
        Wed,  3 Aug 2022 17:58:45 -0700 (PDT)
X-QQ-mid: bizesmtp90t1659574704tkggsjv3
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 08:58:23 +0800 (CST)
X-QQ-SSF: 01000000000000F0U000000A0000020
X-QQ-FEAT: CEO3k+BsRkI2wgkrQuyb4CGqAgm+zWPjDU8YtgV6mETOqi2a4hHPybfTbGOUO
        RDXleSQjac3FsKb1EdAOehKpJVyUGNhZjhRnSosMRvWFh9Cr1J9G2k/deRXOOfbID3GtzPe
        eECxDljfJVvxYQHos9ZTbhW/mdOV/Q5vv4xejy/XJ5bUYwy+DWQB91/HgWNTw8KvAfzM0fJ
        N20wf6z4ciF2BCocRGLEkSlvnYxD/wL6HGNfn7I2nAkIk8FC4LdKOz7FsHi7R+oABL3XzfC
        RL1MjEBUW9AJHDeY6ifxYz6OmHtY6TxEUn+Q9GIlGwVvKFN07Pmo/LCSYRFMQhszj11aa2D
        sm+PEO+QHht3lSY01Oc5PIJ0y1iSA==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jikos@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] HID: ishtp-hid-clientHID: ishtp-hid-client: Fix comment typo
Date:   Thu,  4 Aug 2022 08:58:14 +0800
Message-Id: <20220804005814.5444-1-wangborong@cdjrlc.com>
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

The double `like' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.h b/drivers/hid/intel-ish-hid/ishtp-hid.h
index 6a5cc11aefd8..35dddc5015b3 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.h
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.h
@@ -105,7 +105,7 @@ struct report_list {
  * @multi_packet_cnt:	Count of fragmented packet count
  *
  * This structure is used to store completion flags and per client data like
- * like report description, number of HID devices etc.
+ * report description, number of HID devices etc.
  */
 struct ishtp_cl_data {
 	/* completion flags */
-- 
2.35.1

