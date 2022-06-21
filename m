Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14873552E89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349112AbiFUJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348833AbiFUJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:37:15 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDCA275C6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:37:07 -0700 (PDT)
X-QQ-mid: bizesmtp67t1655804223tju3ecfs
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 17:36:58 +0800 (CST)
X-QQ-SSF: 0100000000700030B000B00A0000000
X-QQ-FEAT: B0D4DPF8NcR5GZuJ2U5q3wJIJFnHVmNBA3+lnkqt0BNqvCom4ybXtKDqOCQ6v
        HQF96ApE8ce8LKYJnvG67ckRGM2RPxVVBquJRlcXjIiz9kFhEQjb3zzGLy1uPVr9R2Jv8qA
        ITejeTggLFSq44emH0LBWZJh7d4L+8RBvc4FCfXtyXLqG9Ol9dwKAu27J4h1TQ9g2Tsjp1Z
        B/e+k2o+hep+HvOWMup6UtjiMSfiKIuHU6mlH6CURjxCOnFZPz9qD7oPrEXSMWPSgvOEZ0u
        zCdb6Q1DQisuLWA5ZcA8lTLh/nHSZsEZ4RmNN6lVEdTfXqW0H+B+PAz27Sc/kHQ/HAfma7A
        9xSvEiE4fDik6e3wcY=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, jiangjian@cdjrlc.com
Subject: [PATCH] ubi: remove unexpected word "the"
Date:   Tue, 21 Jun 2022 17:36:56 +0800
Message-Id: <20220621093656.73074-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be removed

* @dev: device object to make use of the the Linux device model
* @dev: UBI device object to use the the Linux device model

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/mtd/ubi/ubi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 078112e23dfd..d9039e7f6703 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -281,7 +281,7 @@ struct ubi_eba_leb_desc {
 
 /**
  * struct ubi_volume - UBI volume description data structure.
- * @dev: device object to make use of the the Linux device model
+ * @dev: device object to make use of the Linux device model
  * @cdev: character device object to create character device
  * @ubi: reference to the UBI device description object
  * @vol_id: volume ID
@@ -439,7 +439,7 @@ struct ubi_debug_info {
 
 /**
  * struct ubi_device - UBI device description structure
- * @dev: UBI device object to use the the Linux device model
+ * @dev: UBI device object to use the Linux device model
  * @cdev: character device object to create character device
  * @ubi_num: UBI device number
  * @ubi_name: UBI device name
-- 
2.17.1

