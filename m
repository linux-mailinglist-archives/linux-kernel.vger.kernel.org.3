Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A16D51C657
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382799AbiEERoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382782AbiEERno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:43:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE74C5BD30;
        Thu,  5 May 2022 10:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81117B82E15;
        Thu,  5 May 2022 17:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177E8C385C9;
        Thu,  5 May 2022 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651772401;
        bh=cpQMmbRVdDBMeuI5w6SyoGllIexfXaT+hvXuJPkJ0rE=;
        h=Subject:To:From:Date:From;
        b=fmJYRjOeNzbiQDIhsV87ddjKMnPXufI6koKm+QksbT0YlpRsV+8EIPerfGsfklkab
         FBQcUbd84dWAQrR9kq73l+rkBeiA+pSGYhgJB7p3VgGRrEl6d1H82N5lpzJFx8v55x
         LOYoTBCw6VRb0zeE9VgL6kBekQ2+RPhvg3i7NcU0=
Subject: patch "firmware_loader: describe 'module' parameter of" added to driver-core-next
To:     bagasdotme@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        mcgrof@kernel.org, rafael@kernel.org, russell.h.weight@intel.com,
        sfr@canb.auug.org.au
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 05 May 2022 19:35:25 +0200
Message-ID: <16517721257181@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    firmware_loader: describe 'module' parameter of

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 6370b04f24bc10c1f2056c0f12dd651ac0121a6f Mon Sep 17 00:00:00 2001
From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Mon, 2 May 2022 12:14:56 +0700
Subject: firmware_loader: describe 'module' parameter of
 firmware_upload_register()

Stephen Rothwell reported kernel-doc warning:

drivers/base/firmware_loader/sysfs_upload.c:285: warning: Function parameter or member 'module' not described in 'firmware_upload_register'

Fix the warning by describing the 'module' parameter.

Link: https://lore.kernel.org/linux-next/20220502083658.266d55f8@canb.auug.org.au/
Fixes: 97730bbb242cde ("firmware_loader: Add firmware-upload support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20220502051456.30741-1-bagasdotme@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/firmware_loader/sysfs_upload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 8cdcf3516c7e..87044d52322a 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -266,6 +266,7 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
 
 /**
  * firmware_upload_register() - register for the firmware upload sysfs API
+ * @module: kernel module of this device
  * @parent: parent device instantiating firmware upload
  * @name: firmware name to be associated with this device
  * @ops: pointer to structure of firmware upload ops
-- 
2.36.0


