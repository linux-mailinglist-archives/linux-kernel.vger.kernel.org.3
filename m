Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5A530F45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiEWMJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiEWMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:09:12 -0400
Received: from mail.wantyapps.xyz (unknown [66.135.5.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD001035
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:09:09 -0700 (PDT)
Received: from localhost (bzq-79-178-31-184.red.bezeqint.net [79.178.31.184])
        by mail.wantyapps.xyz (Postfix) with ESMTPSA id B998A7D6E9;
        Mon, 23 May 2022 12:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
        s=mail; t=1653307748;
        bh=fspKiwxxuPX+v3E0D/pDAqxY75F4arubFcSemgV83qY=;
        h=From:To:Cc:Subject:Date:From;
        b=YAG5VRg96d+WWrde9vMKY8XWujPnX1teD51eQw0Qj9x2jfuuv2U1A6H7hNxJ4oCEe
         qBgr/F0J1Sb06zooHnSeosU2wwEblPvL1XTANcaUuQqIZhRqqxcGxzCI3c+3+Y1KZU
         Pjk7RuhMyp2IQCpZKbw4BvkSQiUy0L1A8YgbtqKSIr5tQbL6IzRMQzm8NXxAcPD9ee
         0sSC3lblGgIlPCwufy4c1Ae5lTe6y0m8tVcLQuCek7VSIrh3MDLMq/4/mdiA2OFYfo
         WA+e00dfX+Yrh+iSnZurwUzdWVkUOeMVA3ZFYIKuEAVyPdwoyyV7XsDZP9LszbCWPm
         3NgxcBusk4qFw==
From:   Uri Arev <me@wantyapps.xyz>
Cc:     Uri Arev <me@wantyapps.xyz>, Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: greybus: Fix indentation in fw-management.c
Date:   Mon, 23 May 2022 15:08:57 +0300
Message-Id: <20220523120857.8476-1-me@wantyapps.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Checkpatch:
CHECK: Alignment should match open parenthesis

-Uri

Signed-off-by: Uri Arev <me@wantyapps.xyz>
---
v2: More understandable title, add Signed-off-by line

 drivers/staging/greybus/fw-management.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
index 687c6405c65b..3342b84597da 100644
--- a/drivers/staging/greybus/fw-management.c
+++ b/drivers/staging/greybus/fw-management.c
@@ -102,7 +102,7 @@ static struct fw_mgmt *get_fw_mgmt(struct cdev *cdev)
 }
 
 static int fw_mgmt_interface_fw_version_operation(struct fw_mgmt *fw_mgmt,
-		struct fw_mgmt_ioc_get_intf_version *fw_info)
+						  struct fw_mgmt_ioc_get_intf_version *fw_info)
 {
 	struct gb_connection *connection = fw_mgmt->connection;
 	struct gb_fw_mgmt_interface_fw_version_response response;
@@ -240,7 +240,7 @@ static int fw_mgmt_interface_fw_loaded_operation(struct gb_operation *op)
 }
 
 static int fw_mgmt_backend_fw_version_operation(struct fw_mgmt *fw_mgmt,
-		struct fw_mgmt_ioc_get_backend_version *fw_info)
+						struct fw_mgmt_ioc_get_backend_version *fw_info)
 {
 	struct gb_connection *connection = fw_mgmt->connection;
 	struct gb_fw_mgmt_backend_fw_version_request request;
@@ -473,7 +473,7 @@ static int fw_mgmt_ioctl(struct fw_mgmt *fw_mgmt, unsigned int cmd,
 			return -EFAULT;
 
 		ret = fw_mgmt_backend_fw_update_operation(fw_mgmt,
-				backend_update.firmware_tag);
+							  backend_update.firmware_tag);
 		if (ret)
 			return ret;
 
-- 
2.36.1

